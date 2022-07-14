#!/bin/bash

yay -S --needed asdf-vm


python

asdf plugin-add direnv
# asdf direnv setup --shell bash --version latest
asdf plugin add nodejs
asdf plugin add python
asdf plugin add java
# asdf plugin add php
