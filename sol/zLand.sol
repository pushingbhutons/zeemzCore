// Mainnet: 0xffcf27ced025f30324be76b54192df40028e1f9c
// Owner: 0x54dd3364BE1816A7717D60ac6EF3a0E1B06Bf167

pragma solidity >=0.5.0 <0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.4.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.4.0/contracts/token/ERC20/ERC20Detailed.sol";

contract zLand is ERC20, ERC20Detailed {
    address public minter;
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor() public ERC20Detailed("Zeemz Bathymetry", "ZMZB", 18) {
        _mint(msg.sender, 10000000 * (10 ** uint256(decimals())));
    }
	
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance.");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
