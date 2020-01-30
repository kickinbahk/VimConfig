set number
set tabstop=2
set shiftwidth=2
set expandtab
set tw=120
set autoindent


if &compatible
  set nocompatible
endif

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

"Rema esc to Ctrl-c for easier exiting insert mode
inoremap <C-c> <ESC>

"Remap leader key to spacebar
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

if (has("termguicolors$"))
  set termguicolors
endif

map <leader>c <Nop>
vnoremap <leader>c :w !pbcopy<CR><ENTER>

syntax enable
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>
colorscheme night-owl

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"
" CLOSETAG SETTINGS
"

"Set filenames for Closetag plugin
let g:closetag_filenames = '*.html, *.xhtml, *.phtml, *.liquid'

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

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

" Prettier custom config
let g:prettier#config#print_width = 120

"" Fzf installed using Homebrew
set rtp+=/usr/local/opt/fzf

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

nmap <leader>d :Denite -start-filter file/rec<CR>
nmap <leader>b :Denite buffer<CR>
nnoremap <leader>g :Denite grep<CR>

" Better Comments Language mapping
let g:bettercomments_language_aliases = { 'javascript': 'js' }

hi ErrorBetterComments guifg=#ff0000 ctermfg=196 gui=italic cterm=italic
hi HighlightBetterComments guifg=#afff00 ctermfg=154 gui=italic cterm=italic
hi QuestionBetterComments guifg=#005fff ctermfg=27 gui=italic cterm=italic
hi TodoBetterComments guifg=#af8700 ctermfg=136 gui=italic cterm=italic
hi StrikeoutBetterComments guifg=#5fafd7 ctermfg=74 gui=italic cterm=italic
