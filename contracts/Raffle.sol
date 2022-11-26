// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./gametypes/DigitalGame.sol";

contract Raffle is DigitalGame {
    // Initializing the state variable
    uint randNonce = 0;

    constructor(uint range, uint _minWei) DigitalGame(range, _minWei) {}

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