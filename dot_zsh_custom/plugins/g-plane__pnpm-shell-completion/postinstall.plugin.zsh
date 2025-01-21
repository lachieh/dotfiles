function pnpm_verify_install {
  local pnpm_comp=$(antidote path g-plane/pnpm-shell-completion)/pnpm-shell-completion
  local installer=$(antidote path g-plane/pnpm-shell-completion)/install.zsh
  if [[ -e $installer ]] && [[ ! -e $pnpm_comp ]]; then
    $installer
  fi
}