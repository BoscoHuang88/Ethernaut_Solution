// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Author: @BoscoHuang

Process:
- Deploy Fallout contract in anvil: 
    1. anvil
    1. forge create src/03_CoinFlip.sol:CoinFlip  --rpc-url http://127.0.0.1:8545 --private-key 0x....
*/


contract CoinFlip {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        consecutiveWins = 0;
    }

    function flip(bool _guess) public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side == _guess) {
            consecutiveWins++;
            return true;
        } else {
            consecutiveWins = 0;
            return false;
        }
    }
}