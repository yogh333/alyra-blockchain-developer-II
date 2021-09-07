// Bank.sol
// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract Bank {
    
    mapping(address => uint256) _balances;
    
    event eDeposit(address _address, uint256 _newbalance);
    event eTransfer(uint256 _senderbalance, uint256 _recipientbalance);
    
    function deposit(uint256 _amount) public payable {
        
        require(msg.value == _amount, "mismatch between _amount and value sent");
        
        _balances[msg.sender] += _amount;
        
        emit eDeposit(msg.sender, _balances[msg.sender]);
        
    }
    
    function transfer(address _recipient, uint256 _amount) public {
        
        require (_amount <= _balances[msg.sender], "Insufficient balance");
        
        _balances[msg.sender] -= _amount;
        _balances[_recipient] += _amount;
        
        emit eTransfer(_balances[msg.sender], _balances[_recipient]);
        
    }
    
    function balanceOf(address _address) public view returns (uint256 _amount) {
        return _balances[_address];
    }
}