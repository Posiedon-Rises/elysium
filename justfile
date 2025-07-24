set quiet := true

# List available recipes
list:
    just --list

# Builds the config and discards the output
build:
    nh os build

# Lint the configuration
lint:
    nix fmt .

# Lint the config and build
check: lint build

# Builds the configuration and applies it without saving 
test:
    nh os test
