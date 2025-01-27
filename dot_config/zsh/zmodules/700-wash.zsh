# wash
if [ -x "$(command -v wash)" ]; then
  wash completions -d /tmp/ zsh >/dev/null
  eval "$(/bin/cat /tmp/_wash)"
  rm /tmp/_wash
fi
