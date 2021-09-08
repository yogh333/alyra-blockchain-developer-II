// Pullpayment.sol
// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/security/PullPayment.sol";

contract PoP is PullPayment {
    
    address highestBidder;
    uint highestBid;

    function bid() payable external {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            _asyncTransfer(highestBidder, highestBid);
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    
    function bestBidder() external view returns (address _bidder, uint256 _bid) {
        _bidder = highestBidder;
        _bid = highestBid;
    }
}