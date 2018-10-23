mydir=${0:a:h}

function powerline_precmd() {
    PS1="$($mydir/powerline-go -error $? -shell zsh -cwd-max-depth 4 -modules "cwd,perms,git,hg,jobs,root")"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
