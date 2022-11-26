// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface IGame {
   function pickWinner() external;
}

abstract contract Game {
    address public manager;

    // Liquidity providers
    mapping(address => bool) public lpExists; // Has this lp address already been added to game?
    mapping(address => uint) public liquidity; // LP address and liquidity loaded
    address[] liquidityProviders;

    // Players
    address[] players;

    constructor() {
        manager = msg.sender;
    }
    
    function addLiquidity() public valueProvided payable {
        if (lpExists[msg.sender] == false)
        {
            lpExists[msg.sender] = true;
            liquidity[msg.sender] = msg.value;
            liquidityProviders.push(msg.sender);
        }
        else
        {
            liquidity[msg.sender] = liquidity[msg.sender] + msg.value;
        }
    }
    
    modifier valueProvided() {
        require(msg.value > .01 ether);
        _;
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    function getLiquidityProviders() public view returns (address[] memory) {
        return liquidityProviders;
    }
}   