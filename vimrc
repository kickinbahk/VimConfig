set number
set tabstop=2
set shiftwidth=2
set expandtab
set tw=120
set autoindent

if &compatible
  set nocompatible
endif

" ------
" DEIN PLUGIN MANAGER
" ------
"
" Add the dein installation directory into runtimepath
set runtimepath+=~/.vim/pack/kickinbahk/start/dein.vim

if dein#load_state('~/.vim/pack/kickinbahk/start/dein.vim')
  call dein#begin('~/.vim/pack/kickinbahk/start/dein.vim')

  call dein#add('~/.vim/pack/kickinbahk/start/dein.vim')
  call dein#add('~/.vim/pack/kickinbahk/start/deoplete.nvim')
  call dein#add('~/.vim/pack/kickinbahk/start/coc.nvim', {'merged':0, 'rev': 'release'})
  
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

" ------
"  SYNTAX HIGHLIGHING & STYLING
" ------
"
if (has("termguicolors$"))
  set termguicolors
endif

syntax enable
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>
colorscheme night-owl

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"


"==============================
" PLUGIN SETTINGS
"==============================

" ------
" COC SETTINGS
" ------
"
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" ------
" CLOSETAG SETTINGS
" ------
"
"Set filenames for Closetag plugin
let g:closetag_filenames = '*.html, *.xhtml, *.phtml, *.liquid, *.js, *.js.liquid'


"" Fzf installed using Homebrew
set rtp+=/usr/local/opt/fzf

" ------
" PRETTIER SETTINGS
" ------
"
" Prettier custom config
let g:prettier#config#print_width = 120

" ------ 
" INDENT LINE SETTINGS
" ------
"
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" ------
" DENITE SETTINGS
" ------
"
silent! call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
silent! call denite#custom#option('default', 'prompt', 'λ')
silent! call denite#custom#var('grep', 'command', ['ag'])
silent! call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
silent! call denite#custom#var('grep', 'recursive_opts', [])
silent! call denite#custom#var('grep', 'pattern_opt', [])
silent! call denite#custom#var('grep', 'separator', ['--'])
silent! call denite#custom#var('grep', 'final_opts', [])
silent! call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
silent! call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/*', '*.pyc', 'node_modules/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/', '*.png'])

" ------
" BETTER COMMENTS SETTINGS
" ------
"
" Better Comments Language mapping
let g:bettercomments_language_aliases = { 'javascript': 'js' }

" Better Comments Highlighting
hi ErrorBetterComments guifg=#ff0000 ctermfg=196 gui=italic cterm=italic
hi HighlightBetterComments guifg=#afff00 ctermfg=154 gui=italic cterm=italic
hi QuestionBetterComments guifg=#005fff ctermfg=27 gui=italic cterm=italic
hi TodoBetterComments guifg=#af8700 ctermfg=136 gui=italic cterm=italic
hi StrikeoutBetterComments guifg=#5fafd7 ctermfg=74 gui=italic cterm=italic


"==============================
" KEY MAPPINGS
"==============================

" Move to beginning/end of line without taking fingers off of home row:
nnoremap H ^
nnoremap L $

" Remap esc to Ctrl-c and kj for easier exiting insert mode
inoremap <C-c> <ESC>
imap kj <ESC>

" ------
" LEADER KEYMAPPINGS
" ------
"
" Remap leader key to spacebar
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

" Vsplit edit vimrc file
nmap <leader>vr :vsplit ~/.vim/vimrc<CR>

" Source (reload) vimrc file
nmap <leader>so :source ~/.vim/vimrc<CR>

" Pre-populate a split command with the current directory
nmap <leader>vs :vnew <C-r>=escape(expand("%:p:h"), ' ') . '/'<cr>

" Pre-populate a tab command with the current directory
nmap <leader>nt :tabe <C-r>=escape(expand("%:p:h"), ' ') . '/'<cr>

" Leader-c copies to clipboard
map <leader>c <Nop>
vnoremap <leader>c :w !pbcopy<CR><ENTER>

" Copy the entire buffer into the system register
nmap <leader>co ggVG*y

" Leader-t opens new tab
map <leader>t <Nop>
noremap <leader>t :tabe<CR>

" Leader-q quits window
map <leader>q <Nop>
noremap <leader>q :q<CR>

" Leader-s saves buffer
map <leader>s <Nop>
noremap <leader>s :w<CR>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Toggle Highlighting after Search
nnoremap <silent><expr> <leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Git Blame
nnoremap <leader>gb :Gblame<CR>

" ------
"  COC KEYBINDINGS
" ------
" Use Tab for trigger completion
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" ------
" CLOSETAG PLUGIN KEYBINDINGS
" ------
"
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

" ------
" DENITE PLUGIN KEYBINDINGS
" ------ 
"
nmap <leader>d :Denite -start-filter file/rec<CR>
nmap <leader>b :Denite buffer<CR>
nnoremap <leader>g :Denite grep<CR>

