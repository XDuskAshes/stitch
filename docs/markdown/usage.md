# Stitch Docs - Usage

To use Stitch, do the following:

1. Download it

This can be done with ``wget https://raw.githubusercontent.com/XDuskAshes/stitch/main/stitch.lua`` while in your local ComputerCraft:Tweaked environment.

2. Create a collection of files to do something

Here's an example.

```
- [ / ]
| stitch.lua
| - [ example/ ]
  | - [ src/ ]
    | main.lua
    | useful-functions.lua
    | depends.lua
  | stitch.json
```

The 'stitch.json' should follow the rules outlined in the related JSON docs.
In this example, we follow this:

```json
{
    "name":"Example Lua File",
    "target":"/example/test.lua",
    "srcdir":"/example/src/",
    "files":["main.lua","useful-functions.lua","depends.lua"],
    "loglocation":"/example/stitch.log",
    "opts":{
        "replaceTarget":true,
        "verbose":true,
        "ignoreMissing":false,
        "produceLog":true
    }
}
```

3. Run Stitch

Run Stitch with the syntax ``stitch <file>``, replacing ``<file>`` with your JSON file. It can be a full path or in your
current directory. 

Stitch should provide a verbose output like this, in
this hypothetical:

```
> stitch /example/stitch.json
Build name: Example Lua File
Target file: /example/test.lua
Source files directory: /example/src/
Files to build with: main.lua useful-functions.lua depends.lua

Ensuring files in /example/src/ exist for build...
main.lua: yes
useful-functions.lua: yes
depends.lua: yes
All files present

-- STARTING BUILD --
Target /example/test.lua doesn't exist, fresh build
/example/src/main.lua > /example/test.lua
/example/src/useful-functions.lua > /example/test.lua
/example/src/depends.lua > /example/test.lua
-- FINISHED BUILD --

Verifying /example/test.lua exists: yes
Log produced at /example/stitch.log
```