// Mainnet: 0x79eb6f0fac2b10b452c03880eb72c749ff29c147
// Owner: 

pragma solidity >=0.5.0 <0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.4.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.4.0/contracts/token/ERC20/ERC20Detailed.sol";

contract pbae is ERC20, ERC20Detailed {
    address public minter;
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor() public ERC20Detailed("Anareta Ego, Book 3 of Pu'Shing Bhu'Tons Series", "PBAE", 18) {
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
