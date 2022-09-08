require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/Documents/Neorg/notes/work",
                    home = "~/Documents/Neorg/notes/home",
                }
            }
        }
    }
}
