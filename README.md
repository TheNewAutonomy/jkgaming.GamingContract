# jkgaming.GamingContract
# <img src="logo.png" alt="JK Gaming" height="128px">

JK Gaming is a DeFi gaming project which pays out high fees to liquidity providers that support games funded through the JK Gaming project.

There is a well understood problem in gaming that players play games with the biggest prizes but large prizes are made possible by having large numbers of players. How do you create a new game that attracts players in sufficient numbers without the liquidity in place from players to begin with?

JK Gaming tackles this problem by inviting liquidity providers to stake liquidity into gaming pools which creates a seed fund for players while creating a high return back to those liquidity providers.

This repository contains the core contract set written in Solidity.


## Contracts

Active development occurs in this repository, which means some contracts in it might not be production-ready. Proceed with caution.

- [`Game.sol`](./conttracts): Abstract base class containing common functions to all games.
- [`Raffle.sol`](./contractts): Raffle implementation with random number generator.

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
For LP's we will provide a UI familiar to anyone who invests in DeFi pools such as Symmetric, Balancer or Uniswap. LP's can see a list of running games, the risks for each game, the pool size, the projected returns and other information. Once liquidity is added, it can't be removed until the game runs. At that point, the LP is automatically paid along with the game winners

## Gaming experience for players
We will provide a simple gaming experience for players but it is hoped that game makers will provide their own individual gaming experiences to their players. Current gaming companies can integrate JK Gaming as a service into their own mobile or web app while new gaming projects can build entirely new gaming experiences for their own market.
