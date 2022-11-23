const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
 
const { abi, evm } = require('../compile');

let raffle;
let accounts;

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();
    raffle = await new web3.eth.Contract(abi)
    .deploy({
      data: evm.bytecode.object
    })
    .send({ from: accounts[0], gas: '2000000' });
})

describe('Raffle Contract', () => {
    it('deploys a contract', () => {
        assert.ok(raffle.options.address);
    })

    it('allows one account to enter', async () => {
        await raffle.methods.enter().send({
            from: accounts[0],
            gas: '2000000',
            value: web3.utils.toWei('0.02', 'ether')
        });

        const players = await raffle.methods.getPlayers().call({
            from: accounts[0]
        });

        assert.equal(accounts[0], players[0]);
        assert.equal(1, players.length);
    });

    it('allows multiple account to enter', async () => {
        await raffle.methods.enter().send({
            from: accounts[0],
            gas: '2000000',
            value: web3.utils.toWei('0.02', 'ether')
        });

        await raffle.methods.enter().send({
            from: accounts[1],
            gas: '2000000',
            value: web3.utils.toWei('0.02', 'ether')
        });

        await raffle.methods.enter().send({
            from: accounts[2],
            gas: '2000000',
            value: web3.utils.toWei('0.02', 'ether')
        });

        const players = await raffle.methods.getPlayers().call({
            from: accounts[0]
        });

        assert.equal(accounts[0], players[0]);
        assert.equal(accounts[1], players[1]);
        assert.equal(accounts[2], players[2]);
        assert.equal(3, players.length);
    });

    it('requires a minimum amount of ether to enter', async () => {
        try {
            await raffle.methods.enter().send({
                from: accounts[0],
                value: 200
            });
            assert(false);
        } catch (err) {
            assert(err);
        }
    });

    it('only manager can call pickWinner', async () => {
        try {
            await raffle.methods.pickWinner().send({
                from: accounts[1]
            });
            assert(false);
        } catch (err) {
            assert(err);
        }
    });

    it('sends money to the winner and resets the player array', async () => {
            await raffle.methods.enter().send({
                from: accounts[0],
                gas: '2000000',
                value: web3.utils.toWei('2', 'ether')
            });
            
            const initialBalance = await web3.eth.getBalance(accounts[0]);

            await raffle.methods.pickWinner().send({ from: accounts[0], gas: '2000000', });

            const finalBalance = await web3.eth.getBalance(accounts[0]);

            const difference = finalBalance - initialBalance;
            assert(difference > web3.utils.toWei('1.8', 'ether'));
    });
});