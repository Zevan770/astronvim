# Project Handover Document: Zev's AstroNvim Config

## Overview

This repository contains a highly customized Neovim configuration, leveraging AstroNvim (v5+) as a base, with a modular plugin system and strong support for NixOS-based development environments. It is intended for power users, especially those working across Linux, macOS, and NixOS systems, and provides a deeply extensible and reproducible Neovim experience.

## Project Structure

- `init.lua` – Main entrypoint, responsible for bootstrapping Lazy.nvim, loading core utilities, and invoking the staged configuration process.
- `lua/` – All core Lua config. Key files and folders:
  - `lazy_setup.lua` – Main Lazy.nvim plugin specification and configuration imports.
  - `polish.lua` – Final setup hooks and custom filetype/clipboard tweaks.
  - `community.lua` – Community plugin imports (AstroCommunity, etc).
  - `snacks_profiler_setup.lua` – Optional profiling using the snacks.nvim plugin, activated when the `PROF` environment variable is set.
  - `os.lua` – Platform-specific config imports (NixOS, Windows, Termux, etc).
  - `plugins/` – User and community plugin specs, organized by topic.
  - `utils/` – Utility functions for search, comments, formatting, folding, etc.
  - `disable.lua` – Used to disable or override unwanted plugin specs.
  - `hack/` – Polyfills and hacks for Vim/Neovim API quirks.
- `plugin/number_toggle.vim` – Vimscript to handle automatic toggling of hybrid and absolute line numbers based on mode/focus.
- `snippets/` – JSON snippets for various languages, used by snippet plugins.
- `nixos/` – Home-Manager and NixOS modules for reproducible environment setup, including language-specific overlays.
- `README.md` – Basic install and usage instructions.
- `note/` – Developer notes and detailed Lazy.nvim plugin specification/configuration explanations in `lazy-nvim-config-guide.md`.
- `flake.nix` – Nix Flake for installing and testing the config in NixOS environments.
- `selene.toml`, `neovim.yml` – Linter and type checker config for Lua/Neovim.

## Key Technologies & Concepts

- **AstroNvim + Lazy.nvim:** Uses Lazy.nvim for managing plugins in a declarative, composable style via Lua tables (see `lua/lazy_setup.lua`). Plugin options should be set via `opts` whenever possible. Use `config` functions only for advanced logic.
- **Plugin Organization:** Plugins are grouped by category (languages, lsp, ui, insert, etc) in `lua/plugins/`. Community plugins are imported first in `community.lua` to allow user overrides.
- **Key Mapping:** Uses Astrocore's table-driven mapping system. Define mappings in plugin specs (`keys`), in Astrocore's `opts.mappings` table, or via direct `vim.keymap.set`. See `note/lazy-nvim-config-guide.md` for mapping strategies.
- **System Clipboard:** Advanced handling for different OSes, including OSC52 for remote systems, Termux, and Windows. See `lua/polish.lua`.
- **NixOS Support:** The `nixos/` folder with `flake.nix` and Home-Manager modules enables fully reproducible setup on NixOS. Devshell provides a standard `nvim` command and symlinks config to the correct paths.
- **Profiling:** Set `$PROF` to a Neovim event name to enable the snacks.nvim profiler during startup.
- **Snippets:** Place custom snippets (JSON format) in the `snippets/` directory.

## Development & Maintenance

- **Adding Plugins:** Add to the appropriate `lua/plugins/` file. Imports are managed via `lua/lazy_setup.lua` using Lazy.nvim's spec system.
- **Disabling Plugins:** Use `lua/disable.lua` to override or disable plugins.
- **Extending for OS:** Add new OS-specific configs in `lua/os/` and update `lua/os.lua` for detection and import.
- **Linting & Type Checking:** Use Selene (`selene.toml`) and `neovim.yml` for Lua code quality and global definitions.
- **Reproducibility:** Use the provided Nix Flake (`flake.nix`) and test environments for exact system builds. See `nixos/testEnv.nix`.
- **Key Reference:** Review and follow conventions described in `note/lazy-nvim-config-guide.md` for plugin spec, lazy loading, and mapping best practices.

## Onboarding Checklist for New Developers

1. Clone the repository and review the `README.md` for basic setup.
2. Read the `note/lazy-nvim-config-guide.md` to understand plugin management and mappings.
3. Explore `lua/lazy_setup.lua` for plugin loading flow and `lua/plugins/` for all plugin specifications.
4. Familiarize yourself with the NixOS setup if using Nix: review `flake.nix`, `nixos/`, and test environments.
5. Use `selene` and `neovim.yml` for maintaining code quality.
6. Review custom snippets in the `snippets/` directory and add new ones as needed.
7. Follow the conventions and comments in each file for extension and maintenance.

## Other Important Notes

- Avoid editing `init.lua` unless absolutely necessary; all extensibility hooks are provided elsewhere.
- Major configuration changes (plugins, mappings, OS support) should be documented in the notes directory.
- If profiling is needed, set the `PROF` env variable before launching Neovim.

---
If additional details are needed for any section, refer to the inline comments in source files and the extensive guide in `note/lazy-nvim-config-guide.md`.
