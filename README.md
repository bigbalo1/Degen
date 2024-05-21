# DegenToken

DegenToken is an ERC20 token deployed on the Avalanche network designed for Degen Gaming. This smart contract enables minting new tokens, transferring tokens between players, redeeming tokens for in-game items, checking token balances, and burning tokens.

## Features

1. *Minting New Tokens*: The platform owner can create and distribute new tokens to players as rewards.
2. *Transferring Tokens*: Players can transfer their tokens to other players.
3. *Redeeming Tokens*: Players can redeem their tokens for items available in the in-game store.
4. *Checking Token Balance*: Players can check their token balance at any time.
5. *Burning Tokens*: Players can burn their tokens to reduce the total supply.

## Smart Contract

### Contract Address
0x213b84ca078083E07409cB3728873D4eDBAA46f5

The smart contract was deployed on the Avalanche Fuji Testnet. 


#### Minting Tokens

Only the owner can mint new tokens.

mintTokens(address _to, uint256 _amount) external onlyOwner;

#### Transferring Tokens

Players can transfer their tokens to others.

 transferDGN(address _to, uint256 _amount) external returns (bool);

``
#### Redeeming Game Items

Players can redeem tokens for in-game items.
 redeemGameItem(uint256 _itemId) external;


#### Checking Token Balance

Players can check their token balance.

`getDGNBalance() public view returns (uint256);


#### Burning Tokens

Players can burn their tokens to reduce the total supply.

solidity
function burnTokens(uint256 _amount) external;



### In-Game Store

The contract includes an in-game store where players can redeem their tokens for items. The store is initialized with default items upon contract deployment.

#### Adding New Items

Only the owner can add new items to the in-game store.

solidity
function addItem(string memory _name, uint256 _price) public onlyOwner;

## License

This project is licensed under the MIT License. See the LICENSE file for details.
