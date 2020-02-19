" my filetype file
if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.js.liquid       setfiletype javascript 
    au! BufRead,BufNewFile *.scss.liquid       setfiletype scss
augroup END
