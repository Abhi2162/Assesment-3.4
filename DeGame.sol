// SPDX-License-Identifier: MIT
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
