const fs = require('fs');
const mnemonic = fs.readFileSync(".secret").toString().trim();
require('dotenv').config()


console.log(mnemonic)
console.log('https://ropsten.infura.io/v3/'+process.env.INFURA_ID)