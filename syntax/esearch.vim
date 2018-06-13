if exists('b:current_syntax')
  finish
endif

syn match ESearchTitle      '^\%1l.*'
syn match ESearchFileName   '^\%>2l.*'
syn match ESearchContext    '^\%>2l\s\+.*'
syn match ESearchLineNumber '^\%>2l\s\+\d\+'

exe 'syn match ESearchOmission "\%(^\%>3l\s\+\d\+\s\)\@<=\V'. g:esearch#util#trunc_omission.'"'
exe 'syn match ESearchOmission "\V'. g:esearch#util#trunc_omission.'\$"'

hi link ESearchTitle      Title
hi link ESearchContext    Normal
hi link ESearchLineNumber LineNr

if !hlexists('ESearchOmission')
  hi ESearchOmission ctermfg=yellow
endif

exe 'hi ESearchFileName cterm=bold gui=bold ' .
      \ 'ctermbg='.esearch#util#highlight_attr('Directory', 'bg', 'cterm', 0).' '.
      \ 'ctermfg='.esearch#util#highlight_attr('Directory', 'fg', 'cterm', 12).' '.
      \ 'guibg=' . esearch#util#highlight_attr('Directory', 'bg', 'gui',   '#005FFF').' '.
      \ 'guifg=' . esearch#util#highlight_attr('Directory', 'fg', 'gui',   '#FFFFFF').' '

if !hlexists('ESearchMatch')
  exe 'hi ESearchMatch cterm=bold gui=bold ' .
        \ 'ctermbg='.esearch#util#highlight_attr('MoreMsg', 'bg', 'cterm', 239 ).' '.
        \ 'ctermfg='.esearch#util#highlight_attr('MoreMsg', 'fg', 'cterm', 15 ).' '.
        \ 'guibg=' . esearch#util#highlight_attr('MoreMsg', 'bg', 'gui',   '#005FFF').' '.
        \ 'guifg=' . esearch#util#highlight_attr('MoreMsg', 'fg', 'gui',   '#FFFFFF').' '
endif

let b:current_syntax = 'esearch'
