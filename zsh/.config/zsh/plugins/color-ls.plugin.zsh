# -----------------------------------------------------------------------------
# COLOR LS
#
# Output of ls will be colored by default.
# Also adds useful aliases.
#
# @see https://wiki.archlinux.org/index.php/Color_output_in_console#ls
# -----------------------------------------------------------------------------

eval "$(dircolors -p | perl -pe 's/^((CAP|S[ET]|O[TR]|M|E)\w+).*/$1 00/' | dircolors -)"
alias ls='ls --color=auto'
alias ll='ls -lah'
