# nekonenene/tap

Homebrew formulae that allows installation or updating tools through the [Homebrew](https://brew.sh/) package manager.

## Installation

```sh
brew install nekonenene/tap/<TOOL_NAME>

# For example
brew install nekonenene/tap/git-branch-delete-merged
```

## Update config

After setting the values in the `inputs` key in the JSON file, You can update the JSON file in the `configs` directory with the following command.

```sh
ruby update_config.rb <JSON_FILE_PATH>

# For example
ruby update_config.rb configs/git-branch-delete-merged.json
```
