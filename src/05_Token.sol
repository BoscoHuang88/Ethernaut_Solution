// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/*
Author: @BoscoHuang

Process:
- Deploy Token contract in anvil: 
    1. anvil
    1. forge create src/05_Token.sol:Token  --rpc-url http://127.0.0.1:8545 --private-key 0x.... --constructor-args 20
*/

contract Token {
    mapping(address => uint256) balances;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
}