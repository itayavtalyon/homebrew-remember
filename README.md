# homebrew-remember

Homebrew [tap](https://docs.brew.sh/Taps) for [`remember`](https://github.com/itayavtalyon/remember) —
a local CLI personal second brain (SQLite + FTS5).

```bash
brew install itayavtalyon/remember/remember
```

That is shorthand for tapping this repo and installing the formula; Homebrew
adds the tap automatically. The formula builds the release binary from source
(needs `cmake`; no other dependencies) and installs `remember` only. For the
agent skill, run `scripts/install.sh --skill-only` from a clone of the main repo.

Upgrade / uninstall as usual:

```bash
brew upgrade remember
brew uninstall remember
```

## License

The `remember` tool is [MIT](https://github.com/itayavtalyon/remember/blob/main/LICENSE) licensed.
This tap (the formula) is MIT as well.
