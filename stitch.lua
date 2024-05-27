-- Stitches files together into a single output.
-- Copyright (C) 2024 XDuskAshes
-- Licensed under the MIT License - <https://opensource.org/license/mit>

local args = {...}
local ver = 1.0
local jsonfile = args[1]

if not fs.exists(args[1]) then
    if not fs.exists("/"..shell.dir().."/"..args[1]) then
        error("Cannot find: "..args[1],0)
    else
        jsonfile = "/"..shell.dir().."/"..args[1]
    end
end

local handle = fs.open(jsonfile,"r")
local build = textutils.unserialiseJSON(handle.readAll())

local replaceTarget = build.opts.replaceTarget
local verbose = build.opts.verbose
local ignoreMissing = build.opts.ignoreMissing
local produceLog = build.opts.produceLog

if #build.files < 2 then
    print("Do you just want to move a single file? You know you can use 'move' for that right?")
    print("try 'move "..build.srcdir..build.files[1].." "..build.target.."'")
    error()
end

local listFiles = ""
print("Build name: "..build.name)
print("Target file: "..build.target)
print("Source files directory: "..build.srcdir)
write("Files to build with: ")
for k,v in pairs(build.files) do
    term.setTextColor(colors.green)
    write(v.." ")
    term.setTextColor(colors.white)
    listFiles = listFiles..v.." "
end
print("\n")

print("Ensuring needed files in "..build.srcdir.." exist for build...")
local missingFiles = {}
for k,v in pairs(build.files) do
    if fs.exists(build.srcdir..v) then
        print(v..": yes")
    else
        print(v.." :no")
        table.insert(missingFiles,v)
    end
    term.setTextColor(colors.white)
end

if #missingFiles > 0 then
    if #missingFiles == 1 then
        printError("A file is not present in "..build.srcdir..": "..missingFiles[1])
    else
        printError("Multiple files are not present in "..build.srcdir..":")
        for k,v in pairs(missingFiles) do
            print(v)
        end
    end

    if not ignoreMissing then
        print("And we are not ignoring failures, so error out.")
        print("=====\nMake sure you have all files needed listed in "..args[1]..", or change 'ignoreMissing' to 'false' in "..args[1]..".")
        error()
    else
        print("And we are ignoring failures, so continuing.")
    end
else
    print("All files present")
end

local function readFile(path)
    if not fs.exists(path) then
        return nil, "File does not exist: " .. path
    end
    local file = fs.open(path, "r")
    local content = file.readAll()
    file.close()
    return content
end

if verbose then
    print("-- STARTING BUILD --")

    if fs.exists(build.target) then
        write("Target already exists: "..build.target..",")
        if not replaceTarget then
            print("and we don't want to replace it, so error.")
            print("=====\nMake sure to either delete "..build.target.." or change the 'replaceTarget' value to 'true' in "..args[1]..".")
            error()
        else
            print("and we can replace it, so do that.")
            fs.delete(build.target)
            handle = fs.open(build.target,"w")
            handle.close()
        end
    else
        print("Target "..build.target.." doesn't exist, fresh build")
        handle = fs.open(build.target,"w")
        handle.close()
    end

    for k,v in pairs(build.files) do
        print(build.srcdir..v.." > "..build.target)

        local contents, err = readFile(build.srcdir..v)
        if contents then
            handle = fs.open(build.target,"a")
            handle.writeLine(contents)
        else
            error("Issue reading file "..build.srcdir..v..": "..err)
        end
        
        handle.close()
    end
    print("-- FINISHED BUILD --")
    write("Verifying "..build.target.." exists: ")
    if fs.exists(build.target) then
        print("yes")
    else
        error("no\nFile does not exist: "..build.target..", what went wrong?")
    end
else
    write("Building: ")

    if fs.exists(build.target) then
        if not replaceTarget then
            print("Not allowed to replace: "..build.target)
            print("=====\nMake sure to either delete "..build.target.." or change the 'replaceTarget' value to 'true' in "..args[1]..".")
            error()
        else
            fs.delete(build.target)
            handle = fs.open(build.target,"w")
            handle.close()
        end
    else
        handle = fs.open(build.target,"w")
        handle.close()
    end

    for k,v in pairs(build.files) do
        local contents, err = readFile(build.srcdir..v)
        if contents then
            handle = fs.open(build.target,"a")
            handle.writeLine(contents)
        else
            error("Issue reading file "..build.srcdir..v..": "..err)
        end
        
        handle.close()
    end

    print("done")

    write("Verifying build target exists: ")
    if fs.exists(build.target) then
        print("yes")
    else
        error("no\nFile does not exist: "..build.target..", what went wrong?")
    end
end