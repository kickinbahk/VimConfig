set number
set tabstop=2
set shiftwidth=2
set expandtab
set tw=80
set autoindent
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set lazyredraw " Don't redraw screen when running macros.
set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set nobackup
set nowritebackup
set noswapfile
set formatoptions-=t " Don't auto-break long lines (re-enable this for prose)
set laststatus=2     " Always display the status line
set hidden " Don't require saving before closing a buffer

" Ignore whitespace only changes in diff, always use vertical diffs
set diffopt+=iwhite
set diffopt+=vertical

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

if &compatible
  set nocompatible
endif

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Don't wait so long for the next keypress (particularly in ambigious Leader
" situations.
set timeoutlen=1000

" Without this, vim breaks in the middle of words when wrapping
autocmd FileType markdown setlocal nolist wrap lbr

" Don't automatically continue comments after newline
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" ------
"  Project Notes
" ------
"
" Quick access to a local notes file for keeping track of things in a given
" project. Add `.project-notes` to global ~/.gitignore

let s:PROJECT_NOTES_FILE = '.project-notes'

command! EditProjectNotes call <sid>SmartSplit(s:PROJECT_NOTES_FILE)
nnoremap <leader>ep :EditProjectNotes<cr>

autocmd BufEnter .project-notes call <sid>LoadNotes()

function! s:SmartSplit(file)
  let split_cmd = (winwidth(0) >= 100) ? 'vsplit' : 'split'
  execute split_cmd . " " . a:file
endfunction

function! s:LoadNotes()
  setlocal filetype=markdown
  nnoremap <buffer> q :wq<cr>
endfunction

" ------
" DEIN PLUGIN MANAGER
" ------
"
" Add the dein installation directory into runtimepath
set runtimepath+=~/VimConfig/pack/kickinbahk/start/dein.vim

if dein#load_state('~/VimConfig/pack/kickinbahk/start/dein.vim')
  call dein#begin('~/VimConfig/pack/kickinbahk/start/dein.vim')

  call dein#add('~/VimConfig/pack/kickinbahk/start/dein.vim')
  call dein#add('~/VimConfig/pack/kickinbahk/start/deoplete.nvim')
  call dein#add('~/VimConfig/pack/kickinbahk/start/coc.nvim', {'merged':0, 'rev': 'release'})
  
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

set rtp+=/home/VimConfig/after/ftdetect/liquid.vim
syntax enable
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>
colorscheme night-owl

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

" Make it more obviouser when lines are too long
highlight ColorColumn ctermbg=235

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

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

" Setup Prettier
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" ------
" CLOSETAG SETTINGS
" ------
"
"Set filenames for Closetag plugin
let g:closetag_filenames = '*.html, *.xhtml, *.phtml, *.liquid, *.js, *.js.liquid'


"" Fzf installed using Homebrew
set rtp+=/usr/local/opt/fzf


" ------
" CLOSETAG SETTINGS
" ------
"
" To ensure that this plugin works well with Tim Pope's fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" ------
" Ctrl-P
" ------
"
" Make CtrlP use ag for listing the files. Way faster and no useless files.
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 1

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
nmap <leader>vr :vsplit ~/VimConfig/vimrc<CR>

" Source (reload) vimrc file
nmap <leader>so :source ~/VimConfig/vimrc<CR>

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
noremap <leader>qq :q<CR>

" Leader-s saves buffer
map <leader>w <Nop>
noremap <leader>w :w<CR>

" Leader-s changes filetype to javascript
noremap <leader>js :set filetype=javascript<CR>

" Leader-s changes filetype to scss
noremap <leader>scss :set filetype=scss<CR>

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

