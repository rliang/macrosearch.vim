let s:changed=0

func! macrosearch#operator(type,...)
  let reg_save=@@
  let sel_save=&selection
  let &selection="inclusive"
  exe 'norm!' a:0 ? "gvy" : a:type=='line' ? "'[V']y" : "`[v`]y"
  call setreg('/','\V\C'.join(split(escape(@@,'\'),'\n'),'\n'),a:type[0])
  let &selection=sel_save
  let @@=reg_save
  call macrosearch#start()
endf

func! macrosearch#start(...)
  sil! call repeat#invalidate()
  norm! q
  exe 'norm!' "gno\<esc>q".g:macrosearch#register
  let s:changed=0
  augroup macrosearch
    au!
    au TextChanged,TextChangedI * let s:changed=1 | au! macrosearch
  augroup END
endf

func! macrosearch#stop(...)
  if s:changed
    sil! call repeat#set('@'.g:macrosearch#register, 1)
    norm! q
  else
    call macrosearch#start()
  end
endf
