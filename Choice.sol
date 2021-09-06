// Choice.sol
// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract Choice {
    
    mapping(address => uint256) choices;
    
    function add(uint256 _myuint) public {
        choices[msg.sender] = _myuint;
    }
    
}