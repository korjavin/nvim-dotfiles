# nvim-dotfiles

My Neovim configuration, migrated from a long-lived Vim config (`~/.vim/vimrc`)
in May 2026. Kept **independent** from the old Vim setup — it lives in
`~/.config/nvim` and shares nothing with `~/.vim`, so both editors can coexist
without influencing each other.

## Install

```sh
git clone <this-repo> ~/.config/nvim
nvim                       # vim-plug bootstraps itself, then run:
:PlugInstall
```

For Go support, after the first `:PlugInstall`:

```vim
:GoInstallBinaries
```

`fzf` is expected from Homebrew (`brew install fzf`); the runtimepath points at
`/opt/homebrew/opt/fzf`.

## Layout

- `init.vim` — the whole config (single file, mirrors the old vimrc structure).
- `tidy.conf` — HTML Tidy config used by the `<leader>ti` mapping.

## Plugin manager

[vim-plug](https://github.com/junegunn/vim-plug). Plugins install under
`~/.local/share/nvim/plugged`. Manage with `:PlugInstall`, `:PlugUpdate`,
`:PlugClean`.

## What changed from the old Vim config

Dropped (no longer used):

- **YouCompleteMe** — was never compiled; revisit Neovim's built-in LSP later.
- **vim-powerline** — deprecated; using the default statusline for now.
- **Snippets** — snipmate / snippetsEmu / SuperTab and `after/ftplugin/*_snippets.vim`.
- **Perl tooling** — compiler, `makeprg`, perltidy, `.pl` autocmds, syntax folding.
- **PHP tooling** — `php -l` lint, `php_sql_query`, and the `.twig`/`.tt`/`.ep` filetypes.

Fixed for Neovim:

- Removed `ttyfast` and `t_Co` (removed in Neovim).
- `visualbell t_vb=` → `set belloff=all`.
- NERDTree is now a declared vim-plug plugin instead of an ad-hoc Vimball dump.
- CtrlP uses the maintained `ctrlpvim/ctrlp.vim` fork.
- Session files use their own paths (`~/tmp/nvim.session`,
  `~/tmp/lastNvimSession.vim`) so they never collide with Vim's.

## Secrets / local settings

Personal API keys and machine-specific settings go in `local.vim`, which is
**gitignored** and sourced by `init.vim` if present — so secrets never enter
git history. Bootstrap it from the template:

```sh
cp local.vim.example local.vim   # then edit in your keys
```
