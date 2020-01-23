// Mainnet: 0x66617d37793c1a6beda3b433b501e60310f31730
// Owner: 0x54dd3364BE1816A7717D60ac6EF3a0E1B06Bf167

pragma solidity >=0.5.0 <0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.4.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.4.0/contracts/token/ERC20/ERC20Detailed.sol";

contract pbtd is ERC20, ERC20Detailed {
    address public minter;
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor() public ERC20Detailed("Terra Damnata, Book 1 of Pu'Shing Bhu'Tons Series", "PBTD", 18) {
        _mint(msg.sender, 1000 * (10 ** uint256(decimals())));
    }

    // Sends an amount of newly created coins to an address
    // Can only be called by the contract creator
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[receiver] += amount;
    }

    // Sends an amount of existing coins
    // from any caller to an address
    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance.");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
