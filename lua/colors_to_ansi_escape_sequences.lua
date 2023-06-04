-- RGB values from https://tweaked.cc/module/colors.html
local colorsRGB = {
    [0x1] = { 240, 240, 240 }, -- white
    [0x2] = { 242, 178, 51 }, -- orange
    [0x4] = { 229, 127, 216 }, -- magenta
    [0x8] = { 153, 178, 242 }, -- lightBlue
    [0x10] = { 222, 222, 108 }, -- yellow
    [0x20] = { 127, 204, 25 }, -- lime
    [0x40] = { 242, 178, 204 }, -- pink
    [0x80] = { 76, 76, 76 }, -- gray
    [0x100] = { 153, 153, 153 }, -- lightGray
    [0x200] = { 76, 153, 178 }, -- cyan
    [0x400] = { 178, 102, 229 }, -- purple
    [0x800] = { 51, 102, 204 }, -- blue
    [0x1000] = { 127, 102, 76 }, -- brown
    [0x2000] = { 87, 166, 78 }, -- green
    [0x4000] = { 204, 76, 76 }, -- red
    [0x8000] = { 17, 17, 17 }, -- black
}

function term.setPaletteColour(...)
    local args = { ... }
    local r, g, b
    if #args == 2 then
        r = bit32.band(bit32.rshift(args[2], 16), 0xFF)
        g = bit32.band(bit32.rshift(args[2], 8), 0xFF)
        b = bit32.band(args[2], 0xFF)
    else
        r, g, b = args[2] * 255, args[3] * 255, args[4] * 255
    end
    colorsRGB[args[1]] = {
        math.floor(r),
        math.floor(g),
        math.floor(b),
    }
end

local function colorToRGB(color)
    return unpack(colorsRGB[color])
end

term.setPaletteColor = term.setPaletteColour

function term.getPaletteColour(colour)
    local r, g, b = colorToRGB(colour)
    return r / 255, g / 255, b / 255
end

term.getPaletteColor = term.getPaletteColour

local function fromBlit(hex)
    return 2 ^ tonumber(hex, 16)
end

function term.blit(text, textColour, backgroundColour)
    if #text ~= #textColour or #text ~= #backgroundColour then
        error("Arguments must be the same length")
    end
    local stringBuilder = {}
    for i = 1, #text do
        local char = text:sub(i, i)
        local textCode = textColour:sub(i, i)
        local backgroundCode = backgroundColour:sub(i, i)

        local fr, fg, fb = term.getPaletteColour(fromBlit(textCode))
        local br, bg, bb = term.getPaletteColour(fromBlit(backgroundCode))
        fr, fg, fb = fr * 255, fg * 255, fb * 255
        br, bg, bb = br * 255, bg * 255, bb * 255

        table.insert(stringBuilder, "\27[38;2;" .. fr .. ";" .. fg .. ";" .. fb .. "m")
        table.insert(stringBuilder, "\27[48;2;" .. br .. ";" .. bg .. ";" .. bb .. "m")
        table.insert(stringBuilder, char)
    end
    term.write(table.concat(stringBuilder) .. "\27[39m\27[49m")
end

local _setTextColour = term.setTextColour

function term.setTextColour(colour)
    local r, g, b = colorToRGB(colour)
    term.write("\27[38;2;" .. r .. ";" .. g .. ";" .. b .. "m")
    _setTextColour(colour)
end

term.setTextColor = term.setTextColour

local _setBackgroundColour = term.setBackgroundColour

function term.setBackgroundColour(colour)
    local r, g, b = colorToRGB(colour)
    term.write("\27[48;2;" .. r .. ";" .. g .. ";" .. b .. "m")
    _setBackgroundColour(colour)
end

term.setBackgroundColor = term.setBackgroundColour
