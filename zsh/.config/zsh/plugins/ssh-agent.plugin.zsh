# MIT License
#
# Copyright (c) 2009-2020 Robby Russell and contributors (https://github.com/ohmyzsh/ohmyzsh/contributors)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Original file
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/ssh-agent/ssh-agent.plugin.zsh
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

typeset _agent_forwarding _ssh_env_cache

function _start_agent() {
	local lifetime
	zstyle -s :omz:plugins:ssh-agent lifetime lifetime

	# Start ssh-agent and setup environment.
	echo Starting ssh-agent...
	ssh-agent -s ${lifetime:+-t} "${lifetime}" | sed 's/^echo/#echo/' >! "$_ssh_env_cache"
	chmod 600 "$_ssh_env_cache"
	. "$_ssh_env_cache" > /dev/null
}

function _add_identities() {
	local id line sig lines
	local -a identities loaded_sigs loaded_ids not_loaded
	zstyle -a :omz:plugins:ssh-agent identities identities

	# Check for .ssh folder presence.
	if [[ ! -d $HOME/.ssh ]]; then
		return
	fi

	# Add default keys if no identities were set up via zstyle.
	# This is to mimic the call to ssh-add with no identities.
	if [[ ${#identities} -eq 0 ]]; then
		# Key list found on `ssh-add` man page's DESCRIPTION section.
		for id in id_rsa id_dsa id_ecdsa id_ed25519 identity; do
			# Check if file exists.
			[[ -f "$HOME/.ssh/$id" ]] && identities+=$id
		done
	fi

	# Get list of loaded identities' signatures and filenames.
	if lines=$(ssh-add -l); then
		for line in ${(f)lines}; do
			loaded_sigs+=${${(z)line}[2]}
			loaded_ids+=${${(z)line}[3]}
		done
	fi

	# Add identities if not already loaded.
	for id in $identities; do
		# Check for filename match, otherwise try for signature match.
		if [[ ${loaded_ids[(I)$HOME/.ssh/$id]} -le 0 ]]; then
			sig="$(ssh-keygen -lf "$HOME/.ssh/$id" | awk '{print $2}')"
			[[ ${loaded_sigs[(I)$sig]} -le 0 ]] && not_loaded+="$HOME/.ssh/$id"
		fi
	done

	[[ -n "$not_loaded" ]] && ssh-add ${^not_loaded}
}

# Get the filename to store/lookup the environment from.
_ssh_env_cache="$HOME/.ssh/environment-$SHORT_HOST"

# Test if agent-forwarding is enabled.
zstyle -b :omz:plugins:ssh-agent agent-forwarding _agent_forwarding

if [[ $_agent_forwarding == "yes" && -n "$SSH_AUTH_SOCK" ]]; then
	# Add a nifty symlink for screen/tmux if agent forwarding.
	[[ -L $SSH_AUTH_SOCK ]] || ln -sf "$SSH_AUTH_SOCK" /tmp/ssh-agent-"$USER"-screen
elif [[ -f "$_ssh_env_cache" ]]; then
	# Source SSH settings, if applicable
	. "$_ssh_env_cache" > /dev/null
	if [[ $USER == "root" ]]; then
		FILTER="ax"
	else
		FILTER="x"
	fi
	ps $FILTER | grep ssh-agent | grep -q "$SSH_AGENT_PID" || {
		_start_agent
	}
else
	_start_agent
fi

_add_identities

# Cleanup.
unset _agent_forwarding _ssh_env_cache
unfunction _start_agent _add_identities
