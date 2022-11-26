// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./gametypes/LiquidPoolGame.sol";

contract Raffle is IGame, LiquidPoolGame {
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

    function pickWinner() public restricted restricted{
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

        // Reset LP's for next game
        for (uint i=0; i < liquidityProviders.length; i++) {
            delete lpExists[liquidityProviders[i]];
            delete liquidity[liquidityProviders[i]];
        }

        // Reset Players for next game
        for (uint i=0; i < players.length; i++) {
            delete playerExists[players[i]];
            delete playerValue[players[i]];
        }

        players = new address[](0);
        liquidityProviders = new address[](0);
    }
}