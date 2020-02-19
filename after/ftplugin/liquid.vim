" Set native comment markers in Liquid files
let liquid_ext = expand('%:e:e')
if liquid_ext =~ '\(ht\|x\)ml'
  set commentstring=<!--%s-->
elseif liquid_ext =~ 'css'
  set commentstring=/*%s*/
elseif liquid_ext =~ 'scss'
  set commentstring=/*%s*/
endif

let did_load_filetypes_userafter = 1
augroup filetypedetect
  " au! commands to set the filetype go here
  au BufNewFile,BufRead *.js.liquid setlocal filetype=javascript
  au BufNewFile,BufRead *.html.liquid let b:liquid_subtype = 'vue'
  au BufNewFile,BufRead *.scss.liquid setlocal filetype=scss
  au BufNewFile,BufRead *.liquid let b:liquid_subtype = 'vue'
augroup END
