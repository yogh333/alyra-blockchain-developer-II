// HelloWorld.sol
// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract HelloWorld {
    
    string myString="Hello World !";
    
    function hello() external view returns (string memory){
        return myString;
    }

} 