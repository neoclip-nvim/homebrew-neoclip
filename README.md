# Neoclip

This is a homebrew formula for [neoclip](https://matveyt/neoclip), which is a multi-platform clipboard provider for Neovim. 

Please refer to [the neoclip's documentation](https://github.com/matveyt/neoclip/blob/master/README.md#installation).

## Install
You can install both lua and binaries with [lazy.nvim](https://github.com/folke/lazy.nvim):
``` lua
spec = {
  'matveyt/neoclip',
  build = [[
    export HOMEBREW_NO_AUTO_UPDATE=1
    brew tap neoclip-nvim/neoclip
    brew reinstall neoclip
    ln -sf $(brew --prefix neoclip)/lua/neoclip/*driver* ./lua/neoclip/
  ]]
}
```

## Development
When changing the formula you can test it locally
``` sh
brew uninstall neoclip
brew install --build-from-source neoclip-nvim/neoclip/neoclip --verbose --debug \
&& brew test neoclip
```
And also lint
``` sh
brew audit neoclip --strict --fix
```
## Homebrew Documentation
`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
