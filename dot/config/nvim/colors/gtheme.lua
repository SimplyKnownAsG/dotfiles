vim.g.colors_name = 'gtheme'

-- test with 
-- source $VIMRUNTIME/syntax/hitest.vim
local lush = require('lush')
local hsl = lush.hsl -- We'll use hsl a lot so its nice to bind it separately

local green = hsl("#004a00")
local bright_green = hsl("#b2ff94")
local dark_green = hsl("#001b00")
local bright_green2 = hsl("#55cf89")
local red = hsl("#cf555f")
local orange = hsl("#cf8855")
local yellow = hsl("#cfc555")
local yellow_green = hsl("#9ccf55")
local light_green = hsl("#5fcf55")
local seafoam_green = hsl("#55cf88")
local tealish = hsl("#55cfc5")
local blue_purple = hsl("#559ccf")
local purple_blue = hsl("#555fcf")
local purple = hsl("#8855cf")
local magenta = hsl("#c555cf")
local reddish_pink = hsl("#cf559c")
local white = hsl("#ffffff")
local mid_green = hsl("#238910")

local foreground = white
local background = dark_green
local highlight = bright_green

if vim.o.background == "light" then
  foreground = dark_green
  background = white
  highlight = yellow_green
end


local theme = lush(function()
  return {
    SpelunkerSpellBad {gui = "undercurl", sp=red },
    Normal { fg = foreground, bg = background, },
    ColorColumn { bg = green, },
    Cursor { bg = highlight, },
    CursorLineNr { fg = highlight, bg = background, },
    CursorLine { fg = highlight, bg = background, },
    LineNr { fg = mid_green, bg = background, },
    Conceal { fg = green, bg = background, },
    NonText { Conceal },
    Ignore { Conceal },
    SignColumn { fg = highlight, bg = background, },
    VertSplit { fg = green, bg = background, },
    MatchParen { fg = green, bg = highlight, },
    Search { fg = background, bg = reddish_pink, },
    IncSearch { fg = reddish_pink, bg = background, gui = "underline" },
    TabLine { fg = green, bg = background, },
    TabLineFill { fg = green, bg = background, },
    TabLineSel { fg = highlight, bg = background, },
    Pmenu { fg = highlight, bg = background, },
    PmenuSel { fg = magenta, bg = background, gui = "bold" },
    PmenuSbar { fg = highlight, bg = background, },
    PmenuThumb { fg = magenta, bg = background, },
    Comment { fg = mid_green, bg = background, gui = "italic" },
    SpecialComment { fg = highlight, bg = background, gui = "bold" },
    Todo { fg = green, bg = light_green, },
    Constant { fg = orange, bg = background, },
    Character { fg = magenta, bg = background, },
    Delimeter { fg = highlight, bg = green, },
    NvimParenthesis {fg = highlight, bg = green, },
    NvimComma { fg = highlight, bg = green, },
    NvimColon { fg = highlight, bg = green, },
    Conditional { fg = magenta, bg = background, },
    Label { fg = magenta, bg = background, },
    Operator { fg = red, bg = background, },
    Special { fg = foreground, bg = background, },
    PreProc { fg = orange, bg = background, gui = "bold" },
    Statement { fg = red, bg = background, gui = "bold" },
    Identifier { fg = reddish_pink, bg = background, gui = "bold" },
    StorageClass { fg = reddish_pink, bg = background, gui = "bold" },
    Type { fg = yellow, bg = background, gui = "bold" },
    Error { fg = foreground, bg = red, },
    ErrorMsg { fg = foreground, bg = red, },
    WarningMsg { fg = foreground, bg = orange, },
    Title { fg = magenta, bg = background, gui = "bold" },
    markdownIdDeclaration {fg = tealish, bg = background, gui = "bold" },
    markdownUrl { fg = tealish, bg = background, gui = "bold" },
    graphqlStructure { fg = red, bg = background, gui = "bold" },
    graphqlType { fg = yellow, bg = background, gui = "bold" },
    yamlKey { fg = red, bg = background, gui = "bold" },
    yamlBlockMappingKey {fg = red, bg = background, gui = "bold" },
    Directory { fg = magenta, bg = background, },
    DiffAdd { fg = highlight, bg = background, },
    diffAdded { fg = highlight, bg = background, },
    DiffDelete { fg = red, bg = background, },
    diffRemoved { DiffDelete },
    DiffChange { fg = foreground, bg = background, },
    DiffText { fg = tealish, bg = background, },
    diffFile { fg = highlight, bg = background, },
    gitcommitDiff { fg = reddish_pink, bg = background, },
    diffIndexLine { fg = yellow, bg = background, },
    diffLine { fg = magenta, bg = background, },
    RedrawDebugNormal {fg = background, bg = highlight, },
    RedrawDebugClear {fg = background, bg = yellow, },
    RedrawDebugComposed {fg = background, bg = red, },
    RedrawDebugRecompose {fg = background, bg = highlight, },
    ExtraWhitespace {fg = magenta, bg = background, gui = "underline" },
    NvimInternalError {fg = background, bg = red, },
  }
end)

lush.apply(theme)
