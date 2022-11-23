// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

struct PrizeDraw
{
    address playerAddress;
    uint startValue;
    uint endValue;
}

contract Game {
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
    
    // Initializing the state variable
    uint randNonce = 0;

    // Defining a function to generate
    // a random number
    function randMod(uint _modulus) internal returns(uint)
    {
        // increase nonce
        randNonce++;

        return uint(keccak256(abi.encodePacked(block.timestamp,
            msg.sender,
            randNonce))) %
            _modulus;
    }

    function pickWinner() public restricted {
        // Pick winning point
        uint index = randMod(address(this).balance);

        // Set up players for draw
        uint currentPrize = 0;
        for (uint i=0; i < players.length; i++) {
            uint endValue = currentPrize + playerValue[players[i]];

            if (index >= currentPrize && index <= endValue)
            {
                payable(players[i]).transfer(address(this).balance);
                break;
            }

            currentPrize = endValue;
        }

        for (uint i=0; i < liquidityProviders.length; i++) {
            delete lpExists[liquidityProviders[i]];
            delete liquidity[liquidityProviders[i]];
        }

        for (uint i=0; i < players.length; i++) {
            delete playerExists[players[i]];
            delete playerValue[players[i]];
        }

        players = new address[](0);
        liquidityProviders = new address[](0);
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