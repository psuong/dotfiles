local mod = {}

function mod.expand_tilde(path)
    if path:sub(1, 1) == "~" then
        local home = os.getenv("HOME") or os.getenv("USERPROFILE")
        if home then
            return home .. path:sub(2);
        end
    end
    return path;
end

return mod;