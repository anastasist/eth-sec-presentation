// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Helios.sol";
import "../src/Attacker.sol";

contract AttackerTest is Test {
    Attacker public att;
    Helios public hel;
  
    function setUp() public {
        hel = new Helios();
        vm.deal(address(hel), 10 ether);
        att = new Attacker(IHelios(address(hel)));
        hel.mint(address(this), 3000);
        hel.mint(address(att), 1000);
    }

    function test_attack() public {
        att.showBalances();
        att.attack(1);
        att.showBalances();
    }
}