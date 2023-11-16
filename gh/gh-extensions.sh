#!/bin/bash

if ! command -v gh &> /dev/null; then
    # Copilot CLI
    # https://docs.github.com/en/copilot/github-copilot-in-the-cli/using-github-copilot-in-the-cli
    gh extension install github/gh-copilot
    gh extension upgrade gh-copilot
fi
