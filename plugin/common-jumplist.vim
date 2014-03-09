let s:loc_pos = 0

fu! PushLocation(...)
  " if called without arguments assume we want to reset
  " the current pointer
  if a:0 == 0 || !exists('s:loc_pos')
    if s:loc_pos < 0
      let s:loc_stack = s:loc_stack[0:s:loc_pos]
    endif
    let s:loc_pos = 0
  endif
  if !exists('s:loc_stack')
    let s:loc_stack = []
  endif
  let new_loc = []
  call add(new_loc, expand("%"))
  let x = getpos('.')
  call add(new_loc, x[1])
  call add(new_loc, x[2])
  call add(s:loc_stack, new_loc)
endfunc

fu! OpenOrJump(pos)
  let buf=a:pos[0]
  let line=a:pos[1]
  let col=a:pos[2]

  let bufwinnr=bufwinnr(bufnr(buf))
  if bufwinnr >= 0
    execute 'normal' bufwinnr."\<C-w>w"
  else
    execute 'sb' buf
  endif
  call cursor(line, col)
endfunc

fu! JumpBack()
  if abs(s:loc_pos) < len(s:loc_stack)
    if s:loc_pos == 0
      let s:loc_pos-=1
      call PushLocation(0)
    endif
    let s:loc_pos-=1
    call OpenOrJump(s:loc_stack[s:loc_pos])
  endif
endfunc

fu! JumpForward()
  if s:loc_pos < -1
    let s:loc_pos+=1
    call OpenOrJump(s:loc_stack[s:loc_pos])
  endif
endfunc

nnoremap <silent> m` :call PushLocation()<CR>m`
nnoremap <silent> m' :call PushLocation()<CR>m'
nnoremap <silent> G :call PushLocation()<CR>G
nnoremap <silent> <C-o> :call JumpBack()<CR>
nnoremap <silent> <C-i> :call JumpForward()<CR>
