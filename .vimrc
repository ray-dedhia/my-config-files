""" .vimrc file
" open fold / all folds = zo / zR
" close fold / all folds = zc / zM


""" Plugins {{{1
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
call vundle#end()

""" Indenting {{{1

" set tab to four spaces and auto-expand tabs to spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
command TWO set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
command FOUR set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" keep indent on line break
set autoindent 
" toggle paste mode (turn on before pasting, then turn back off)
set pastetoggle=<F3>
command P set paste
command NP set nopaste

" word wrap while preserving list indentation
set breakindent
set breakindentopt=shift:2,min:40,sbr

" commands to toggle lists
command CP set nobreakindent
command LIS set breakindent

" don't split a word at the end of a line
set linebreak


""" Compile Commands {{{1

" compile .tex files on save
au BufWritePost *.tex silent! execute "! pdflatex % > /dev/null 2>&1 &" | redraw! 

" save and compile .md files to PDF
command MC w | silent! execute "! pandoc % -o %:r.'pdf' > /dev/null 2>&1 &" | redraw!
command MCT w | silent! execute "! pandoc % -o %:r.'pdf' --toc > /dev/null 2>&1 &" | redraw!


""" Dictionary Commands {{{1

" set dictionary based on file type
au FileType * execute 'setlocal dict+=/home/rdedhia/.vim/dicts/'.&filetype.'-words.txt' 

" add dictionary completion with ctrl+n
set complete+=k

" ignore CamelCase words when spell checking
set spellcapcheck=


""" Folding {{{1

" enable folding
set foldenable

" shortcuts to enable or disable folding
command F setlocal foldenable
command NF setlocal nofoldenable

" set folding method based on file type
au FileType tex,latex,vim,sh setlocal foldmethod=marker

" markdown folding
function! MarkdownLevel()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">6"
    endif
    return "="
endfunction

au FileType markdown,text setlocal foldexpr=MarkdownLevel() | setlocal foldmethod=expr


""" Colors {{{1

" enable syntax highlighting
filetype plugin indent on
syntax on

" open specific files with specific syntax highlighting
au BufRead,BufNewFile *.vim_* set filetype=vim

" enable spellcheck
set spell
command SP set spell
command NS set nospell

" change visual display
au ColorScheme * hi Visual guifg=#000000 guibg=#FFFFFF gui=none term=reverse cterm=reverse
au ColorScheme * hi Search cterm=none ctermfg=black ctermbg=white

" change error highlighting
au ColorScheme * hi Error NONE
command EF hi Error NONE
command EU hi Error cterm=underline ctermfg=red
syn match markdownError "\w\@<=\w\@="
hi Error cterm=underline ctermfg=red ctermbg=none
hi SpellCap cterm=underline ctermfg=red ctermbg=none
hi SpellBad cterm=underline ctermfg=red ctermbg=none

" change spellcheck error highlighting
au ColorScheme * hi clear SpellBad
au ColorScheme * hi SpellBad cterm=underline ctermfg=red

" change text color
command BRO highlight Normal ctermfg=Brown
command GRA highlight Normal ctermfg=Gray
command WHI highlight Normal ctermfg=White
command C noh 

" change colorscheme
" - dark gray background: default, delek, elflord, peachpuff, ron, zellner
" - black background: industry, murphy
colorscheme delek


""" Fix Issues {{{1

" handle latex blocks
syn region math start=/\$\$/ end=/\$\$/
" inline math
syn match math '\$[^$].\{-}\$'
" highlight the region we defined as math
hi link math Statement


""" Relevant Links {{{1

" Compile Files
" - https://unix.stackexchange.com/questions/163201/in-vim-how-do-you-run-a-command-silently-in-the-background
" - https://vi.stackexchange.com/questions/3060/suppress-output-from-a-vim-autocomand
