if exists('g:loaded_easy_search')
  finish
endif
let g:loaded_easy_search = 1

let g:esearch_settings = easysearch#opts#new(get(g:, 'esearch_settings', {}))

noremap <silent><Plug>(easysearch) :<C-u>call <SID>easy_search(0)<CR>
xnoremap <silent><Plug>(easysearch) :<C-u>call <SID>easy_search(1)<CR>
if !hasmapto('<Plug>(easymotion-prefix)')
  map <leader>ff <Plug>(easysearch)
endif

command! -nargs=1 ESearch call easysearch#start(<f-args>)

fu! s:easy_search(visual, ...)
  if a:visual
    let initial_pattern = s:get_visual_selection()
  elseif get(v:, 'hlsearch', 0)
    let initial_pattern = getreg('/')
  else
    let initial_pattern = ''
  endif

  let str = easysearch#cmdline#read(initial_pattern, (a:0 ? a:1 : ''))
  if str == ''
    return ''
  endif
  return easysearch#start(easysearch#util#escape_str(str))
endfu

fu! s:get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfu

call NERDTreeAddKeyMap({
      \ 'key': '<C-f><C-f>',
      \ 'override': 1,
      \ 'callback': 'NERDTreeEsearchDir',
      \ 'quickhelpText': 'open handler',
      \ 'scope': 'Node' })

fu! NERDTreeEsearchDir(node)
  let path = a:node.path
  if path.isDirectory && !a:node.isRoot()
    call s:easy_search(0, path.str())
  else
    call s:easy_search(0)
  endif
endfu

