let s:loc_pos = 0
let s:loc_stack = []

fu! common_jumplist#PushLocation(...)
  " only go ahead if we are in a 'real' buffer
  if &buftype != ""
    return
  endif
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

fu! s:OpenOrJump(pos)
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

fu! common_jumplist#JumpBack()
  " if we have nothing in the stack do nothing
  if len(s:loc_stack) == 0
    return
  endif

  if s:loc_pos == 0
    let s:loc_pos=-1
    call common_jumplist#PushLocation(0)
  endif

  " when we are looking at the first item in the
  " jump stack, don't move back
  if abs(s:loc_pos) < len(s:loc_stack)
    let s:loc_pos-=1
  endif
  call s:OpenOrJump(s:loc_stack[s:loc_pos])
endfunc

fu! common_jumplist#JumpForward()
  if s:loc_pos < -1
    let s:loc_pos+=1
    call s:OpenOrJump(s:loc_stack[s:loc_pos])
  endif
endfunc
