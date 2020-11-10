pragma solidity 0.6.11;

contract WhiteList {
	mapping(address => bool) whitelist;

	struct Person {
		string name;
		uint8 age;
	}
}