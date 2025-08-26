# Stitch

A tool for ComputerCraft:Tweaked somewhat inspired by Linux/\*NIX `make` with a lot of liberties taken. This is a simple and fast file concatenator.

As if a practical application would happen.

# Documentation

`/docs/how-to.txt`:
```
Stitch v2.0 and onward - a how-to

Stitch requires two things: A file listing a bunch of files to put together and an output file.

The listing of files is in a Comma-Separated Value (CSV) format. You can either provide a CSV
file or just a CSV-format string. Either works. You'll need to provide an output file after
that so Stitch knows what to do with all the files you just told it to put together.

Note: for now, all file paths must be abolute paths.

Examples:

-- With a CSV file pre-made: --

The CSV file could look like:
-----
/src/foo.lua,/src/hello.lua,/src/somelib.lua,/src/bar.lua
-----

And the command could look like: `stitch stitch.csv baz.lua`

-- Without a CSV file pre-made: --

The command could look like: `stitch src/foo.lua,/src/hello.lua,/src/somelib.lua baz.lua`



The CSV contents can be any length only to the limits of your environment or system memory.

If the output file already exists, you can put 'overwrite' on the end to forcefully overwrite it.

This is all intentionally simple as Stitch v1.0 was overly complex. I decided on a simple way
to shove files together.
```

# Contributing

Contributing is easy. Fork the repo, make your changes, and toss a pull request in. I'll review it and if it solves a valid problem and doesn't make 100 more, it'll get accepted.
