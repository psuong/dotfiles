local function build()
    local handle = io.popen("dotnet build");
    if handle then
        local result = handle:read("*a");
        handle:close();
        vim.print(result);
    end
end

vim.api.nvim_create_user_command("DotNetBuild", build, {});

local noremap_silent = { noremap = true, silent = true };
vim.api.nvim_set_keymap("n", "<F3>", ":DotNetBuild<CR>", noremap_silent);
