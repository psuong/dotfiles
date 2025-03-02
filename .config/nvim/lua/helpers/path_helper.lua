local mod = {};

function mod.expand_tilde(path)
    if path:sub(1, 1) == "~" then
        local home = os.getenv("HOME") or os.getenv("USERPROFILE")
        if home then
            return home .. path:sub(2);
        end
    end
    return path;
end

function mod.file_exists(file_path)
    local file = io.open(file_path, "r");
    if file then
        file:close();
        return true;
    else
        return false;
    end
end

function mod.ensure_directory_exists(file_path)
    local dir = vim.fn.fnamemodify(file_path, ":p:h");
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p");
    end
end

function mod.read_json_file(file_path)
    local file = io.open(file_path, "r");
    if not file then
        print("Error: Could not open file!");
        return nil;
    end

    local content = file:read("*a")
    file:close();

    local data = vim.fn.json_decode(content);
    return data;
end

function mod.write_json_to_file(file_path, data)
    mod.ensure_directory_exists(file_path);
    local json_data = vim.fn.json_encode(data);
    local file = io.open(file_path, "w");
    if not file then
        vim.print(string.format("Failed to write file: %s", file_path));
        return;
    end

    file:write(json_data);
    file:close();
end

local clap_run = vim.fn["clap#run"];

local function index_of(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i;
        end
    end
    return 0;
end

function mod.file_picker(filter, callback)
    local cwd = vim.fn.getcwd();
    local handle = io.popen(string.format("fd -e %s -I", filter));
    if not handle then
        vim.g[filter] = vim.fn.input("Path to file: ", cwd, "file");
    else
        local result = handle:read("*a");
        handle:close();
        local clap_display_data = {};
        local paths = {};
        local index = 1;
        for file in result:gmatch("[^\r\n]+") do
            paths[index] = string.format("%s\\%s", cwd, file);
            clap_display_data[index] = file;
            index = index + 1;
        end

        local provider = {
            source = clap_display_data,
            on_move = function()
            end,
            sink = function(selected)
                local idx = index_of(clap_display_data, selected);
                if idx > 0 then
                    vim.g[filter] = paths[idx];
                    callback();
                else
                    vim.print("ERROR: Failed to pick a valid file.");
                end
            end,
            id = filter
        };

        clap_run(provider);
    end
end

return mod;
