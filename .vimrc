set nocompatible              " be iMproved, required
filetype off                  " required
set shell=bash

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Interface & Color
" Plugin 'bling/vim-airline'
Plugin 'itchyny/lightline.vim'
Plugin 'ap/vim-buftabline'
Plugin 'tomasr/molokai'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'chriskempson/base16-vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'mattr555/vim-instacode'
Plugin 'junegunn/seoul256.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ehamberg/vim-cute-python'
Plugin 'kien/rainbow_parentheses.vim'

" Language and syntax
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-pandoc-after'
"Plugin 'tex/vimpreviewpandoc'
"Plugin 'Kocha/vim-systemc'
Plugin 'lervag/vimtex'
Plugin 'reedes/vim-lexical'
Plugin 'beloglazov/vim-online-thesaurus'
Plugin 'davidhalter/jedi-vim'
Plugin 'dag/vim-fish'
Plugin 'wannesm/wmgraphviz.vim'
Plugin 'antoyo/vim-licenses'

" Productivity Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'sjl/gundo.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'bkad/CamelCaseMotion'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/vim-easy-align'
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'Raimondi/delimitMate'
" Plugin 'Shougo/neocomplete.vim'
" Plugin 'Shougo/neosnippet'
" Plugin 'Shougo/neosnippet-snippets'
" Plugin 'fholgado/minibufexpl.vim'
" Plugin 'kien/ctrlp.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'henrik/vim-indexed-search'
Plugin 'rizzatti/dash.vim'
Plugin 'mileszs/ack.vim'

" Extend Vim
Plugin 'Shougo/vimproc.vim'
Plugin 'vim-scripts/SyntaxRange'
Plugin 'Shougo/vimshell.vim'
Plugin 'sjl/vitality.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

" general things
set autoread
nnoremap j gj
nnoremap k gk
set backspace=indent,eol,start
let mapleader = ","
let maplocalleader = ","
"syntax stuff
syntax enable
syntax on
set ts=4
set sw=4
set et
set shortmess+=I
set encoding=utf-8
set undofile
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

" set up syntax highlighting for my e-mail
au BufRead,BufNewFile .followup,.article,.letter,/tmp/pico*,nn.*,snd.*,/tmp/mutt* :set ft=mail 
"imap <C-F> <ESC>:r!~/bin/google-contacts-lookup.sh <cword><CR><ESC>

" autosave after textchange eventst
autocmd InsertLeave,TextChanged * if expand('%') != '' | update | endif

" lightline
set laststatus=2
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'fugitive', 'readonly', 'filename', 'modified'] ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'MyFugitive',
            \   'readonly': 'MyReadonly',
            \   'modified': 'MyModified',
            \   'filename': 'MyFilename',
            \   'fileformat': 'MyFileformat',
            \   'filetype': 'MyFiletype',
            \   'fileencoding': 'MyFileencoding',
            \   'mode': 'MyMode'
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
            \ }

function! MyModified()
    return &ft =~ 'help\|gundo\|nerdtree\|vundle' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|gundo\|nerdtree\|vundle' && &readonly ? '' : ''
endfunction

function! MyFugitive()
    if &ft !~? 'gundo\|nerdtree\|vundle' && exists('*fugitive#head')
        let _ = fugitive#head()
        return strlen(_) ? ' '._ : ''
    endif
    return ''
endfunction

function! MyFilename()
    let fname = expand('%:t')
    "return fname == 'ControlP' ? g:lightline.ctrlp_item :
    return fname =~ '__Gundo\|NERD_tree' ? '' :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    let fname = expand('%:t')
    "return fname == 'ControlP' ? 'CtrlP' :
    return fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" function! CtrlPMark()
"   if expand('%:t') =~ 'ControlP'
"     call lightline#link('iR'[g:lightline.ctrlp_regex])
"     return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
"           \ , g:lightline.ctrlp_next], 0)
"   else
"     return ''
"   endif
" endfunction

" let g:ctrlp_status_func = {
"   \ 'main': 'CtrlPStatusFunc_1',
"   \ 'prog': 'CtrlPStatusFunc_2',
"   \ }

" function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
"   let g:lightline.ctrlp_regex = a:regex
"   let g:lightline.ctrlp_prev = a:prev
"   let g:lightline.ctrlp_item = a:item
"   let g:lightline.ctrlp_next = a:next
"   return lightline#statusline(0)
" endfunction

" function! CtrlPStatusFunc_2(str)
"   return lightline#statusline(0)
" endfunction
" branch symbol for powerline font '' (\ue0a0)

" let g:lightline = {
"     \ 'colorscheme': 'solarized',
"     \ }
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
"
" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_right_sep = '«'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.whitespace = 'Ξ'
"


"""""===================================
"=======================================
"" Functions
" List all currently available mappings starting with <leader>
function! ListLeaders()
    silent! redir @a
    silent! nmap <LEADER>
    silent! redir END
    silent! new
    silent! put! a
    silent! g/^s*$/d
    silent! %s/^.*,//
    silent! normal ggVg
    silent! sort
    silent! let lines = getline(1,"$")
endfunction

nmap <leader>, :source %<CR>:call ListLeaders()<CR>
nmap <leader>so :source %<CR>

" call texdoc on a package name
" This opens a PDF with the official documentation for the package.
function! MyTexDoc()
    let ftype = &filetype
    if ftype == "tex"
        silent! execute "!texdoc <cword>"
    endif
endfunction

nnoremap <leader>ld :call MyTexDoc()<CR>


"color and gui
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234
set number
set relativenumber
set colorcolumn=80
highlight ColorColumn ctermbg=7
let g:rehash256=1
hi clear SignColumn
set list
set listchars=tab:▸\ ,eol:↩︎

" Lexical stuff
let g:lexical#spelllang = ["en", "de"]
set spelllang = "de"
set pastetoggle=<F6>

" indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
" if has('gui_running')
" 	set t_Co=256
" 	set background=dark
" 	colorscheme base16-tomorrow
" 	nnoremap <M-1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
" 	nnoremap <M-2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
" 	nnoremap <M-3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
" 	if has("gui_gtk2")
" 		set guifont=Ubuntu\ Mono\ 11
" 	endif
if has("gui_macvim")
    " set guifont=Inconsolata-g:12
    set guifont=Menlo\ for\ Powerline:h12
    set t_Co=256
    set guioptions=aAce
    set backupcopy=yes
    set fuoptions=maxvert,maxhorz
    " set background=dark
    " set background=light
    " let base16colorspace=256
    " colorscheme base16-tomorrow
    " let g:solarized_hitrail=1
    " let g:solarized_termtrans = 1
    " let g:solarized_termcolors=256
    " colorscheme solarized
    " colorscheme seoul256-light
    colorscheme seoul256
    " set noballoneval
    autocmd VimResized * wincmd =
    set noshowmode
else
    set t_Co=256
    " set background=dark
    " " set background=light
    " " colorscheme Tomorrow-Night
    " " colorscheme Tomorrow
    " " let base16colorspace=256
    " " colorscheme base16-tomorrow
    " " let g:solarized_termtrans = 1
    " " let g:solarized_termcolors=256
    " " colorscheme solarized
    colorscheme seoul256
endif
if (strftime("%H") < 7 || strftime("%H") > 20) == 1
    set background=dark
else
    set background=light
endif

" rainbow parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

" NERDTree
map <D-N> :NERDTreeToggle<CR>
" make nerdtree behave like a split explorer
let NERDTreeHijackNetrw=1
let NERDTreeDirArrows=1
let NERDTreeShowBookmarks=1
let NERDTreeQuitOnOpen=1 
let NERDTreeCascadeOpenSingleChildDir=1
" map <D-E> :NERDTreeToggle<CR>:OpenBookmark .vimrc<CR>
if has("gui_macvim")
    map <D-E> :silent tabnew ~/.vimrc<CR>
else
    map <leader>re :execute "edit " . ~/.vimrc<CR>
endif

" CtrlP
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" nnoremap <D-M> :CtrlPMRUFiles<CR>

" vimfiler
let g:vimfiler_as_default_explorer = 1

" Unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <C-p>     :Unite file_rec/async<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" let g:unite_source_menu_menus.git = {
"     \ 'description' : '            gestionar repositorios git
"         \                            ⌘ [espacio]g',
"     \}
" let g:unite_source_menu_menus.git.command_candidates = [
"     \['▷ tig                                                        ⌘ ,gt',
"         \'normal ,gt'],
"     \['▷ git status       (Fugitive)                                ⌘ ,gs',
"         \'Gstatus'],
"     \['▷ git diff         (Fugitive)                                ⌘ ,gd',
"         \'Gdiff'],
"     \['▷ git commit       (Fugitive)                                ⌘ ,gc',
"         \'Gcommit'],
"     \['▷ git log          (Fugitive)                                ⌘ ,gl',
"         \'exe "silent Glog | Unite quickfix"'],
"     \['▷ git blame        (Fugitive)                                ⌘ ,gb',
"         \'Gblame'],
"     \['▷ git stage        (Fugitive)                                ⌘ ,gw',
"         \'Gwrite'],
"     \['▷ git checkout     (Fugitive)                                ⌘ ,go',
"         \'Gread'],
"     \['▷ git rm           (Fugitive)                                ⌘ ,gr',
"         \'Gremove'],
"     \['▷ git mv           (Fugitive)                                ⌘ ,gm',
"         \'exe "Gmove " input("destino: ")'],
"     \['▷ git push         (Fugitive, salida por buffer)             ⌘ ,gp',
"         \'Git! push'],
"     \['▷ git pull         (Fugitive, salida por buffer)             ⌘ ,gP',
"         \'Git! pull'],
"     \['▷ git prompt       (Fugitive, salida por buffer)             ⌘ ,gi',
"         \'exe "Git! " input("comando git: ")'],
"     \['▷ git cd           (Fugitive)',
"         \'Gcd'],
"     \]
" nnoremap <silent>[menu]g :Unite -silent -start-insert menu:git<CR>

" Gundo
nnoremap <D-U> :GundoToggle<CR>

" TComment
map <D-'> :TComment<CR>
imap <D-'> <Esc>:TComment<CR>i

nnoremap <silent> <D-j> }
nnoremap <silent> <D-k> {

" Pandoc
function! MBeamer()
    let fname = expand("%:t")
    let fnametex = expand("%:r") . '.tex'
    silent! execute "!pandoc -s -o" . fnametex . " -Vlang=german -Vtheme:m --template mtheme.beamer -t beamer " . fname . " &"
    silent! execute "!xelatex -shell-escape -interaction=nonstopmode " . fnametex . " &"
    silent !
    sleep 5
    redraw!
endfunction

autocmd BufNewFile,BufRead *.md set filetype=pandoc
autocmd FileType pandoc nmap ,pp :Pandoc pdf<CR>
autocmd FileType pandoc nmap ,cp :!pandoc -s -o %:t:r.pdf -Vlang=german --variable mainfont="TeX Gyre Pagella" --latex-engine=xelatex % &<CR>:redraw!<CR>
autocmd FileType pandoc nmap ,cb :call MBeamer()<CR>
" autocmd FileType pandoc nmap ,cp :!pandoc -o %:t:r.pdf --variable mainfont="TeX Gyre Pagella" --latex-engine=xelatex --filter=markdown2dot % &<CR>:redraw!<CR>
" autocmd FileType pandoc nmap ,co :w<CR>:!llpp %:t:r.pdf &<CR>
" autocmd FileType pandoc nmap ,co :w<CR>:!mupdf %:t:r.pdf &<CR>
autocmd FileType pandoc nmap ,co :!open %:t:r.pdf &<CR>:redraw!<CR>
autocmd FileType pandoc let maplocalleader = ","

let g:pandoc#after#modules#enabled = ["ultisnips"]
" let g:pandoc_bibfiles = ['~/Documents/Uni/VL/Bibliography-complete.bib']
let g:pandoc#command#autoexec_on_writes = 1
" let g:pandoc#command#autoexec_command = "Pandoc -Vlang=german pdf"
let g:pandoc#command#latex_engine = "xelatex"
let g:pandoc#folding#fold_fenced_codeblocks = 1
let g:pandoc#spell#default_langs = ["de","en"]

" vimtex
augroup latexSurround
 autocmd!
 autocmd FileType tex call s:latexSurround()
augroup END

function! s:latexSurround()
 let b:surround_{char2nr("e")}
   \ = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
 let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"
endfunction

let g:vimtex_latexmk_options = "-xelatex -shell-escape"
let g:tex_flavor = 'latex'

let localleader = ","
nnoremap <leader>q gqip

" Easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" CamelCaseMotion
" replace traditional mappings of w, b, and e
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" Easy Align plugin
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" General mappings
" Allow mispelings when :wq-ing
cabbrev ew :wq
cabbrev qw :wq 

" Remove duplicate empty lines from file
nmap <leader>dl :v/./,/./-j<CR>

"Ultisnips
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Minibufexplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" WMGraphviz

" Thesaurus
" download from https://www.gutenberg.org/files/3202/files/mthesaur.txt
let g:lexical#thesaurus = ['~/.vim/thesaurus/mthesaur.txt',]

" Dash
nmap <silent> <leader>ds <Plug>DashSearch

" Ack
" use the silver searcher (ag)
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" FuGITive
nnoremap <Leader>L :<C-u>execute 'file'.fnameescape(resolve(expand('%:p')))<bar>
            \ call fugitive#detect(fnameescape(expand('%:p:h')))<CR>

" vim-licenses
let g:licenses_authors_name = 'Weissensel, Jonas <jweissensel@mailbox.org>'
let g:licenses_copyright_holders_name = 'Weissensel, Jonas <jweissensel@mailbox.org>'
let g:licenses_default_commands = ['gpl', 'mit', 'apache', 'lgpl']
