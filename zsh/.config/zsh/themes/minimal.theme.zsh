# -----------------------------------------------------------------------------
# MINIMAL THEME
#
# A very basic theme aimed to provide as much information while making sure to
# stay out of our way.
#
# Left Side Prompt:
# - Path
# - A '$' if a normal user, or a '#' if elevated.
#
# Right Side Prompt:
# - Last command return code. If successful, a green tick , otherwise the error
#   code and a cross.
# - The local time.
#
# @see http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# -----------------------------------------------------------------------------

# shellcheck disable=SC2034
PROMPT='%B%F{black} %~ %F{green}%(!.#.$)%b%F{black} '
RPROMPT='%(?.%F{green}√.%F{red}%?✗) %F{white}%* %F{black}'
