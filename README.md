# nekonenene/tap

Homebrew formulae that allows installation or updating tools through the [Homebrew](https://brew.sh/) package manager.

## Installation

```sh
brew tap nekonenene/tap
brew install <TOOL_NAME>

# Or install directly
brew install nekonenene/tap/<TOOL_NAME>
```

## Update config

You can update the JSON file in the `configs` directory with the following command.

```sh
ruby update_config.rb configs/git-branch-delete-merged.json
```
