# jkgaming.GamingContract
# <img src="logo.png" alt="JK Gaming" height="128px">

JK Gaming is a DeFi gaming project which pays out high fees to liquidity providers that support games funded through the JK Gaming project.

There is a well understood problem in gaming that players play games with the biggest prizes but large prizes are made possible by having large numbers of players. How do you create a new game that attracts players in sufficient numbers without the liquidity in place from players to begin with?

JK Gaming tackles this problem by inviting liquidity providers to stake liquidity into gaming pools which creates a seed fund for players while creating a high return back to those liquidity providers.

This repository contains the core contract set written in Solidity.


## Contracts

Active development occurs in this repository, which means some contracts in it might not be production-ready. Proceed with caution.

- [`Game.sol`](./conttracts/gametypes): Abstract base class containing common functions to all games.
- [`AnalogGame.sol`](./conttracts/gametypes): Abstract class for games that are non-binary for staking. i.e. Stake 3 ETH for twice the chance to win than staking 1.5 ETH, or any amount of ETH
- [`DigitalGame.sol`](./conttracts/gametypes): Abstract class for games that require entry tickets. i.e. A lottery ticket or sports game betting slip
- [`Raffle.sol`](./conttracts/gametypes): Game similar to a digital game except a very simple buy one ticket for one random entry
- [`ETHStakingGame.sol`](./conttracts): Reference game using the AnalogGame class. Send any amount of ETH to the game to enter. The more ETH sent, the greater your chance of winning
- [`Lottery.sol`](./conttracts): Refrence game using the DigitalGame based on a lottery. Pick n numbers depending on the game configuration and if you match all numbers when they're drawn, you receive the payout.

## Build and Test

Before any tests can be run, the repository needs to be prepared:

```bash
$ npm install # install all dependencies
```

Most tests are standalone and simply require installation of dependencies and compilation.

In order to run all tests (including those with extra dependencies), run:

```bash
$ npm run test
```

## Licensing

Most of the Solidity source code is licensed under the GNU General Public License Version 3 (GPL v3): see [`LICENSE`](./LICENSE).


## What is the JK Gaming project?

JK Gaming is a DeFi gaming project which pays out high fees to liquidity providers that support games funded through the JK Gaming project.

There is a well understood problem in gaming that players play games with the biggest prizes but large prizes are made possible by having large numbers of players. How do you create a new game that attracts players in sufficient numbers without the liquidity in place from players to begin with?

JK Gaming tackles this problem by inviting liquidity providers to stake liquidity into gaming pools which creates a large initial fund. Players can then enter the game knowing that there is a fund available from the very start.

When the game runs, the payout is split between the winning player and the liquidity providers at a ratio set for each game.

At one extreme, the split could see LP's repaid their full investment plus a percentage of gaming fees which means zero risk to LP's. There will always be a remaining balance after repaying LP's which is paid out to the winning player.

Rather than repay LP's first, the game creator can choose any other public approach to working out the split. For example, a 50/50 split on the game pool would ensure that from the very start of the game, a player is guaranteed a knowable high payout which should attract more players to the game. This means some risk to LP's but also a higher return if the high game payout attracts a high player count. You can see a situation where a low risk game creates a large liquidity pool but a small initial payout and so a slower initial uptake of players while a separate higher risk pool attracts a more higher volume of players creating a bigger prize payout and higher return for LP's.

## Contributing to the pool
LP's provide liquidity to game pools before the game runs. LP's do not get entered into the game and so cannot win a prize but they do get a payout that can be calculated as an APR. For example, a raffle pool running over 10 days see's LP's stake $1 million while players stake $2 million. The pools total is $3 million. Depending on the split logic in the pool, the LP could get their full stake back plus a share of $250,000 from the players, or 25% return over a 10 day period. The game logic may have allocate a portion of liquidity to the prize payout from the very start which attracted players to stake $2 million into the game so a small amount of risk resulted in a high return to LPs

Players stake gaming money into the game in the hope of winning the prize. The more they stake, the higher their chances of winning. You can think of this as buying multiple lottery tickets. They do not get any return on their stake but they do get the chance to win the grand prize. For example, in the above scenario witth a $3 million pool, they found that there was a prize fund straight away from LP's which attracted them to play and if successful they would take the $1.75 million prize.

## Game types
The pickWinner function can contain any logic that the game maker chooses. It could choose a winner based on a random number, on an oracle reporting on a sporting event or on anything else. We will start with simple games but will work with game makers on more complicated and fun gaming strategies.

## Gaming experience for LP's
LPs will be provided with a familiar pool staking interface either using the Symmetric project or a new but similar interface. For an LP the experience is familiar to anyone who's added liquidity to pools in projects such as Symemtric, Balancer or Uniswap. Games are presented as pools to which liquidity is staked for the duration of the game. Viewing the game pool details shows details about the game including the rules of the game, payouts logic, time over which the game will run and predicted returns. Unlike pools in Symmetric, only a single token is staked and as such, the pools are not incorporated into the exchange. All liquidity in the pool whether from liquidity providers or players is intended for LPs and players with a small fee going back to the game operators.

## Gaming experience for players
We will provide a simple gaming experience for players but it is hoped that game makers will provide their own individual gaming experiences to their players. Current gaming companies can integrate JK Gaming as a service into their own mobile or web app while new gaming projects can build entirely new gaming experiences for their own market.

## How is the payout divided?
The division of payouts depends on the game and is configured by the game maker. For example, a game may split returns between the player prize and LPs 50/50 or may include more complex logic such as paying LPs first on their investment then the player after along a calculated split.

In every case, 2% is reserved to the JK Gaming founders for continued support and development of the JK project. There is no token associated to the JK project, its only return to the developers and team is from future returns from games.

# Status
This project is work in progress. The game contracts require further work to provide game makers with a selection of games to build on, as well as some core games to be launched to start the gaming market. These contracts are very much work in progress and we are building out the test suite for all contracts.

We will be adding proxy contracts using a factory cloning pattern shortly to allow multiple concurrent games for each game contract to be run.

We also need to publish the UI which may be integrated into the Symmetric pools dashboard or may be a new interface.
