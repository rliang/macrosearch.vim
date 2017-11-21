if exists('g:loaded_macrosearch') | finish | end
let g:loaded_macrosearch=1

let g:macrosearch#register=get(g:,'macrosearch#register','e')
let g:macrosearch#defaults=get(g:,'macrosearch#defaults',1)

func! s:map(mode,plug,default,rhs)
  exe a:mode.'noremap' '<silent>' a:plug a:rhs
  if g:macrosearch#defaults && !len(maparg(a:default,a:mode)) && !hasmapto(a:plug,a:mode)
    exe a:mode.'map' a:default a:plug
  end
endf

call s:map('v','<plug>(macrosearch-operator)',"q".g:macrosearch#register,':<c-u>let @/=""\|let v:hlsearch=1\|call macrosearch#operator(visualmode(),1)<cr>')
call s:map('n','<plug>(macrosearch-operator)',"q".g:macrosearch#register,':let @/=""\|let v:hlsearch=1\|set opfunc=macrosearch#operator<cr>g@')
call s:map('n','<plug>(macrosearch-current)',"q".g:macrosearch#register."q",':let v:hlsearch=1\|call macrosearch#start()<cr>')
call s:map('n','<plug>(macrosearch-/)',"/",':set opfunc=macrosearch#start<cr>g@/')
call s:map('n','<plug>(macrosearch-?)',"?",':set opfunc=macrosearch#start<cr>g@?')
call s:map('n','<plug>(macrosearch-*)',"*",'*N:call macrosearch#start()<cr>')
call s:map('n','<plug>(macrosearch-#)',"#",'#N:call macrosearch#start()<cr>')
call s:map('n','<plug>(macrosearch-n)',"n",'n:call macrosearch#stop()<cr>')
call s:map('n','<plug>(macrosearch-N)',"N",'N:call macrosearch#stop()<cr>')
