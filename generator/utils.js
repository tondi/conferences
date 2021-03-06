function stringifyObject(...args) {
    let res = ""
    for(let y = 0; y < args.length; y++) {
        res += args
        if(y != args.length - 1){
            res += ","
        }
    }
    res += "\r\n"
    return res
}

function randomNumberOfLength(length) {
    return Number(new Array(length).fill(null).map(_ => Math.round(Math.random() * 9)).join(''));
}

function randomToMax(max) {
    return Math.round(Math.random() * max);
}

function randomFromTo(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min);
}

function getRandomElement(arr) {
    var dumbIndex = Math.round(Math.random() * arr.length);
    var properIndex = dumbIndex > arr.length - 1 ? arr.length - 1 : dumbIndex;
    // console.log(properIndex, arr, arr[properIndex])
    return arr[properIndex];
}

function randomDate(start = new Date('01-01-2020'), end = new Date('01-01-2026')) {
    return new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
}

function addDays(date, days) {
    const copy = new Date(Number(date));
    copy.setDate(date.getDate() + days);
    return copy;
}

function treatAsUTC(date) {
    var result = new Date(date);
    result.setMinutes(result.getMinutes() - result.getTimezoneOffset());
    return result;
}

function daysBetween(startDate, endDate) {
    var millisecondsPerDay = 24 * 60 * 60 * 1000;
    return (treatAsUTC(endDate) - treatAsUTC(startDate)) / millisecondsPerDay;
}

module.exports = {
    stringifyObject,
    randomNumberOfLength,
    randomToMax,
    randomFromTo,
    getRandomElement,
    randomDate,
    addDays,
    daysBetween
}