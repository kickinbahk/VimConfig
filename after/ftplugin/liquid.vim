" Set native comment markers in Liquid files
let liquid_ext = expand('%:e:e')
if liquid_ext =~ '\(ht\|x\)ml'
  set commentstring=<!--%s-->
elseif liquid_ext =~ 'css'
  set commentstring=/*%s*/
endif
