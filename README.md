<div align="center">

# asdf-ttyd [![Build](https://github.com/ivanvc/asdf-ttyd/actions/workflows/build.yml/badge.svg)](https://github.com/ivanvc/asdf-ttyd/actions/workflows/build.yml) [![Lint](https://github.com/ivanvc/asdf-ttyd/actions/workflows/lint.yml/badge.svg)](https://github.com/ivanvc/asdf-ttyd/actions/workflows/lint.yml)

[ttyd](https://github.com/tsl0922/ttyd) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add ttyd
# or
asdf plugin add ttyd https://github.com/ivanvc/asdf-ttyd.git
```

ttyd:

```shell
# Show all installable versions
asdf list-all ttyd

# Install specific version
asdf install ttyd latest

# Set a version globally (on your ~/.tool-versions file)
asdf global ttyd latest

# Now ttyd commands are available
ttyd -h
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ivanvc/asdf-ttyd/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ivan Valdes](https://github.com/ivanvc/)
