
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "../Game.sol";

abstract contract Lottery is IGame, Game {
    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }
}   