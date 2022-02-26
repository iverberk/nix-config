local colorscheme = require('base16-colorscheme')
local hi = colorscheme.highlight

colorscheme.setup('tomorrow-night-eighties')

hi.VertSplit = { guifg='#373b41' }
hi.IndentBlanklineChar    = { guifg='#444444', gui='nocombine' }
hi.TelescopeSelection     = 'Visual'
hi.TelescopeNormal        = 'Normal'
hi.TelescopePromptNormal  = 'TelescopeNormal'
hi.TelescopeBorder        = 'TelescopeNormal'
hi.TelescopePromptBorder  = 'TelescopeBorder'
hi.TelescopeTitle         = 'TelescopeBorder'
hi.TelescopePromptTitle   = 'TelescopeTitle'
hi.TelescopeResultsTitle  = 'TelescopeTitle'
hi.TelescopePreviewTitle  = 'TelescopeTitle'
hi.TelescopePromptPrefix  = 'Identifier'
