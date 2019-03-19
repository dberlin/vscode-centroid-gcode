import fs from "fs";
let machine_parameters = JSON.parse(
  fs.readFileSync("machine_parameters.json").toString()
);
let outputList = [];
for (let param of machine_parameters) {
  // Grab the last 3 numbers as an integer
  let paramNum = parseInt(
    param.name
      .split("")
      .reverse()
      .slice(0, 3)
      .reverse()
      .join("")
  );
  // Only parameters 0-399 and 900-999 are accessible from G-Code.
  if (paramNum > 399 && paramNum < 900) continue;
  outputList.push({
    name: `#${9000 + paramNum}`,
    detail: `"Machine parameter ${paramNum}`,
    documentation: param.documentation,
    kind: param.kind,
    sortText: `${9000 + paramNum}`.padStart(5, "0")
  });
}
console.log(JSON.stringify(outputList, null, 2));
