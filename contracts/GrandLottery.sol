// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./gametypes/Lottery.sol";

contract GrandLottery is IGame, Lottery {
    // Initializing the state variable
    uint randNonce = 0;

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