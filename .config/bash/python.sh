# Don't let pip install packages globally.
# Global packages should be installed by the system package manager.
export PIP_REQUIRE_VIRTUALENV=true

# Consider a custom startup file:
# http://www.jasonamyers.com//2017/default-to-pprint-python-repl/

# Unbuffered python, in a custom environment
export PYTHONUNBUFFERED=1
if [ -f "$HOME/.python/bin/activate" ]; then
  saved_ps1="$PS1"
  . "$HOME/.python/bin/activate"
  PS1="$saved_ps1"
  unset saved_ps1
elif [ -d "$HOME/.python" ] ; then
  export PYTHONPATH=~/.python
fi
