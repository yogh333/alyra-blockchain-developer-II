// Audit.sol
// SPDX-License-Identifier: MIT
//pragma solidity ^0.5.12; // compiler version shall be set
pragma solidity <0.9.0; // compiler version shall be set
 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
 
contract Crowdsale {
   using SafeMath for uint256; // manque import SafeMath
 
    // state variable shall be private to prevent public getters
   address private owner; // the owner of the contract
   address payable private escrow; // wallet to collect raised ETH
   uint256 private savedBalance = 0; // Total amount raised in ETH
   mapping (address => uint256) private balances; // Balances in incoming Ether
 
   // Initialization
   constructor(address payable _escrow) {
       //owner = tx.origin; // never use tx.origin !!
       owner = msg.sender;
       // add address of the specific contract
       escrow = _escrow;
   }
  
   // function to receive ETH
   //function() public { // receive or fallback function is missing (mandatory to receive ethers)
   receive() external payable {
       balances[msg.sender] = balances[msg.sender].add(msg.value);
       savedBalance = savedBalance.add(msg.value);
       //escrow.send(msg.value); // use transfer or call (to size gaz); check return value at least (boolean != false)
       escrow.transfer(msg.value);
   }
  
   // refund investisor
   function withdrawPayments() public{ // require is missing
       require(balances[msg.sender] != 0, "no balance for you");
       address payable payee = payable(msg.sender);
       
       uint256 payment = balances[payee];
       
       savedBalance = savedBalance.sub(payment); //update state variable before calling send() (reentrancy issue)
       balances[payee] = 0;
       
       //payee.send(payment); // use transfer
       payee.transfer(payment);
 
       //savedBalance = savedBalance.sub(payment); //update state variable before calling send() (reentrancy issue)
       //balances[payee] = 0;
   }
}