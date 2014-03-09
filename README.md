# vim-common-jumplist

Simple plugin that overrides the Vim-provided jump mechanisms such that:

* There is one jump list shared between all windows
* Jumping to an older entry in the shared jump list that represents a location in the same file as the current window
  simply moves the cursor
* Jumping to an older entry in the shared jump list that represents a location in _a different file_ to the current window
  either selects that buffer's window or splits a new window (if that buffer is not active)

# TODO

1. Add support for all jump commands
2. Need to add support for global change list
