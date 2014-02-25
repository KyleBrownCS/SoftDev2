set number
set backspace=indent,eol,start
set history=1000
set showmode

syntax on

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

set list listchars=tab:\ \ ,trail:·

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/