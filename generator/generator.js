var fs  = require('fs');
var mockData = require('./mock-data');
var utils = require('./utils');

var boundaries = {
    person: 29,
    company: 5,
    address: 20,
    location: 5,
    conference: 20,
    conferenceDay: null,
    workshop: null,
    companyConferenceDayReservation: null,
    companyWorkshopReservation: null,
}

var memo = { // cache before writing to .csv
    conference: [],
    conferenceDay: [],
    companyConfereneDay: [],
    companyConferenceDayReservation: [],
    workshop: [],
    companyWorkshopReservation: [],
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
var conferenceDayId = 1;
for(var i = 1; i <= boundaries.conference; i++) {
    var foreignConference = memo.conference.find(conf => conf.id === i);
    var foreignConferenceStart = foreignConference.dateStart;
    var foreignConferenceEnd = foreignConference.dateEnd;

    var conferenceDuration = utils.daysBetween(foreignConferenceStart, foreignConferenceEnd);
    // console.log(conferenceDuration)
    for(var j = 0; j <= conferenceDuration; j++) {
        var date = utils.addDays(new Date(foreignConferenceStart), j);
    
        var capacity = utils.randomNumberOfLength(3);
        var price = utils.randomNumberOfLength(3) + '.99';
        var locationId = utils.randomFromTo(1, boundaries.location);

        memo.conferenceDay.push({
            id: conferenceDayId,
            conferenceId: i, 
            date: date.toLocaleDateString(),
            capacity: capacity,
            locationId,
            price
        });
        fConferenceDay.write(utils.stringifyObject([conferenceDayId++, i, date.toLocaleDateString(), capacity, locationId, price]))
    }
}
boundaries.conferenceDay = conferenceDayId - 1;

// One workshop for ine 
var fWorkshop = fs.createWriteStream("./csv/Workshop.csv")
fWorkshop.write("Id,Name,ConferenceDayId,Capacity,StartDateTime,DurationInMinutes,Price,AddressId\n");
var conferenceDayId = 1;
for(var i = 1; i <= boundaries.conferenceDay; i++) {

    var foreignConferenceDay = memo.conferenceDay.find(confDay => confDay.id === i);
    var workshopName = "How to " + utils.getRandomElement(mockData.frameworks) + " " + utils.getRandomElement(mockData.levelsOfExperience);
    var capacity = utils.randomNumberOfLength(2);
    var addressId = utils.randomFromTo(1, boundaries.address);

    var dateTime = new Date(foreignConferenceDay.date);
    dateTime.setUTCHours(utils.randomFromTo(10, 20));

    var startDateTime = dateTime.toISOString().slice(0, 19).replace('T', ' ');
    var durationInMinutes = utils.randomNumberOfLength(1) * 10;
    var price = utils.randomNumberOfLength(2) + '.99';

    memo.workshop.push({
        id: i,
        name: workshopName,
        conferenceDayId: i,
        capacity,
        startDateTime,
        durationInMinutes,
        price,
        addressId
    });

    fWorkshop.write(utils.stringifyObject([i, workshopName, i, capacity, startDateTime, durationInMinutes, price, addressId]))
}
boundaries.workshop = boundaries.conferenceDay;

var fCompanyConferenceDayReservation = fs.createWriteStream("./csv/CompanyConferenceDayReservation.csv")
fCompanyConferenceDayReservation.write("Id,ConferenceDayId,NumberOfPersons,CompanyId,Paid,ReservationDate\n");
var companyConferenceDayReservationId = 1;
for(var i = 1; i <= boundaries.conferenceDay; i++) {
    var foreignConferenceDay = memo.conferenceDay.find(confDay => confDay.id === i);

    // mock two reservations per conference day
    for(var j = 1; j < 3; j++) {
        var numberOfPersons = utils.randomNumberOfLength(2);   
        var companyId = utils.randomFromTo(1, boundaries.company);

        var daysBeforeConference = utils.randomFromTo(20, 60);
        var reservationDate = utils.addDays(new Date(foreignConferenceDay.date), -daysBeforeConference);
        
        memo.companyConferenceDayReservation.push({
            id: companyConferenceDayReservationId, 
            conferenceDayId: i, 
            numberOfPersons: numberOfPersons, 
            companyId: companyId, 
            paid: 0,
            reservationDate: reservationDate.toLocaleDateString()
        })

        fCompanyConferenceDayReservation.write(utils.stringifyObject([
            companyConferenceDayReservationId++, 
            i, 
            numberOfPersons, 
            companyId, 
            0,
            reservationDate.toLocaleDateString()
        ]))
    }
}
boundaries.companyConferenceDayReservation = companyConferenceDayReservationId - 1; // update after evaluating real number of iterations


// console.log(memo.companyConferenceDayReservation.map(el => el.numberOfPersons).reduce((prev, next) => prev + next), 0);

var fPersonConferenceDayReservation = fs.createWriteStream("./csv/PersonConferenceDayReservation.csv")
fPersonConferenceDayReservation.write("Id,CompanyReservationId,PersonId,ConferenceDayId,Paid,ReservationDate\n");
var personConferenceDayReservationId = 1;
for(var i = 1; i <= boundaries.companyConferenceDayReservation; i++) {
    var foreignCompanyConferenceDayReservation = memo.companyConferenceDayReservation.find(el => el.id === i);
    // console.log(i, foreignCompanyConferenceDayReservation);

    var foreignConferenceDay = memo.conferenceDay.find(confDay => confDay.id === foreignCompanyConferenceDayReservation.conferenceDayId);
    var foreignConferenceDayDate = foreignConferenceDay.date;
    // console.log(foreignConferenceDayDate);
    
    // fill all places in conference
    for(var j = 1; j < foreignCompanyConferenceDayReservation.numberOfPersons; j++) {
        var personId = utils.randomFromTo(1, boundaries.person);

        var daysBeforeConference = utils.randomFromTo(20, 60);
        var reservationDate = utils.addDays(new Date(foreignConferenceDayDate), -daysBeforeConference);
        
        fPersonConferenceDayReservation.write(utils.stringifyObject([
            personConferenceDayReservationId++, 
            i, 
            personId,
            foreignCompanyConferenceDayReservation.conferenceDayId, 
            0,
            reservationDate.toLocaleDateString()
        ]))
    }
}


// mock two reservations per workshop
var fCompanyWorkshopReservation = fs.createWriteStream("./csv/CompanyWorkshopReservation.csv")
fCompanyWorkshopReservation.write("Id,WorkshopId,CompanyId,NumberOfPersons,Paid,ReservationDate\n");
var companyWorkshopReservationId = 1;
for(var i = 1; i <= boundaries.workshop; i++) {
    var foreignWorkshop = memo.workshop.find(el => el.id === i);

    for(var j = 1; j < 3; j++) {
        var numberOfPersons = utils.randomNumberOfLength(2);   
        var companyId = utils.randomFromTo(1, boundaries.company);

        var daysBeforeWorkshop = utils.randomFromTo(20, 60);
        var reservationDate = utils.addDays(new Date(foreignWorkshop.startDateTime), -daysBeforeWorkshop);


        memo.companyWorkshopReservation.push({
          id: companyWorkshopReservationId,
          workshopId: i,
          companyId,
          numberOfPersons,
          paid: 0,
          reservationDate: reservationDate.toLocaleDateString()
        })

        fCompanyWorkshopReservation.write(utils.stringifyObject([
            companyWorkshopReservationId++, 
            i, 
            companyId, 
            numberOfPersons, 
            0,
            reservationDate.toLocaleDateString()
        ]))
    }
}
boundaries.companyWorkshopReservation = companyWorkshopReservationId - 1; // update after evaluating real number of iterations


var fPersonWorkshopReservation = fs.createWriteStream("./csv/PersonWorkshopReservation.csv")
fPersonWorkshopReservation.write("Id,WorkshopId,PersonId,CompanyReservationId,Paid,ReservationDate\n");
var personWorkshopReservationId = 1;
for(var i = 1; i <= boundaries.companyWorkshopReservation; i++) {
    var foreignCompanyWorkshopReservation = memo.companyWorkshopReservation.find(el => el.id === i);

    var foreignWorkshop = memo.workshop.find(el => el.id === foreignCompanyWorkshopReservation.workshopId);
    var foreignWorkshopDate = foreignWorkshop.startDateTime;
    
    // fill all places in conference
    for(var j = 1; j < foreignCompanyWorkshopReservation.numberOfPersons; j++) {
        var personId = utils.randomFromTo(1, boundaries.person);

        var daysBeforeWorkshop = utils.randomFromTo(20, 60);
        var reservationDate = utils.addDays(new Date(foreignWorkshopDate), -daysBeforeWorkshop);
        
        fPersonWorkshopReservation.write(utils.stringifyObject([
            personWorkshopReservationId++, 
            i, 
            personId,
            foreignCompanyWorkshopReservation.workshopId, 
            0,
            reservationDate.toLocaleDateString()
        ]))
    }
}
