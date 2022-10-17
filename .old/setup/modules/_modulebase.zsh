#!/bin/zsh
# ---------------------------------------------------------------------------------------------------------------------
# Dotfile Install Module Base
#
# Not a module in and of itself, but rather the base definition of a module.
# Contains some common functions to make individual setup scripts more readable while keeping them modular.
# Should be sourced by all modules.
# ---------------------------------------------------------------------------------------------------------------------

# Terminal output color codes.
# shellcheck disable=SC2034
NORMAL=$(tput sgr0)

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)

BRIGHT=$(tput bold)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

# Pretty prints a log line given a tag style ($1), a tag label ($2) and a message ($3)
function log() {
  printf "$1[%-5s]$NORMAL ($MODULE): $1%s$NORMAL\n" "$2" "$3"
}

# Pretty prints a log line with a given message ($1). Used when conveying general information to the user.
function info() {
  log "$BRIGHT" 'INFO' "$1"
}

# Pretty prints a log line with a given message ($1). Used for reporting critical errors.
function error() {
  ((ERROR_COUNT++))
  log "$RED" 'ERROR' "$1"
}

# Pretty prints a log line with a given message ($1). Used for reporting non-critical or recoverable errors.
function warn() {
  ((WARN_COUNT++))
  log "$YELLOW" 'WARN' "$1"
}

# Pretty prints a log line with a given message ($1). Used for printing detailed statuses to aid in troubleshooting.
function debug() {
  log "$NORMAL" 'DEBUG' "$1"
}

# Initializes this module (named $1). Should be called right after sourcing.
# - Logs it's beginning and resetting the error counters.
# - Requires root user.
# - Sources configuration.
function moduleInit() {
  MODULE=$1
  REPO_DIR="$(pwd)"
  ERROR_COUNT=0
  WARN_COUNT=0
  info "Configuring module '$MODULE'..."
  [[ $EUID == 0 ]] || moduleFail 'Installation needs to be done as root.'
  source 'setup/conf/dotinstall.conf' || moduleFail "Missing configuration file at $REPO_DIR/setup/conf/dotinstall.conf"
}

# Logs the status of this module, depending on what errors encountered, if any.
# Does not halt the module, you have to exit manually.
function moduleDone() {
  case "$ERROR_COUNT,$WARN_COUNT" in
  0,0) info "${GREEN}Module '$MODULE' configured successfully!$NORMAL" ;;
  0,*) warn 'Module configured, but with warnings.' ;;
  *) error 'Failed to configure module.' ;;
  esac
}

# Like error(), but also forces the early exit out the module script.
function fail() {
  error "$1"
  moduleDone
  exit 1
}

# Takes in a list of config variables names and checks their existence in dotinstall.conf, otherwise fails the module.
function requireConfig() {
  for CONF_VAR; do
    debug "here $CONF_VAR"
    # shellcheck disable=SC2157
    [[ -n "${(P)CONF_VAR}" ]] || fail "Missing configuration: '$CONF_VAR'"
  done
}

# Prompts the user the given question ($1) and completes successfully if the user presses 'y'.
function userConfirm() {
  if read -rq "?$BRIGHT$MAGENTA > $1 (y/N): $NORMAL"; then
    printf '\n'
    debug 'User accepted.'
  else
    printf '\n'
    debug 'User declined.'
    return 1
  fi
}

# Performs an rsync call from source ($1) to destination ($2) while making sure the ownership belongs to the user.
function rsyncUser() {
  rsync -rvpog --chmod=740 --chown="$INSTALL_USER:$INSTALL_USER" "$1" "$2"
}
