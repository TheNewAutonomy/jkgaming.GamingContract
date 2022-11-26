
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./Game.sol";

struct Ticket {

    address ticketAddress;

    string[] choices;
}

abstract contract DigitalGame is Game {

    Ticket[] tickets;

    string[] options;

    uint noOfNumbersToDraw;

    constructor(uint _noOfNumbersToDraw, string[] memory _options, uint _minWei) Game(_minWei) {
        noOfNumbersToDraw = _noOfNumbersToDraw;
        options = _options;
    }

    function enter(string[] memory _choices) public valueProvided payable {
        Ticket memory newTicket = Ticket(msg.sender, _choices);
        tickets.push(newTicket);
        players.push(msg.sender);
    }

    // Default implementation of the pickWinner function, based on a typical lottery game.
    // For actual lottery games, use an oracle to get a truly random selection.
    function pickWinner() public restricted {

        // Pick winning value randomly
        string[] memory availableOptions = options;
        string[] memory selectedptions;

        for (uint i = 0; i < noOfNumbersToDraw; i++)
        {
            uint randomValue = uint(keccak256(abi.encodePacked(block.timestamp,
                block.difficulty,
                availableOptions.length)));

                uint index = randomValue * options.length;
                string memory optionSelected = options[index];
                delete availableOptions[index];
                selectedptions[i] = optionSelected;
        }

        //Find the winners with those matches
        // TODO: Loop through players and their numbers, checking against selectedOptions.
        //       If they match, add to winners list then loop through and pay out.
        // payable(players[index]).transfer(address(this).balance);
        players = new address[](0);
    }
}   