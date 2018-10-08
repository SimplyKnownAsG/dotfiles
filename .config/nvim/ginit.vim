
colorscheme solarized_nvimqt
set spell spelllang=en_us
set background=dark

if g:os == "Darwin"
    Guifont Fira Mono:h12
elseif g:os == "Linux"
    Guifont Inconsolata:b:h16
elseif g:os == "Windows"
    Guifont Consolas:h10
endif
