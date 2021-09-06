// WhiteList.sol
// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract WhiteList {

	event Authorized(address _address);
	
	mapping(address => bool) whitelist;

	struct Person {
		string name;
		uint8 age;
	}

	Person[] public people;

	function addPerson(string memory _name, uint8 _age) public {
		Person memory person = Person(_name, _age);
		people.push(person);
	}

	function removePerson() public {
		people.pop();
	}
	
	function authorize(address _address) external {
	    whitelist[_address] = true;
	    emit Authorized(_address);
	}
}