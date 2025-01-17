// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/*
Author: @BoscoHuang

Process:
- Deploy Token contract in anvil: 
    0. anvil
    1. forge create src/08_Vault.sol:Vault  --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --constructor-args 0x412076657279207374726f6e67207365637265742070617373776f7264203a29
*/


contract Vault {
    bool public locked;
    bytes32 private password;

    constructor(bytes32 _password) {
        locked = true;
        password = _password;
    }

    function unlock(bytes32 _password) public {
        if (password == _password) {
            locked = false;
        }
    }
}