var  Web3  =  require('web3');  
web3  =  new  Web3(new  Web3.providers.HttpProvider('https://mainnet.infura.io/v3/1f9d14ce270340acbedafaa696071aab'));

var fs = require('fs');
var jsonFile = "./BTU_abi.json";
var abi = JSON.parse(fs.readFileSync(jsonFile));
var  addr  =  "0xb683D83a532e2Cb7DFa5275eED3698436371cc9f";
var  Contract  =  new  web3.eth.Contract(abi, addr);

console.log('Calling Contract.....');

// FUNCTION must the name of the function you want to call. 
Contract.methods.balanceOf("0xd804ab1667e940052614a5acd103dde4d298ce36").call().then(console.log);