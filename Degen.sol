// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    struct GameItem {
        uint256 id;
        string name;
        uint256 price;
        address owner;
    }

    mapping(uint256 => GameItem) public gameItems;
    uint256 public itemCount;

    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);
    event ItemRedeemed(address indexed player, uint256 itemId);

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        addItem("Health Potion", 100);
        addItem("Magic Scroll", 150);
        addItem("Fire Staff", 200);
    }

    function mintTokens(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
        emit TokensMinted(_to, _amount);
    }

    function addItem(string memory _name, uint256 _price) public onlyOwner {
        ++itemCount;
        gameItems[itemCount] = GameItem(itemCount, _name, _price, address(this));
    }

    function redeemGameItem(uint256 _itemId) external {

        GameItem storage game = gameItems[_itemId];
        require(
            balanceOf(msg.sender) >= game.price,
            "Insufficient DGN balance"
        );

        require(game.owner == address(this), "already owned by another player");

        _transfer(msg.sender, address(this), game.price);

        game.owner = msg.sender;

        emit ItemRedeemed(msg.sender, _itemId);
    }

    function transferDGN(address _to, uint256 _amount) external returns (bool success) {
        require(balanceOf(msg.sender) >= _amount, "Insufficient DGN balance");
        return transfer(_to, _amount);
    }

    function burnTokens(uint256 _amount) external {
        require(balanceOf(msg.sender) >= _amount, "Insufficient DGN balance");
        _burn(msg.sender, _amount);
        emit TokensBurned(msg.sender, _amount);
    }

    function getDGNBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }
}
