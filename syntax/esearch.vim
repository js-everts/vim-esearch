if exists('b:current_syntax')
  finish
endif

syn match ESearchTitle      '^\%1l.*'
syn match ESearchFileName   '^\%>2l.*'
syn match ESearchContext    '^\s\+.*' contains=ESearchLineNumber,ESearchOmission
syn match ESearchLineNumber '^\s\+\zs\d\+\ze' contained

exe 'syn match ESearchOmission "\%(^\%>3l\s\+\d\+\s\)\@<=\V'. g:esearch#util#trunc_omission.'" contained'
exe 'syn match ESearchOmission "\V'. g:esearch#util#trunc_omission.'\$" contained'


hi default link ESearchTitle Title
hi default link ESearchContext Normal
hi default link ESearchLineNumber LineNr

hi default ESearchOmission ctermfg=yellow

exe 'hi default ESearchFileName cterm=bold gui=bold ' .
      \ 'ctermbg='.esearch#util#highlight_attr('Directory', 'bg', 'cterm', 0).' '.
      \ 'ctermfg='.esearch#util#highlight_attr('Directory', 'fg', 'cterm', 12).' '.
      \ 'guibg=' . esearch#util#highlight_attr('Directory', 'bg', 'gui',   '#005FFF').' '.
      \ 'guifg=' . esearch#util#highlight_attr('Directory', 'fg', 'gui',   '#FFFFFF').' '

exe 'hi default ESearchMatch cterm=bold gui=bold ' .
      \ 'ctermbg='.esearch#util#highlight_attr('MoreMsg', 'bg', 'cterm', 239 ).' '.
      \ 'ctermfg='.esearch#util#highlight_attr('MoreMsg', 'fg', 'cterm', 15 ).' '.
      \ 'guibg=' . esearch#util#highlight_attr('MoreMsg', 'bg', 'gui',   '#005FFF').' '.
      \ 'guifg=' . esearch#util#highlight_attr('MoreMsg', 'fg', 'gui',   '#FFFFFF').' '

let b:current_syntax = 'esearch'
