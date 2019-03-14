var js2yaml = require("js-yaml")
var fs = require("fs")
var fileData = JSON.parse(fs.readFileSync(process.argv[2]).toString())
console.log(js2yaml.safeDump(fileData))
