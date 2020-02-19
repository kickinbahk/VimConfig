" Extend vim-liquid filetype setting Javascript files
" https://github.com/tpope/vim-liquid/pull/9
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  " au! commands to set the filetype go here
  au BufNewFile,BufRead *.liquid let b:liquid_subtype = 'vue'
  au BufNewFile,BufRead *.js.liquid setlocal filetype=javascript
  au BufNewFile,BufRead *.html.liquid let b:liquid_subtype = 'vue'
  au BufNewFile,BufRead *.scss.liquid setlocal filetype=scss
augroup END

