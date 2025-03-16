# Stitch Docs - JSON

Sitch uses JSON for build information such as build name, files it needs,
target output file, build opts, etc. Here's an example right from the tests
in the Stitch repository.

```json
{
    "name":"Basic text file",
    "target":"/tests/basic-text-file/output.txt",
    "srcdir":"/tests/basic-text-file/part/",
    "files":["first.txt","second.txt"],
    "loglocation":"/tests/basic-text-file/stitch.log",
    "opts":{
        "replaceTarget":true,
        "verbose":true,
        "ignoreMissing":false,
        "produceLog":true
    }
}
```

Breaking this down, we immediately establish the most important details:
* Name
* Target output
* Source directory
* Files needed in the source directory

These are the absolute minimum. I could stop there, but I added more
functionality with logging and build options.

* ``replaceTarget``
    * Tells Stitch whether or not to replace the target file if it already exists.
    
* ``verbose``
    * Tells Stitch whether or not to word vomit to terminal.
* ``ignoreMissing``
    * Tells Stitch whether or not to ignore missing files at build time.
* ``produceLog``
    * Tells Stitch whether or not to produce a log.

Making a proper JSON file for Stitch to work with quite literally makes
Stitch run.