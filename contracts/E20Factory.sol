// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

contract Token is ERC20, ERC20Burnable, Ownable {
    using SafeMath for uint256;
    constructor(string memory _name, string memory _symbol, uint256 _supply) ERC20(_name, _symbol) {
        _mint(msg.sender, _supply);
        _transferOwnership(msg.sender);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

contract E20Factory {
    address payable[] public tokens;
    event TokenDeployed(address payable tokenAddress);

    function deployToken(string calldata _name, string calldata _symbol, uint256 _supply, uint256 _decimals) public payable returns (address payable) {
        require(msg.value == 1 * 10**15, "minting fees is 0.001 ETH");
        msg.sender.transfer(msg.value);
        Token token = new Token(_name, _symbol, _supply.mul(10**_decimals));
        token.transfer(msg.sender, _supply.mul(10**_decimals));
        tokens.push(address(token));
        emit TokenDeployed(address(token));
        return address(token);
    }
}
