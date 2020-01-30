" Extend vim-liquid filetype setting Javascript files
" https://github.com/tpope/vim-liquid/pull/9
au BufNewFile,BufRead *.js.liquid let b:liquid_subtype = 'javascript'
