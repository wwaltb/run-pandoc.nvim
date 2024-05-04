# run-pandoc.nvim

A simple plugin I made to compile markdown files in Neovim using
[pandoc](https://github.com/jgm/pandoc)

## Getting Started

### Required dependencies

- [pandoc](https://github.com/jgm/pandoc) 

- A TeX system. I recommend [TeX Live](https://tug.org/texlive/)

### Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
-- init.lua:
{
    'wwaltb/run-pandoc.nvim'
}

-- plugins/run-pandoc.lua:
return {
    'wwaltb/run-pandoc.nvim'
}
```

## Usage

`run-pandoc.nvim` uses it's `run` command to compile the file open in the
current buffer into a pdf. It will output to the same location as the original
file and with the same name.

Using Lua:

```lua
vim.keymap.set('n', '<leader>ff', require("run-pandoc").run, {})
```
