// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./Game.sol";

contract Raffle is Game {
    // Initializing the state variable
    uint randNonce = 0;

    uint[] items;

    constructor(uint range, uint _minWei) Game(_minWei) {
        items = new uint[](++range);
    }

    function enter() public valueProvided payable {
        // TODO: Count how much was paid and enter n number of times
        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp,
            msg.sender,
            players)));
    }

    function pickWinner() public restricted {
        uint index = random() % players.length;
        payable(players[index]).transfer(address(this).balance);
        players = new address[](0);
    }
}