--[[
    Stitches files together into a single output.
    Copyright (C) 2023  Dusk

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

local args = {...}

local function e(s)
    return s == "" or s == nil
end

if e(args[1]) then
    error("Need a file. See docs.",0)
end

if e(args[2]) then
    error("Need a file to output to. See docs.",0)
end

local function isAFile(s)
    if not fs.exists(s) then
        return false
    else
        if fs.isDir(s) then
            return false
        else
            return true
        end
    end
end

local arg1IsFile = isAFile(args[1])
local arg2Exists = isAFile(args[2])

if arg1IsFile == false then
    error("Either '"..args[1].."' doesn't exist or is a directory.",0)
end

if arg2Exists == true then
    error("File '"..args[2].."' already exists.",0)
elseif fs.isDir(args[2]) then
    error("'"..args[2].."' is a directory.",0)
end

local handle

local instructions = {}

handle = fs.open(args[2],"w")
handle.writeLine("")
handle.close()

handle = fs.open(args[1],"r")

repeat   
    local a = handle.readLine()
    table.insert(instructions,a)
until e(a)

handle.close()

for k,v in pairs(instructions) do
    print(k,v)
    local toWrite = {}
    
    handle = fs.open(v,"r")
    repeat   
        local a = handle.readLine()
        table.insert(toWrite,a)
    until a == nil
    handle.close()

    handle = fs.open(args[2],"a")
    for k,v in pairs(toWrite) do
        handle.writeLine(v)
    end
    handle.close()
end
