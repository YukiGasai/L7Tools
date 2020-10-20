const fs = require('fs');

const BackgroundFolderPath = 'C:\\Users\\Richard\\Pictures\\02\\';
const filePath = 'C:\\Users\\Richard\\AppData\\Local\\Packages\\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\\LocalState\\settings.json';

const Filearray = [];

fs.readdir(BackgroundFolderPath, function (err, Filearray) {
  if (err) console.log('Unable to scan ' + BackgroundFolderPath + " :" + err);

  var index = Math.floor(Math.random() * Filearray.length);

  fs.readFile(filePath, 'utf8', function(err, content){

    if(err)console.log(err);

    JsonString = content.replace(/ \/\/.*/g, "");

    var JsonObj = JSON.parse(JsonString);
    console.log(Filearray[index]);
    JsonObj.profiles.defaults.backgroundImage = BackgroundFolderPath + Filearray[index];
    const data =  JSON.stringify(JsonObj);

    fs.writeFile(filePath, data, (err) => {
      if (err) {
        throw err;
      }
      console.log("JSON data is saved.");
    });
  });
});
