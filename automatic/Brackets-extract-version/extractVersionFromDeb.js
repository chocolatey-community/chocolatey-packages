/*jslint node: true*/

var ar = require('ar'),
    fs = require('fs'),
    path = require('path'),
    targz = require('tar.gz'),
    rimraf = require('rimraf');

var outputDir = path.resolve(__dirname, "output-brackets"),
    archive,
    files,
    i;

if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir);
}

archive = new ar.Archive(fs.readFileSync("C:/Chocolatey/_work/brackets.deb"));
files = archive.getFiles();
for (i = 0; i < files.length; i += 1) {
    var file = files[i];
    if (file.name() === "control.tar.gz") {
        fs.writeFileSync(path.resolve(outputDir, file.name()), file.fileData());
    }
}

var compress = new targz().extract(path.resolve(outputDir, "control.tar.gz"), outputDir, function (err) {
    "use strict";
    if (err) {
        console.log(err);
    }

    console.log('The extraction has ended!');
    
    var controlContent = fs.readFileSync(path.resolve(outputDir, "control")).toString(),
        bracketsVersion,
        nuspecFile,
        nuspecContent;
    
    // remove all files in output folder
    rimraf(outputDir, function () {
        console.log("Deleted " + outputDir + " folder");
    });
    
    bracketsVersion = controlContent.match(/Version: [\d\.\-]+/g).toString().replace("Version: ", "");
    
    fs.writeFileSync(path.resolve(__dirname, "brackets-version.txt"), "<version>" + bracketsVersion + "</version>");
    
});
