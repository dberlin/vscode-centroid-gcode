import fs from "fs";
import js2yaml from "js-yaml";
var fileData = js2yaml.safeLoad(fs.readFileSync(process.argv[2]).toString());
let outputList = [];
// Perform name expansion and sort order generation
let numericRegexp = new RegExp("[gGmM]([0-9]+)");
for (const item of fileData) {
  for (const codeName of item["name"].split(new RegExp(", "))) {
    let namePieces = numericRegexp.exec(codeName);
    if (!namePieces) continue;
    let nameVal = parseInt(namePieces[1]);
    let sortVal = codeName[0] + nameVal.toString().padStart(4, "0");
    outputList.push({
      name: codeName.trim(),
      kind: item["kind"],
      detail: item["detail"],
      documentation: item["documentation"],
      sortText: sortVal
    });
  }
}
console.log(JSON.stringify(outputList, null, 2));
