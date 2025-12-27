# Personal Neovim Configuration

Modern Neovim configuration with Lazy.nvim, LSP support, debugging, testing, and IDE-like features. Optimized for FreeBSD.

Heavily inspired by [ThePrimeagen](https://www.youtube.com/watch?v=w7i4amO_zaE) video as the starting point.

## Features

- **Plugin Manager**: Lazy.nvim (migrated from Packer)
- **LSP Support**: TypeScript, PHP, Python, Rust, Lua, Go
- **Autocompletion**: nvim-cmp with multiple sources
- **Syntax Highlighting**: Treesitter with context display
- **File Navigation**: Telescope, Neo-tree, Harpoon
- **Git Integration**: Fugitive, Gitsigns
- **Testing**: Neotest with PHPUnit, pytest, Go, Jest adapters
- **Debugging**: DAP with PHP, Python, Go, JavaScript support
- **Code Quality**: Conform (formatting) + nvim-lint
- **Theme**: Rose-pine with transparent background

## Prerequisites

### Required
- Neovim 0.9+ (0.10+ recommended)
- Git
- Node.js (for some LSP servers)
- A [Nerd Font](https://www.nerdfonts.com/) for icons

### FreeBSD System Packages
Some tools need manual installation on FreeBSD since Mason doesn't support all platforms:

```bash
# Rust
pkg install rust-analyzer

# Lua
# Build lua-language-server from source: https://github.com/LuaLS/lua-language-server

# Go
pkg install go123
go install golang.org/x/tools/gopls@latest
```

## Installation

1. **Backup existing configuration** (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/nvim.git ~/.config/nvim
   ```

3. **Open Neovim**:
   ```bash
   nvim
   ```
   Lazy.nvim will bootstrap automatically and install all plugins.

4. **Install LSP servers**:
   After plugins are installed, run `:Mason` to verify LSP servers are installed.

## Directory Structure

```
~/.config/nvim/
├── init.lua                 # Entry point - bootstraps Lazy.nvim
├── lazy-lock.json           # Plugin version lock file
└── lua/krizos/
    ├── init.lua             # Loads settings and remaps
    ├── lazy.lua             # Lazy.nvim configuration
    ├── set.lua              # Editor settings
    ├── remap.lua            # Basic keymaps (window navigation)
    └── plugins/             # Plugin specifications
        ├── colorscheme.lua  # Rose-pine theme
        ├── dap.lua          # Debug adapter (PHP, Python, Go, JS)
        ├── editor.lua       # Undotree, zen-mode, autopairs, which-key, toggleterm, copilot
        ├── formatting.lua   # Conform (formatters) + nvim-lint
        ├── git.lua          # Fugitive + gitsigns
        ├── harpoon.lua      # Quick file navigation
        ├── lsp.lua          # LSP + Mason + nvim-cmp
        ├── telescope.lua    # Fuzzy finder
        ├── testing.lua      # Neotest adapters
        ├── treesitter.lua   # Syntax highlighting + context
        └── ui.lua           # Lualine, bufferline, neo-tree, trouble, indent guides
```

## Key Mappings

**Leader key**: `<Space>`

### Window Navigation
| Key | Action |
|-----|--------|
| `<A-h>` | Move to left window |
| `<A-j>` | Move to lower window |
| `<A-k>` | Move to upper window |
| `<A-l>` | Move to right window |

### File Navigation
| Key | Action |
|-----|--------|
| `<leader>pv` | Open file explorer (netrw) |
| `<leader>pf` | Find files (Telescope) |
| `<C-p>` | Git files (Telescope) |
| `<leader>ps` | Grep search (Telescope) |
| `<leader>vh` | Help tags (Telescope) |
| `<A-1>` | Toggle Neo-tree |
| `<leader>e` | Focus Neo-tree |

### Harpoon (Quick File Switching)
| Key | Action |
|-----|--------|
| `<leader>a` | Add file to harpoon |
| `<C-e>` | Toggle harpoon menu |
| `<C-h>` | Jump to file 1 |
| `<C-t>` | Jump to file 2 |
| `<C-n>` | Jump to file 3 |
| `<C-s>` | Jump to file 4 |

### Buffer Management
| Key | Action |
|-----|--------|
| `<leader>b` | Switch buffer (Telescope) |
| `<A-Right>` | Next buffer |
| `<A-Left>` | Previous buffer |
| `<leader>bc` | Close buffer |
| `<leader>bo` | Close other buffers |
| `<leader>bp` | Pin buffer |

### LSP & Code
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `K` | Hover information |
| `<C-k>` | Signature help |
| `<leader>vd` | Open diagnostics |
| `[d` / `]d` | Navigate diagnostics |
| `<leader>ca` / `<A-CR>` | Code actions |
| `<leader>rn` / `<F6>` | Rename symbol |
| `<leader>f` | Format buffer |

### Git
| Key | Action |
|-----|--------|
| `<leader>gs` | Git status |
| `<leader>gd` | Git diff |
| `<leader>gb` | Git blame |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gl` | Git pull |

### Git Hunks
| Key | Action |
|-----|--------|
| `]c` / `[c` | Next/previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |

### Testing
| Key | Action |
|-----|--------|
| `<leader>tn` / `<M-[>` | Run nearest test |
| `<leader>tf` | Run tests in file |
| `<leader>ts` | Run test suite |
| `<leader>tl` | Run last test |
| `<leader>to` / `<M-]>` | Show test output |
| `<leader>tO` | Toggle output panel |
| `<leader>tS` | Toggle summary |
| `<leader>td` | Debug nearest test |

### Debugging
| Key | Action |
|-----|--------|
| `<F5>` | Start/Continue |
| `<F9>` | Toggle breakpoint |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F8>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>du` | Toggle DAP UI |
| `<leader>dt` | Terminate |

### UI & Utilities
| Key | Action |
|-----|--------|
| `<leader>u` | Toggle undotree |
| `<leader>zz` | Zen mode (with numbers) |
| `<leader>zZ` | Zen mode (minimal) |
| `<leader>xx` | Toggle trouble |
| `<leader>xw` | Document diagnostics |
| `<C-\`>` / `<leader>tt` | Toggle terminal |
| `<leader>tf` | Float terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |

## Language Support

### LSP Servers
| Language | Server | Installation |
|----------|--------|--------------|
| TypeScript/JavaScript | ts_ls | Mason (auto) |
| PHP | phpactor | Mason (auto) |
| Python | pyright | Mason (auto) |
| Rust | rust-analyzer | System (`pkg install rust-analyzer`) |
| Lua | lua_ls | System (build from source) |
| Go | gopls | System (`go install golang.org/x/tools/gopls@latest`) |

### Formatters (via Conform)
- **Lua**: stylua
- **PHP**: phpcbf (PSR12)
- **JavaScript/TypeScript**: prettier
- **Python**: black + isort
- **Go**: gofmt + goimports
- **Rust**: rustfmt

### Linters (via nvim-lint)
- **JavaScript/TypeScript**: eslint_d
- **Python**: pylint
- **Go**: golangcilint

> Note: PHP linting is handled by phpactor diagnostics.

## Plugins Overview

### Core
- **lazy.nvim** - Plugin manager
- **lsp-zero.nvim** - LSP framework
- **nvim-cmp** - Completion engine
- **nvim-treesitter** - Syntax highlighting

### Navigation
- **telescope.nvim** - Fuzzy finder
- **neo-tree.nvim** - File explorer
- **harpoon** - Quick file navigation

### Git
- **vim-fugitive** - Git commands
- **gitsigns.nvim** - Git decorations

### Testing & Debug
- **neotest** - Test runner
- **nvim-dap** - Debug adapter

### UI
- **lualine.nvim** - Statusline
- **bufferline.nvim** - Buffer tabs
- **which-key.nvim** - Keybinding help
- **trouble.nvim** - Diagnostics list
- **rose-pine** - Colorscheme

### Utilities
- **undotree** - Undo history
- **zen-mode.nvim** - Distraction-free mode
- **cloak.nvim** - Hide secrets in .env
- **copilot.vim** - AI pair programming
- **toggleterm.nvim** - Terminal integration

## Customization

### Changing Colorscheme
Edit `lua/krizos/plugins/colorscheme.lua` and modify the `ColorMyPencils()` function call.

### Adding Plugins
Create a new file in `lua/krizos/plugins/` with the plugin specification. Lazy.nvim will auto-load it.

### Modifying Keymaps
- Global keymaps: `lua/krizos/remap.lua`
- Plugin-specific: Check the respective plugin file in `lua/krizos/plugins/`

## Troubleshooting

### Check Plugin Status
```vim
:Lazy
```

### Check LSP Status
```vim
:LspInfo
```

### Check Mason Installations
```vim
:Mason
```

### Check Treesitter Parsers
```vim
:TSInstallInfo
```

### Health Check
```vim
:checkhealth
```

## License

MIT
