# macrosearch.vim
Automates macro recording between search matches. Experimental.

## What
This plugin seeks to eliminate the need for manually recording macros to
operate on searched patterns.

Such that `/ {pattern} <CR> q q {edits} n q @ q @ @ @ @`

...becomes `/ {pattern} <CR> {edits} n . . .`

This can be useful when:
* You don't want to use
  [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors);
* Some editing task is hard to express with regex for `:%s`.

## How
Basically, it starts recording when you search with `/` or `?` in normal mode,
and stops when you jump to the next match with `n` or `N`.

Perhaps the first match isn't the one you want to operate on, so if there have
been no modifications to the buffer after jumping to the next match, the
recording is restarted.

After you're done modifying and have jumped to the next match, the recorded
macro is fed to [vim-repeat](https://github.com/tpope/vim-repeat) when
available so you can trigger it with `.`.

## Options
* `let g:macrosearch#register='e'`: Which register to record macros to.
  Affects the default mapping of `<plug>(macrosearch-operator)`.
* `let g:macrosearch#defaults=1`: Whether to use default mappings.

## Mappings
* `nmap qe <Plug>(macrosearch-operator)`: Search the given text object, and
  starts a new recording.
* `nmap / <Plug>(macrosearch-/)`: Same as `/`, but also starts a new recording.
* `nmap ? <Plug>(macrosearch-?)`: Same as `?`, but also starts a new recording.
* `nmap * <Plug>(macrosearch-*)`: Same as `*`, but also starts a new recording.
* `nmap # <Plug>(macrosearch-#)`: Same as `#`, but also starts a new recording.
* `nmap n <Plug>(macrosearch-n)`: Same as `n`, but also stops recording and
  restarts if needed.
* `nmap N <Plug>(macrosearch-N)`: Same as `N`, but also stops recording and
  restarts if needed.

## Functions
* `macrosearch#operator()`: Operator function to search the given text object,
  and start a new recording.
* `macrosearch#start()`: Starts a new recording. When used as an operator
  function, uses the previous search pattern.
* `macrosearch#stop()`: Stops recording, and restarts if needed.
