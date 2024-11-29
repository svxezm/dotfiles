# Environment variables
. "/home/liz/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Only source this once
if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
  export __HM_ZSH_SESS_VARS_SOURCED=1
  
fi

export ZDOTDIR=$HOME/'.config/zsh'

ZSH="/nix/store/iw8narqqzfdcnh4fzl830mb8xbg8nsrh-oh-my-zsh-2024-05-03/share/oh-my-zsh";
ZSH_CACHE_DIR="/home/liz/.cache/oh-my-zsh";
