// Random.sol
// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract Random {
    
    uint256 private nonce = 0;
    
    function random() public returns (uint256 value){
        nonce += 1;
        return uint(keccak256(abi.encode(block.timestamp, msg.sender, nonce)));
    }
    
}