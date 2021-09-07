// Admin.sol
// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

contract Admin is Ownable {

	event eWhitelisted(address _address);
	event eBlacklisted(address _address);
	
	mapping(address => bool) whiteList;
	mapping(address => bool) blackList;

	address private admin;
	
	function whitelist(address _user) public onlyOwner() {
	    require(_user != address(0), "zero address cannot be whitelisted");
	    whiteList[_user] = true;
	    blackList[_user] = false;
	    emit eWhitelisted(_user);
	}
	
	function isWhitelisted(address _user) public view returns (bool _flag){
        return (whiteList[_user] ? true:false);	    
	}
	
	function blacklist(address _user) public onlyOwner() {
	    require(_user != address(0), "zero address cannot be blacklisted");
	    blackList[_user] = true;
	    whiteList[_user] = false;
	    emit eBlacklisted(_user);
	}
	
	function isBlacklisted(address _user) public view returns (bool _flag){
        return (blackList[_user] ? true:false);	    
	}
}