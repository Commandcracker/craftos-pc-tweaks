local term_write = term.write
local io_output = io.output
local io_write = io.write
local currentOutput = io.stdout

function _G.io.output(...)
    currentOutput = io_output(...)
    return currentOutput
end

function _G.io.write(...)
    if currentOutput ~= io.stderr and currentOutput ~= io.stdout then
        return io_write(...)
    end

    if currentOutput == io.stderr then
        if term.getPaletteColour then
            local r, g, b = term.getPaletteColour(0x4000) -- colors.red
            term_write("\27[38;2;" .. r * 255 .. ";" .. g * 255 .. ";" .. b * 255 .. "m")
        else
            term_write("\27[38;2;204;76;76m")
        end
    end
    term_write(table.concat({ ... }))
    if currentOutput == io.stderr then
        term_write("\27[39m")
    end
    return currentOutput
end

function _G.write(...)
    term_write(...)
    return 0
end

function _G.print(...)
    local line_count = 1
    local lines = {}
    for i = 1, select("#", ...) do
        local str = tostring(select(i, ...))
        for _ in str:gmatch("\n") do
            line_count = line_count + 1
        end
        table.insert(lines, str)
    end
    term_write(table.concat(lines, " ") .. "\n")
    return line_count
end
