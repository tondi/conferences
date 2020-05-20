var fs  = require('fs');
var mockData = require('./mock-data');
var utils = require('./utils');

var boundaries = {
    person: 29,
    company: 5,
    address: 20,
    location: 5,
    conference: 20,
    conferenceDay: 50,
}

var memo = { // cache before writing to .csv
    conference: []
}

var fPerson = fs.createWriteStream("./csv/Person.csv")
fPerson.write("Id,Name,CompanyId,StudentIdNumber\n");
for(var i = 0; i < boundaries.person; i++) {
    var isStudent = Math.random() < 0.33; // approx one third will be students
    var studentId = isStudent ? utils.randomNumberOfLength(6) : '';

    fPerson.write(utils.stringifyObject([i + 1, mockData.maleFirstNames[i] + " " + mockData.surnames[boundaries.person - i], 1, studentId]))
}

var fCompany = fs.createWriteStream("./csv/Company.csv")
fCompany.write("Id,Name,ContactNumber,ContactPerson\n");
for(var i = 0; i < boundaries.company; i++) {
    var isStudent = Math.random() < 0.33; // approx one third will be students
    var studentId = isStudent ? new Array(6).fill(null).map(_ => Math.round(Math.random() * 9)).join('') : '';

    fCompany.write(utils.stringifyObject([i, mockData.companies[i], utils.randomNumberOfLength(9), mockData.maleFirstNames[i] + " " + mockData.surnames[i]]))
}

// let fLocation = fs.createWriteStream("./csv/Address.csv")
// fAddress.write("Id,Name,ContactNumber,ContactPerson\n");
// for(var i = 0; i < 10; i++) {
//     var isStudent = Math.random() < 0.33; // approx one third will be students
//     var studentId = isStudent ? new Array(6).fill(null).map(_ => Math.round(Math.random() * 9)).join('') : '';

//     fAddress.write(utils.stringifyObject([i, 'test', 2]))
// }

var fAddress = fs.createWriteStream("./csv/Address.csv")
fAddress.write("Id,LocationId,Street,BuildingNumber,Room\n");
for(var i = 0; i < boundaries.address ; i++) {
    var locationId = utils.randomToMax(boundaries.location - 1);

    var streetIndex = Math.round(Math.random() * mockData.streets.length - 1);
    var street = mockData.streets[streetIndex];
    
    fAddress.write(utils.stringifyObject([i + 1, locationId , street, utils.randomNumberOfLength(2), utils.randomNumberOfLength(3)]))
}

var fLocation = fs.createWriteStream("./csv/Location.csv")
fLocation.write("Id,City,Country\n");
for(var i = 0; i < boundaries.location ; i++) {
    var country = utils.getRandomElement(mockData.countries).name;
    var city = utils.getRandomElement(mockData.cities);

    fLocation.write(utils.stringifyObject([i + 1, city, country]))
}

var fConference = fs.createWriteStream("./csv/Conference.csv")
fConference.write("Id,Name,StartDate,EndDate,StudentDiscount\n");
for(var i = 0; i < boundaries.conference ; i++) {
    var name = utils.getRandomElement(mockData.frameworks) + " " + utils.getRandomElement(mockData.levelsOfExperience);
    var dateStart = utils.randomDate();

    var dateEnd = utils.addDays(dateStart, Number(utils.randomNumberOfLength(1)));

    var studentDiscount = utils.randomNumberOfLength(2);

    memo.conference.push({
        id: i + 1,
        name, 
        dateStart: dateStart.toLocaleDateString(),
        dateEnd: dateEnd.toLocaleDateString(),
        studentDiscount
    });
    fConference.write(utils.stringifyObject([i + 1, name, dateStart.toLocaleDateString(), dateEnd.toLocaleDateString(), utils.randomNumberOfLength(2)]))
}

var fConferenceDay = fs.createWriteStream("./csv/ConferenceDay.csv")
fConferenceDay.write("Id,ConferenceId,Date,Capacity,LocationId,Price\n");
for(var i = 0; i < boundaries.conferenceDay ; i++) {
    var conferenceId = utils.randomFromTo(1, boundaries.conference);
    
    var foreignConference = memo.conference.find(conf => conf.id === conferenceId);
    var foreignConferenceStart = foreignConference.dateStart;
    var foreignConferenceEnd = foreignConference.dateEnd;

    var date = utils.randomDate(new Date(foreignConferenceStart), new Date(foreignConferenceEnd));

    var locationId = utils.randomToMax(1, boundaries.location);

    fConferenceDay.write(utils.stringifyObject([i + 1, conferenceId, date.toLocaleDateString(), utils.randomNumberOfLength(3), locationId, utils.randomNumberOfLength(3) + '.99']))
}