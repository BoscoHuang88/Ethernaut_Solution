// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Author: @BoscoHuang

Process:
- Deploy Fallout contract in anvil: 
    1. anvil
    1. forge create src/04_Telephone.sol:Telephone  --rpc-url http://127.0.0.1:8545 --private-key 0x....
*/

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}