# DeGame(Decentralized Gaming System)
**DeGame** is a cutting-edge decentralized gaming platform built on the Avalanche blockchain. Central to DeGame is the **Degen** token, an ERC20-compliant digital asset that drives the in-game economy, enabling players to earn, trade, and redeem tokens with ease and efficiency. The DeGame smart contract is developed in Solidity and deployed on the Avalanche blockchain. Utilizing OpenZeppelin’s ERC20 and Ownable standards, the contract ensures security and reliability.

## Description
DeGame is an innovative decentralized gaming platform built on the Avalanche blockchain. The platform is designed to revolutionize the gaming industry by integrating blockchain technology, offering transparency, security, and true ownership of digital assets. At the core of DeGame's economy is the Degen token (DGN), an ERC20-compliant digital currency that facilitates all in-game transactions and interactions.
### Key Features
#### 1. Degen Token Integration
**Token:** Degen

**Symbol:** DGN

**Decimals:** 0

**Role:** The Degen token is the primary medium of exchange within the DeGame ecosystem. Players earn DGN tokens as rewards, use them to purchase in-game items, and redeem them for various benefits. 

#### 2. Item Listing and Redemption
**Item Listing:** Game administrators have the authority to list in-game items by specifying unique IDs, names, and prices in DGN tokens. This feature allows for a diverse marketplace where players can access a variety of digital assets.

**Item Redemption:** Players can redeem listed items using their DGN tokens. This transaction is recorded on the blockchain, ensuring transparency and immutability. The redeemed items are then added to the player's inventory, and the spent tokens are burned, maintaining the overall token supply.

#### 3. Player Ownership and Control
**True Ownership:** Players have full ownership of their Degen tokens and in-game assets. Unlike traditional gaming platforms where in-game items are merely licensed to players, DeGame ensures that all digital assets are owned by the players, giving them the ability to trade or sell these assets outside the game environment.

**Controlled Economy:** The contract owner has the exclusive ability to mint new DGN tokens and list items. This controlled approach prevents inflation and ensures a balanced and fair in-game economy.
## Getting Started
### Executing Program
To execute this program you can go to the Remix IDE which is open IDE for Solidity. For that you can click on this link https://remix.ethereum.org/

Once you successfully reached to the IDE create a new file by clicking on the '+' icon and saving that file with .sol extension (e.g. DeGame.sol). After this copy and paste the code in your file that is given below 

```solidity
pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract DeGame is ERC20, Ownable {
    
    string private constant tokenName = "Degen";
    string private constant Symbol = "DGN";

    struct item{
        uint id;
        string itemName;
        uint price;
    }
    uint itemCount = 0;
    mapping (uint => item) Item;
    mapping (address => item[]) redeemedItem;

    constructor() ERC20(tokenName, Symbol) Ownable(0x6381df244829960b4011c3225A2f96C979D59f30) {}

    function name() public view virtual override  returns (string memory) {
        return tokenName;
    }

    function symbol() public view virtual override returns (string memory) {
        return Symbol;
    }

    function decimals() public view virtual override returns (uint8){
        return 0;
    }

    function balanceOf(address account) public view override returns(uint){
        return super.balanceOf(account);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function createItem (string memory itemName, uint price) public onlyOwner{
        itemCount ++ ;
        Item[itemCount] = item(itemCount, itemName, price);
    }

    function showItems() public view returns (item[] memory) {
        item[] memory items = new item[](itemCount);
        for (uint i = 1; i <= itemCount; i++) {
            items[i - 1] = Item[i];
        }
        return items;
    }

    function claim (uint id) public {
        require(id<=itemCount, "item doesn't exist");
        require(Item[id].price <= balanceOf(msg.sender), "You don't have enough tokens.");
        _transfer(msg.sender, owner(), Item[id].price);
        redeemedItem[msg.sender].push(Item[id]);
    }

    function displayClaimedItem() public view returns(item[] memory){
        return redeemedItem[msg.sender];
    }
}

```

After pasting this code you have to compile the code from the left hand sidebar. click on the 'Solidity Compiler' then click on the 'Compile DeGame.sol' button.

After the successful compilation of the code you have to deploy the program. For that you have again another option on the left sidebar that is 'Deploy & Run Transactions' and then you will see a deploy button; before clicking on it make sure that the file showing there is 'DeGame.sol'. Then you will be able to see the file in the 'Deployed/Unpinned Contracts' click on that now all the public variable and functions are visible to you now execute and fetch the values according to you. And be aware that here you will see the function that you have neither created nor implemented, these extra functions are the functions of the libraries we have inherited (ERC20 and ownable) and it is up to you that you're gonna use them or not.

In this way you can locally deploy the contract but for deploying the contract on avalanche first you must have enough avax tokens in your wallet then you have to connect your wallet with remix IDE. For that you have to again go to the deploy & run transaction bar and then there is an option of *Environment* select **Injected Provider** and after that give permission from your wallet to connect to the IDE and click on deploy. When the deployment is done than copy the contract address, then go to https://testnet.snowtrace.io/ and paste that address in the search bar and press enter. Now everything is done all the connection are made successfully you can make transaction on remix IDE and that are visible on snowtrace. Now you are set run all the function on your own.

## Authors
Abhinesh kumar

## License
This project is licensed under the MIT license.
