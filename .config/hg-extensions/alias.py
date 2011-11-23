# Mercurial 1.3 has [alias] built in,
# but 1.1 needs an explicit extension configuration line.
# This allows both to work without complaints.

try:
    from hgext.alias import *
except ImportError:
    pass
