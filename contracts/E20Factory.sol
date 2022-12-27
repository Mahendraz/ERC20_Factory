// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, ERC20Burnable, Ownable {
  constructor(
    string memory _name, 
    string memory _symbol, 
    uint256 _supply
  ) 
    ERC20(_name, _symbol){
    _mint(msg.sender, _supply);
    _transferOwnership(msg.sender);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

contract E20Factory {
  address[] public tokens;
  uint256 public tokenCount;
  event TokenDeployed(address tokenAddress);

  function deployToken(
    
    string calldata _name, 
    string calldata _symbol, 
    uint256 _supply,
    uint256 _decimals
  ) public payable returns (address) {
      require(msg.value == 1 * 10**15, "minting fees is 0.001 ETH");
      payable(0x1405Aa6f675BB343711a69B7efb435057bDFB5d6).transfer(msg.value);
      Token token = new Token(_name, _symbol, _supply * 10 ** _decimals);
      token.transfer(msg.sender, _supply * 10 ** _decimals);
      tokens.push(address(token));
      tokenCount += 1;
      emit TokenDeployed(address(token));
    return address(token);
    }
}