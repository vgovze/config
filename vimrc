" Interface properties.
set number      "show line numers.
set cursorline  "highlight the edited line.
set ruler       "show cursor position (row, column).
set visualbell      "flash cursor on error
set colorcolumn=80  "highlight the 80th column
colorscheme pablo

" Functionality.
syntax on   " syntax highlighting.
set encoding=utf-8  "default encoding.
set wildmenu        "show a menu with options when tab is pressed.
set wildmode=list:longest   "show bash-like options when tab is pressed.
set wrap

" Whitespace.
set list    " show whitespace.
set listchars+=space:\\u22c5    "set whitespaces as dots.
set listchars+=tab:\\u2192\     "set tabs as single arrow and spaces.

" Indentation.
set autoindent      "enable auto-indentation.
set smartindent     "enable smart indentation.
set smarttab        "enable smart tab.
set expandtab       "do not expand tabs into spaces.
set tabstop=4       "width of the tab measured in spaces.
set shiftwidth=4    "number of spaces to use for each auto-indent.
set softtabstop=4   "stop before adding a tab, if tab is larger.
