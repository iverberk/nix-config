return {
  'jake-stewart/multicursor.nvim',
  version = '*',
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({"n", "v"}, "<leader>dk", function() mc.lineAddCursor(-1) end, { desc = "Cursor above", silent = true })
    set({"n", "v"}, "<leader>dj", function() mc.lineAddCursor(1) end, { desc = "Cursor below", silent = true })
    set({"n", "v"}, "<leader>dK", function() mc.lineSkipCursor(-1) end, { desc = "Skip cursor above", silent = true })
    set({"n", "v"}, "<leader>dJ", function() mc.lineSkipCursor(1) end, { desc = "Skip cursor below", silent = true })

    -- Add or skip adding a new cursor by matching word/selection
    set({"n", "v"}, "<leader>dn", function() mc.matchAddCursor(1) end, { desc = "Next match", silent = true })
    set({"n", "v"}, "<leader>ds", function() mc.matchSkipCursor(1) end, { desc = "Skip next match", silent = true })
    set({"n", "v"}, "<leader>dN", function() mc.matchAddCursor(-1) end, { desc = "Prev match", silent = true })
    set({"n", "v"}, "<leader>dS", function() mc.matchSkipCursor(-1) end, { desc = "Skip prev match", silent = true })

    -- Add all matches in the document
    set({"n", "v"}, "<leader>da", mc.matchAllAddCursors, { desc = "All matches", silent = true })

    -- You can also add cursors with any motion you prefer:
    -- set("n", "<right>", function()
    --     mc.addCursor("w")
    -- end)
    -- set("n", "<leader><right>", function()
    --     mc.skipCursor("w")
    -- end)

    -- Rotate the main cursor.
    set({"n", "v"}, "<leader>dl", mc.nextCursor, { desc = "Next cursor", silent = true })
    set({"n", "v"}, "<leader>dh", mc.prevCursor, { desc = "Previous cursor", silent = true })
    --
    -- -- Delete the main cursor.
    set({"n", "v"}, "<leader>dd", mc.deleteCursor, { desc = "Delete cursor", silent = true })
    --
    -- -- Easy way to add and remove cursors using the main cursor.
    set({"n", "v"}, "<leader>dt", mc.toggleCursor, { desc = "Toggle cursor", silent = true })
    --
    -- -- Clone every cursor and disable the originals.
    -- set({"n", "v"}, "<leader><c-q>", mc.duplicateCursors)
    --
    set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        elseif mc.hasCursors() then
            mc.clearCursors()
        else
            -- Default <esc> handler.
        end
    end)
    --
    -- -- bring back cursors if you accidentally clear them
    -- set("n", "<leader>gv", mc.restoreCursors)
    --
    -- -- Align cursor columns.
    -- set("n", "<leader>a", mc.alignCursors)
    --
    -- -- Split visual selections by regex.
    -- set("v", "S", mc.splitCursors)
    --
    -- -- Append/insert for each line of visual selections.
    -- set("v", "I", mc.insertVisual)
    -- set("v", "A", mc.appendVisual)
    --
    -- -- match new cursors within visual selections by regex.
    -- set("v", "M", mc.matchCursors)
    --
    -- -- Rotate visual selection contents.
    -- set("v", "<leader>t",
    --     function() mc.transposeCursors(1) end)
    -- set("v", "<leader>T",
    --     function() mc.transposeCursors(-1) end)
    --
    -- -- Jumplist support
    -- set({"v", "n"}, "<c-i>", mc.jumpForward)
    -- set({"v", "n"}, "<c-o>", mc.jumpBackward)
    --
    -- -- Customize how cursors look.
    -- local hl = vim.api.nvim_set_hl
    -- hl(0, "MultiCursorCursor", { link = "Cursor" })
    -- hl(0, "MultiCursorVisual", { link = "Visual" })
    -- hl(0, "MultiCursorSign", { link = "SignColumn"})
    -- hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    -- hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    -- hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
  end
}
