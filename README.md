# natbro/tap

Homebrew formulae by Nathaniel Brown.

```bash
brew install natbro/tap/apfs-compact
```

| Formula | Description |
|---|---|
| [apfs-compact](https://github.com/natbro/apfs-compact) | Replace duplicate and near-duplicate files with APFS clones |

## Updating a formula

After tagging a new release upstream:

```bash
curl -sL https://github.com/natbro/<project>/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256
```

Update `url` and `sha256` in `Formula/<name>.rb`, then:

```bash
brew audit --strict natbro/tap/<name>
brew install --build-from-source natbro/tap/<name>
brew test natbro/tap/<name>
```

Formulae are built from source; there are no prebuilt bottles.
