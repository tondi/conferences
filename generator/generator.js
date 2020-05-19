var fs  = require('fs');
var mockData = require('./mock-data');
var utils = require('./utils');

var boundaries = {
    person: 29,
    company: 5,
}

let fPerson = fs.createWriteStream("./csv/Person.csv")
fPerson.write("Id,Name,CompanyId,StudentIdNumber\n");
for(var i = 0; i < boundaries.person; i++) {
    var isStudent = Math.random() < 0.33; // approx one third will be students
    var studentId = isStudent ? utils.randomNumberOfLength(6) : '';

    fPerson.write(utils.stringifyObject([i + 1, mockData.maleFirstNames[i] + " " + mockData.surnames[boundaries.person - i], 1, studentId]))
}

let fCompany = fs.createWriteStream("./csv/Company.csv")
fCompany.write("Id,Name,ContactNumber,ContactPerson\n");
for(var i = 0; i < boundaries.company; i++) {
    var isStudent = Math.random() < 0.33; // approx one third will be students
    var studentId = isStudent ? new Array(6).fill(null).map(_ => Math.round(Math.random() * 9)).join('') : '';

    fCompany.write(utils.stringifyObject([i, mockData.companies[i], utils.randomNumberOfLength(9), mockData.maleFirstNames[i] + " " + mockData.surnames[i]]))
}

// let fAddress = fs.createWriteStream("./csv/Address.csv")
// fAddress.write("Id,Name,ContactNumber,ContactPerson\n");
// for(var i = 0; i < 10; i++) {
//     var isStudent = Math.random() < 0.33; // approx one third will be students
//     var studentId = isStudent ? new Array(6).fill(null).map(_ => Math.round(Math.random() * 9)).join('') : '';

//     fAddress.write(utils.stringifyObject([i, 'test', 2]))
// }
