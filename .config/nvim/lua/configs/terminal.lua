local terminal = {};

local function get_window_for_buffer(buf)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf then
            return win;
        end
    end
    return nil;
end

vim.keymap.set("n", "T", function()
    local current_buf = vim.api.nvim_get_current_buf();
    local height = 20;

    -- If it is a terminal, close it
    if vim.bo[current_buf].buftype == "terminal" then
        local terminal_windows = {};
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == current_buf then
                -- Close the window
                vim.api.nvim_win_close(win, true);
            else
                local buf = vim.api.nvim_win_get_buf(win);
                if vim.bo[buf].buftype == "terminal" then
                    table.insert(terminal_windows, win);
                end
            end
        end

        -- Now delete the buffer
        vim.api.nvim_buf_delete(current_buf, { force = true });

        -- Resize all other terminals too b/c it's too jarring
        -- local current_height = vim.api.nvim_win_get_height(vim.api.nvim_get_current_win());
        -- local new_height = math.ceil(current_height * 0.25);
        for _, win in ipairs(terminal_windows) do
            vim.api.nvim_win_set_height(win, height);
        end
    else
        -- If it isn't, create a new terminal
        vim.cmd("belowright split | terminal pwsh");
        current_buf = vim.api.nvim_get_current_buf();
        if vim.bo[current_buf].buftype == "terminal" then
            local window = get_window_for_buffer(vim.api.nvim_get_current_buf());
            if window then
                vim.api.nvim_win_set_height(window, height);
            end
        end
    end
end, { desc = "Toggle terminal in a horizontal split" });

vim.api.nvim_create_augroup("TerminalMappings", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.cmd("tnoremap <buffer> <Esc> <C-\\><C-n>")
    end,
});

return terminal;
