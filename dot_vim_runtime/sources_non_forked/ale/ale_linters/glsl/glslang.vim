" Author: Sven-Hendrik Haase <svenstaro@gmail.com>
" Description: glslang-based linter for glsl files
"
" TODO: Once https://github.com/KhronosGroup/glslang/pull/1047 is accepted,
" we can use stdin.

let g:ale_glsl_glslang_executable =
\ get(g:, 'ale_glsl_glslang_executable', 'glslangValidator')

let g:ale_glsl_glslang_options = get(g:, 'ale_glsl_glslang_options', '')

function! ale_linters#glsl#glslang#GetExecutable(buffer) abort
    return ale#Var(a:buffer, 'glsl_glslang_executable')
endfunction

function! ale_linters#glsl#glslang#GetCommand(buffer) abort
    return ale_linters#glsl#glslang#GetExecutable(a:buffer)
    \   . ' ' . ale#Var(a:buffer, 'glsl_glslang_options')
    \   . ' ' . '-C %t'
endfunction

function! ale_linters#glsl#glslang#Handle(buffer, lines) abort
    " Matches patterns like the following:
    "
    " ERROR: 0:5: 'foo' : undeclared identifier
    let l:pattern = '^\(.\+\): \(\d\+\):\(\d\+\): \(.\+\)'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': str2nr(l:match[3]),
        \   'col': str2nr(l:match[2]),
        \   'text': l:match[4],
        \   'type': l:match[1] is# 'ERROR' ? 'E' : 'W',
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('glsl', {
\   'name': 'glslang',
\   'executable_callback': 'ale_linters#glsl#glslang#GetExecutable',
\   'command_callback': 'ale_linters#glsl#glslang#GetCommand',
\   'callback': 'ale_linters#glsl#glslang#Handle',
\})
