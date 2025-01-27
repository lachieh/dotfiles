#! /bin/zsh

if [ -x "$(command -v eza)" ]; then
  alias ls="eza"
  alias ll="eza -al"
fi