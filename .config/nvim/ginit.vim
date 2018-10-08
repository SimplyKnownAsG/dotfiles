
colorscheme solarized_nvimqt
set spell spelllang=en_us
set background=dark

if g:os == "Darwin"
    GuiFont Fira Mono:h12
elseif g:os == "Linux"
    GuiFont Inconsolata:h16
elseif g:os == "Windows"
    GuiFont Consolas:h10
endif
