const path = require('path');
const fs = require('fs');
const solc = require('solc');

const gamePath = path.resolve(__dirname, 'contracts/gametypes', 'Game.sol');
const gameSource = fs.readFileSync(gamePath, 'utf8');

const analogGamePath = path.resolve(__dirname, 'contracts/gametypes', 'AnalogGame.sol');
const analogGameSource = fs.readFileSync(analogGamePath, 'utf8');

const ethStakingGamePath = path.resolve(__dirname, 'contracts', 'ETHStakingGame.sol');
const ethStakingGameSource = fs.readFileSync(ethStakingGamePath, 'utf8');
 
const input = {
  language: 'Solidity',
  sources: {
    'gametypes/Game.sol': {
      content: gameSource,
    },
    'gametypes/AnalogGame.sol': {
      content: analogGameSource,
    },
    'ETHStakingGame.sol': {
      content: ethStakingGameSource,
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
  'Game.sol', 'AnalogGame.sol', 'ETHStakingGame.sol'
].ETHStakingGame;