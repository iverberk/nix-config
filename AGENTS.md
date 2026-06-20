# Agent Guidelines

## Commands
- **Build & Switch System**: `make build-switch` or `nix run .#build-switch` (Auto-detects OS)
- **Install (Linux)**: `nix run .#install`
- **Rollback (Darwin)**: `nix run .#rollback`
- **Lint/Check**: `nix flake check` (if available)

## Code Style
- **Nix**: Standard formatting. Flake-based structure (`nixosConfigurations`/`darwinConfigurations`).
- **Lua (Neovim)**:
  - **Imports**: `require("module")` in `init.lua`.
  - **Plugins**: Imperative style in `lua/plugins/*.lua` (`vim.pack.add` + `setup()`).
  - **Keymaps**: Define a `keymaps` table and iterate with `vim.keymap.set` at file end.
  - **Formatting**: Double quotes (`"`), `stylua` compatible.
  - **Naming**: Snake_case for locals, descriptive variable names.

## Conventions
- **Structure**: Keep configuration modular (split by plugin/functionality).
- **Paths**: Use absolute paths in tool calls; resolve relative paths against project root.
