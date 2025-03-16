-- Stitches files together into a single output.
-- Copyright (C) 2024-2025 XDuskAshes
-- Licensed under the MIT License - <https://opensource.org/license/mit>

local args = {...}
local ver = 2.0
local allFiles

local function parseCSV(input) -- Parse a CSV (Comma-Separated Value) string.
    local output = {}
    for value in (input..","):gmatch("(.-),") do
        table.insert(output, value)
    end
    return output
end

local function checkArgs() -- Checks args[2] and args[3] for the inputs.
    if not args[2] then
        error("I need a file to put these files into.",0)
    end

    if fs.exists(args[2]) then
        if not args[3] == "overwrite" then
            error("Already exists: "..args[2].."\nPass 'overwrite' at the end of your command to allow overwriting.")
        end
    end
end

if #args == 0 or args[1] == "help" and args[2] ~= "csv" then
    print("Stitch - A quick and simple file concatenator")
    print("Usage:\n stitch <csv> <output>")
    print("The <csv> field can either be a pre-made CSV (Comma-Separated Value) formatted file, or just a CSV-formatted string.")
    print("The <output> field is the output file.")
    print("You can also pass 'overwrite' as the third argument if the <output> already exists.")
    print("(Use 'stitch help csv' for more on CSV.)")
    return
elseif args[1] == "help" and args[2] == "csv" then
    print("Comma-Separated Value (CSV) is a simple format for listing values.")
    print("If you had a guy named John whose age is 30 and lives in New York, your CSV could look like:")
    print(" John,30,New York\n")
    print("In a Stitch-related example, if you had the files 'foo.lua' and 'bar.lua':")
    print(" foo.lua,bar.lua")
    return
end

if fs.exists(shell.resolve(args[1])) then
    checkArgs() -- see line 17
    local csvFile = fs.open(shell.resolve(args[1]),"r")
    allFiles = parseCSV(csvFile.readAll())
    csvFile.close()
else
    checkArgs() -- see line 17
    allFiles = parseCSV(args[1])
end

print("Writing to: "..args[2])
local outputFile = fs.open(args[2],"w")
for k,v in pairs(allFiles) do
    local inFile = fs.open(v,"r")
    outputFile.writeLine(inFile.readAll())
    inFile.close()
    print(v)
end
outputFile.close()
print("Done.")