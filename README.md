# Neoclip

This is a homebrew formula for [neoclip](https://matveyt/neoclip), which is a multi-platform clipboard provider for Neovim. 

Please refer to [the neoclip's documentation](https://github.com/matveyt/neoclip/blob/master/README.md#installation).

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
