""" .vimrc file
" open fold / all folds = zo / zR
" close fold / all folds = zc / zM


""" Plugins {{{1
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
call vundle#end()
filetype plugin indent on

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

" add tab in insert mode
inoremap <C-l> <Esc>>>$a<Space>
inoremap <C-h> <Esc><<$a<Space>
inoremap <C-k> <Esc>0d$a


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
" markdown TOC shortcuts
command Notoc lclose

" set folding method based on file type
au FileType tex,latex,vim,sh setlocal foldmethod=marker

" markdown folding
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_level = 0
let g:vim_markdown_toc_autofit = 1


""" Colors {{{1

" enable syntax highlighting
"filetype plugin indent on
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

" fix indent issue with vim-markdown plugin
" https://github.com/preservim/vim-markdown/issues/126
au filetype markdown set formatoptions+=ro
au filetype markdown set comments=b:*,b:-,b:+,b:1.,n:>

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
