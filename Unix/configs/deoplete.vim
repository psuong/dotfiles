" Deoplete
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 1

" Change clang binary path
call deoplete#custom#var('clangx', 'clang_binary', '/usr/local/opt/llvm/bin/clang')

" Change clang options
call deoplete#custom#var('clangx', 'default_c_options', '')
call deoplete#custom#var('clangx', 'default_cpp_options', '')

call deoplete#custom#var('omni', 'input_patterns', {
    \ 'cs': '\w+|[^. *\t]\.\w*',
    \})

" Completion sources
call deoplete#custom#option('sources', {
  \ 'cs': ['omnisharp'],
  \ 'cpp': ['clangx']
  \})