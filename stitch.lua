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

--[[
    Format:

    {
        "path-to-stichable-stuff",
        "what-to.output"
    }
]]

local ver = 1.0
local toLog = {}
local toRead = ""
local outputFile = ""
local list = {}
local formattedList = {}
local logOutFile = "/stitch.log"

local function log(text)
    table.insert(toLog,text)
end

local function e(s)
    return s == nil or s == ""
end

local function outputTheLog()
    local handle = fs.open(logOutFile,"w")
    handle.writeLine("This is stitch v"..ver.." by Dusk, running with ".._HOST)
    handle.writeLine("+== Begin Log ==+")
    for k,v in pairs(toLog) do
        handle.writeLine(v)
    end
    handle.writeLine("+== End Log ==+")
    handle.close()
end

local args = {...}

if e(args[1]) then
    log("Erroring, arg1 is missing.")
    outputTheLog()
    error("Missing arg1, should be a file following format.",0)
else
    if fs.exists(args[1]) then
        if fs.isDir(args[1]) then
            log("Erroring, arg1 is a dir. ("..args[1]..")")
            outputTheLog()
            error(args[1].." is a directory. Gimme a file.",0)
        else
            print("Found "..args[1]..", which passes all checks at current time.")
            log("Found "..args[1]..", which passes all checks at current time.")
            toRead = args[1]
            log("assigned var 'toRead' same value as "..args[1])
            print("--debug--")
            print(toRead)
            print(args[1])
            log("[DEBUG] "..toRead.." | "..args[1])
            log("[DEBUG] ^^^ THESE SHOULD MATCH ^^^")
            print("Those should read the same. Continuing in 2s.")
            sleep(2)
        end
    else
        log("Erroring, arg1 does not exist. ("..args[1]..")")
        outputTheLog()
        error(args[1].." is either typed wrong or doesn't exist. Reminder that by default, ComputerCraft searches from the root ('/'), so either supply a full directory path or put the file in root. DO NOT FORGET ABOUT FILE HANDLES.",0)
    end
end

print("Going to try and open then read the supplied file.")
print("("..toRead..")")
log("Attempting to open the supplied file. ("..toRead..")")

local handle = fs.open(toRead,"r")
formattedList = handle.unserialize