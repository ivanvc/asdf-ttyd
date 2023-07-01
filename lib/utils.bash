#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/tsl0922/ttyd"
TOOL_NAME="ttyd"
TOOL_TEST="ttyd -h"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if ttyd is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3-
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url arch os
	version="$1"
	filename="$2"
	os="$(uname -s)"
	arch="$(uname -m)"

	url="$GH_REPO"
	if [ "$os" == "Linux" ]; then
		url="$url/releases/download/$version/ttyd.$arch"
	else
		url="$url/archive/refs/tags/$version.tar.gz"
		filename="$filename.tar.gz"
	fi

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		if [ -f "$ASDF_DOWNLOAD_PATH/CMakeLists.txt" ]; then
			cd "$ASDF_DOWNLOAD_PATH"
			mkdir build && cd build
			cmake ..
			make
			cp ttyd "$install_path"
		else
			cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path/ttyd"
			chmod +x "$install_path/ttyd"
		fi

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
