// contracts/MyContract.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ERC20Token is ERC20 {
	/**
    * @dev Sets the values for {name} and {symbol}, initializes {decimals} with
    * a default value of 18.
    *
    * To select a different value for {decimals}, use {_setupDecimals}.
    *
    * All three of these values are immutable: they can only be set once during
    * construction.
    */
   constructor(uint256 initialSupply) public ERC20("ALYRA", "ALY") {
       _mint(msg.sender, initialSupply);
   }
}