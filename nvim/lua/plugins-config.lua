"=====DEFAULT=====

"=====OMNISHARP=====
let g:OmniSharp_server_type = 'roslyn'
let g:ale_linters = {
			\'cs': ["OmniSharp"]
			\}
let g:OmniSharp_server_use_mono = 1

"=====ULTISNIPS AND SUPERTAB=====
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<c-s>'
let g:UltiSnipsJumpForwardTrigger      = '<c-b>'
let g:UltiSnipsJumpBackwardTrigger     = '<c-z>'

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsListSnippets="<c-t>"

let g:indentLine_setColors = 0
let g:indentLine_setConceal = 0

let g:python3_host_prog="/usr/bin/python3"

command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_highlighting_cache = 1
let g:airline_theme='dark_minimal'

" dark red
hi tsxTagName guifg=#E06C75
hi tsxComponentName guifg=#E06C75
hi tsxCloseComponentName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic

"autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)
"autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)

let g:autoformat_autoindent = 1
let g:autoformat_retab = 0
let g:formatdef_my_custom_cs = '"astyle --mode=cs --style=allman -pcHs ".&shiftwidth'

let g:lsc_auto_map = v:true

command! -bang FS call fzf#vim#files('~/src', <bang>0)

