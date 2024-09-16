local mod = {}

--- Treats a number as a boolean
---@param value number
function mod.as_bool(value)
    return value == 1
end

return mod
