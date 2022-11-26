// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "./gametypes/DigitalGame.sol";

contract Lottery is DigitalGame {
    // Initializing the state variable
    uint randNonce = 0;

    constructor(uint _noOfNumbersToDraw, string[] memory _options, uint _minWei) DigitalGame(_noOfNumbersToDraw, _options, _minWei) {}
}