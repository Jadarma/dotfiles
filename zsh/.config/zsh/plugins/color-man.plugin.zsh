# -----------------------------------------------------------------------------
# COLOR MAN
#
# Output of man pages will now be colored using the defined ANSI colors.
#
# @see https://wiki.archlinux.org/index.php/Color_output_in_console#less
# @see https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
# -----------------------------------------------------------------------------

function man() {
    LESS_TERMCAP_mb=$'\e[1;31m' \
    LESS_TERMCAP_md=$'\e[1;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;34m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;32m' \
    command man "$@"
}
