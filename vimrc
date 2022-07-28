call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'joshdick/onedark.vim'       " OneDark Theme
call plug#end()

" Activate Theme
syntax on
colorscheme onedark

" Set Tabwidth
:set tabstop=2
:set shiftwidth=2
:set expandtab

" Remap keys for applying codeAction to the current line.
nmap <leader> f  <plug>(coc-codeaction)
" apply autofix to problem on the current line.
nmap <leader> gz  <plug>(coc-fix-current)
nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use Tab for completion 
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Allow CTRL+Space for completion
inoremap <silent><expr> <c-@> coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> f :call CocActionAsync('format') 

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command! -nargs=0 Format :call CocActionAsync('format')

" Organize Imports
nnoremap <silent> OI :call CocActionAsync('runCommand', 'editor.action.organizeImport')<CR>

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}



let g:coc_global_extensions = ['coc-tsserver']

