# Collect SSH agent credentials if available.
if [ -z "$SSH_AGENT_PID" -o -z "$SSH_AUTH_SOCK" ]
then
  eval $(ssh-agent) > /dev/null
fi
