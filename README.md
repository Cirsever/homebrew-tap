# Cirsever Homebrew Tap

Homebrew packages maintained by [Cirsever](https://github.com/Cirsever).

## Did Tibo Reset?

A native macOS menu-bar watcher for Tibo's Codex reset signals.

Install and start it:

```bash
brew install Cirsever/tap/did-tibo-reset
brew services start did-tibo-reset
```

Upgrade:

```bash
brew upgrade did-tibo-reset
brew services restart did-tibo-reset
```

Stop and uninstall:

```bash
brew services stop did-tibo-reset
brew uninstall did-tibo-reset
```

The Formula builds locally from an immutable
[Did Tibo Reset Release](https://github.com/Cirsever/DidTiboReset/releases).
Uninstalling preserves alert history, logs, Codex configuration, and backups.
