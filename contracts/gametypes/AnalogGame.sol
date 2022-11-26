
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./Game.sol";

abstract contract AnalogGame is Game {
    // Players
    mapping(address => bool) public playerExists; // Has this player address already been added to game?
    mapping(address => uint) public playerValue; // Player address and stake
    
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
}   