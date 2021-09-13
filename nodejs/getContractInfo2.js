var  Web3  =  require('web3');  
web3  =  new  Web3(new  Web3.providers.HttpProvider('https://mainnet.infura.io/v3/1f9d14ce270340acbedafaa696071aab'));

var fs = require('fs');
var jsonFile = "./GetEbola_abi.json";
var abi = JSON.parse(fs.readFileSync(jsonFile));
var  ctr_addr  =  "0xe16f391e860420E65C659111c9e1601c0F8e2818";
var  Contract  =  new  web3.eth.Contract(abi, ctr_addr);

console.log('Calling Contract.....');

// FUNCTION must the name of the function you want to call. 
Contract.methods.getEbola().call().then(console.log);