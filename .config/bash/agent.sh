# Collect SSH agent credentials if available.
# Based on http://hintsforums.macworld.com/showthread.php?t=50836
if [ -z "$SSH_AGENT_PID" -o -z "$SSH_AUTH_SOCK" ]
then
  SSH_AGENT_CACHE="$HOME/.cache/ssh-agent"
  if [ -s "${SSH_AGENT_CACHE}" ]
  then
    # Try to re-use an existing agent.
    source "${SSH_AGENT_CACHE}" > /dev/null
    
    # Check that the agent is still running.
    # This might need to check the process name if the pid has been taken again.
    if [ ! -S "$SSH_AUTH_SOCK" ] || ! kill -0 "$SSH_AGENT_PID" 2> /dev/null
    then
      # Looks like the SSH-Agent has died; it'll be restarted below.
      rm -f "${SSH_AGENT_CACHE}"
    fi
  fi
  
  if [ ! -f "${SSH_AGENT_CACHE}" ]
  then
    # Start a new agent.
    mkdir -p "$HOME/.cache"
    touch "${SSH_AGENT_CACHE}"
    chmod 600 "${SSH_AGENT_CACHE}"
    ssh-agent > "${SSH_AGENT_CACHE}"
    chmod 400 "${SSH_AGENT_CACHE}"
    source "${SSH_AGENT_CACHE}" > /dev/null
  fi
fi
