" execute 'autocmd BufRead,BufNewFile *.hlsl setfiletype glsl'

augroup shader_cmds
    autocmd!
    autocmd BufRead,BufNewFile *.hlsl,*.shader,*.conf set filetype=glsl
augroup END
