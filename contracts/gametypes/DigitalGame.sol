
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./Game.sol";

abstract contract DigitalGame is Game {

    uint[] items;

    constructor(uint range, uint _minWei) Game(_minWei) {
        items = new uint[](++range);
    }

    function enter() public valueProvided payable {
        players.push(msg.sender);
    }
}   