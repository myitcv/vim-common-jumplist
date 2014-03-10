# vim-common-jumplist

Simple plugin that overrides the Vim-provided jump mechanisms such that:

* There is one jump list shared between all windows in a vim instance
* Jumping to an older entry in the shared jump list that represents a location in the same file as the current window
  simply moves the cursor
* Jumping to an older entry in the shared jump list that represents a location in _a different file_ to the current window
  either selects that buffer's window or splits a new window (if that buffer is not active)
* Vice versa for jumping forward

# Installation instructions

Via [pathogen]:

```bash
git clone git@github.com:myitcv/vim-common-jumplist.git ~/.vim/bundle/vim-common-jumplist.git
```

# TODO

1. Add support for all jump commands
2. Need to add support for global change list

# License

Copyright (c) Paul Jolly. Distributed under the same terms as Vim itself. See [`:help
license`](http://vimdoc.sourceforge.net/htmldoc/uganda.html)

[pathogen]: https://github.com/tpope/vim-pathogen
