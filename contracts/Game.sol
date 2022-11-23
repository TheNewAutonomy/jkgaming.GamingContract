// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

struct PrizeDraw
{
    address playerAddress;
    uint startValue;
    uint endValue;
}

interface IGame {
   function pickWinner() external;
}

abstract contract Game {
    address public manager;

    // Liquidity providers
    mapping(address => bool) public lpExists; // default value for each key is false
    mapping(address => uint) public liquidity; // default value for each key is false
    address[] liquidityProviders;

    // Players
    mapping(address => bool) public playerExists; // default value for each key is false
    mapping(address => uint) public playerValue; // default value for each key is false
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

    function enter() public valueProvided payable {
        if (playerExists[msg.sender] == false)
        {
            playerExists[msg.sender] = true;
            playerValue[msg.sender] = msg.value;
            players.push(msg.sender);
        }
        else
        {
            playerValue[msg.sender] = playerValue[msg.sender] + msg.value;
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