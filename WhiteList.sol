pragma solidity 0.6.11;

contract WhiteList {
	
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
}