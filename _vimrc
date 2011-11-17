" ===================== 基本的な設定 ====================="
" 全体設定
set nocompatible        " 必ず最初に書く" VI互換OFF
set shellslash          " ディレクトリパスの区切り文字に/を使用可能にする"

" 文字コード
set enc=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac

" タブ周り
set tabstop=4           " タブの文字数
set shiftwidth=4        " indent,autoindentで挿入されるインデントの幅
set softtabstop=4       " Tabキー入力時に挿入される空白文字の文字数
set expandtab
set autoindent          " オートインデント
set smartindent         " スマートインデント
set smarttab            " スマートタブ
au BufNewFile,BufRead * set tabstop=4 shiftwidth=4 softtabstop=4 " タブ幅をリセット

" 入力補助
set backspace=indent,eol,start  " BSキーで何でも消せるようにする
set formatoptions+=m    " フォーマットオプションにマルチバイト系を追加
set whichwrap=b,s,h,l,<,>,[,]   " カーソルを行頭、行末で止まらないようにする
au BufNewFile,Bufread * set iminsert=0 " 日本語入力をリセット

" 検索関連
set nowrapscan          " 循環検索をON
set ignorecase          " 検索時に大文字、小文字を区別しない
set smartcase           " 検索文字を大文字で始めたら、大文字・小文字を区別する
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索文字をハイライト

" ファイル関連
set nobackup            " バックアップファイルを作らない
set autoread            " バックグラウンドで編集されたファイルを自動で開く
set noswapfile          " スワップファイルを作成しない
set hidden              " 編集中にも他のファイルを開けるようにする

" ===================== 表示設定 ====================="
set showmatch           " 括弧の対応をハイライト表示
set showcmd             " 入力中のコマンドを表示
set number              " 行番号を表示
set list                " 不可視文字の表示
set listchars=tab:>\ ,extends:<,trail:-   " 不可視文字の表示文字を指定
set scrolloff=5         " 行送り
syntax on               " シンタックス
set foldmethod=marker   " 折りたたみはマーカーで行う
set commentstring=//%s 

" ステータスライン
set laststatus=2
set statusline=%<%F
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%c/%l/%L:%p%%>

" インサートモードでステータスラインの色を変える
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

" クリップボード
set clipboard+=unnamed

" カーソル行をハイライト
set cursorline

" ===================== プラグインの設定 ====================="
" ====================================================================
" pathogen
" ====================================================================
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

" Javaの設定
"let java_highlight_all=1
"let java_highlight_functions="style"
"let java_allow_cpp_keywords=1

" ActionScript
"autocmd BufNewFile,BufRead *.as set filetype=actionscript
"autocmd BufNewFile,BufRead *.mxml set filetype=mxml

" ====================================================================
" NERD_comments
" ====================================================================
"let NERDSpaceDelims = 1
"let NERDShutUp = 1
"map ,c<space> <leader>c<Space>
"map ,cu <leader>cu
"map ,cs <leader>cs

" ====================================================================
" NERD_tree
" ====================================================================
let NERDTreeShowHidden = 1
map <silent> <C-d> :NERDTreeToggle<CR>

" ====================================================================
"VimFiler
" ====================================================================
map <silent> <C-e> :VimFiler %:p:h<CR>

" ====================================================================
"VimFiler
" ====================================================================
map <silent> <C-b> :NeoComplCacheEditSnippets<CR>

" ====================================================================
" Grep.vim
" ====================================================================
let Grep_Skip_Dirs = '.svn'
let Grep_Skip_Files = '*.bak *~'


" ====================================================================
" NeoComplCache
" ====================================================================
" 起動時に有効
let g:neocomplcache_enable_at_startup = 1
" 大文字・小文字を無視しない
let g:neocomplcache_enable_smart_case = 1
" シンタックスファイルの補完対象キーワードの最小文字数
let g:neocomplcache_min_syntax_length = 3
" 日本語をキャッシュしない
if !exists('g:neocomplcache_keyword_patterns')
	  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" スニペットファイルの場所
let g:neocomplcache_snippets_dir = $HOME.'/snippets'
" 1番目の候補を自動選択
let g:neocomplcache_enable_auto_select = 1
" プラグイン毎の補完関数を呼び出す文字数
let g:neocomplcache_plugin_completion_length = {
  \ 'snippets_complete'  : 2,
  \ 'keyword_complete'  : 2,
  \ 'syntax_complete'   : 2
  \ }
" ファイルタイプ毎の辞書ファイル
"let g:neocomplcache_dictionary_filetype_lists = {
"            \ 'default' : '',
"            \ 'java' : $HOME.'/.vim/dict/j2se14.dict', 
"            \ }

let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'php' : $HOME.'/dict/php.dict', 
            \ }

" Plugin key-mappings.
" Tab入力時に展開できるスニペットがあれば展開。それ以外はTab入力
imap <expr><TAB> Expand()
" Tab入力でスニペット展開
smap <TAB> <Plug>(neocomplcache_snippets_expand)
" 補完した内容を元に戻す
inoremap <expr><C-g> neocomplcache#undo_completion()
" Enter入力時に補完リストがあれば確定させる。
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

function! Expand()
	if neocomplcache#sources#snippets_complete#expandable() == 0
		return "\<TAB>"
	elseif neocomplcache#sources#snippets_complete#expandable() == 1
		return "\<Plug>(neocomplcache_snippets_expand)"
	elseif neocomplcache#sources#snippets_complete#expandable() == 2
		return "\<Plug>(neocomplcache_snippets_jump)"
	endif
endfunction

" taglist
let Tlist_Ctags_Cmd = "/opt/local/bin/ctags"
let g:tlist_javascript_settings = 'javascript;f:function;c:class;m:method'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
map <silent> ,tt :TlistToggle<CR>

""" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ===================== 環境変数の設定 ====================="
let $WORK = "~/Documents/workspace"
let $SNIPPET = "~/runtime/snippets"
let $RWORK = "~/Documents/RailsWorks"

" ===================== エイリアスの設定 ====================="
command! -nargs=* Nes NeoComplCacheEditSnippets <args>
filetype plugin indent on

" ============================================================"
"  キーマップの設定 
" ============================================================"

inoremap <C-E><C-S> command! -nargs=* Es NeoComplCacheEditSnippets


" ハイライトを消す
nmap <ESC><ESC> :nohlsearch<CR>
" Escape
imap jj <ESC>
" カッコなどを挿入したら自動的に中へ
inoremap {} {}<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap <C-(> t(
inoremap <C-)> t)
onoremap ( t(
onoremap ) t)
vnoremap { t{
vnoremap } t}
"バッファ管理
nmap <silent> <C-Tab> :bp!<CR>
nmap <silent> <C-S-Tab> :bn!<CR>
nmap <silent> <C-q> :bd<CR>
map <C-S> :tabnext<CR>
map <C-A> :tabprev<CR>
"入力モードでのカーソル移動
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
"window制御
noremap <C-h> <C-w>w 
noremap <C-l> <C-w>p
"ウィンドウサイズ設定
noremap <A-x> :simalt ~x<CR>
noremap <A-r> :simalt ~r<CR>
"Yank
noremap <S-z> :YRShow<CR>

"現在のバッファにカレントディレクトリ移動
augroup BufferAu
    autocmd!
    " カレントディレクトリを自動的に移動
    autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h")) && bufname("%") !~ "NERD_tree" | cd %:p:h | endif
augroup END

"透過設定
gui
set transparency=220

"内部Grep cw設定
au QuickfixCmdPost vimgrep cw

"拡張子別テンプレート
autocmd BufNewFile *.php 0r $HOME/template/php.txt

" カラースキーマ設定
colorscheme desert

