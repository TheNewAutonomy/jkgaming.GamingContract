const path = require('path');
const fs = require('fs');
const solc = require('solc');

const gamePath = path.resolve(__dirname, 'contracts', 'Game.sol');
const gameSource = fs.readFileSync(gamePath, 'utf8');

const rafflePath = path.resolve(__dirname, 'contracts', 'Raffle.sol');
const raffleSource = fs.readFileSync(rafflePath, 'utf8');
 
const input = {
  language: 'Solidity',
  sources: {
    'Game.sol': {
      content: gameSource,
    },
    'Raffle.sol': {
      content: raffleSource,
    },
  },
  settings: {
    outputSelection: {
      '*': {
        '*': ['*'],
      },
    },
  },
};
 
module.exports = JSON.parse(solc.compile(JSON.stringify(input))).contracts[
  'Game.sol', 'Raffle.sol'
].Raffle;