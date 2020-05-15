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
    return new Array(length).fill(null).map(_ => Math.round(Math.random() * 9)).join('');
}

module.exports = {
    stringifyObject,
    randomNumberOfLength
}