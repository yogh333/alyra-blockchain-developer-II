// Time.sol
// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract Time {
    
    function getTime() external view returns (uint time){
        return block.timestamp;
    }
    
}