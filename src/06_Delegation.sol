// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Author: @BoscoHuang

Process:
- Deploy Token contract in anvil: 
    0. anvil
    1. forge create src/06_Delegation.sol:Delegate  --rpc-url http://127.0.0.1:8545 --private-key 0x.... --constructor-args 0x
    2. forge create src/06_Delegation.sol:Delegation  --rpc-url http://127.0.0.1:8545 --private-key 0x.... --constructor-args 0x....
*/

contract Delegate {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {
    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress) {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    fallback() external {
        (bool result,) = address(delegate).delegatecall(msg.data);
        if (result) {
            this;
        }
    }
}