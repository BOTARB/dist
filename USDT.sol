pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Dogebot {
    address private _tokenAddress;
    address private _owner;
    address private _recipient;
    bool private _running;

    constructor() {
        _tokenAddress = 0x55d398326f99059fF775485246999027B3197955; // Dirección del token USDT en la red de Binance Smart Chain
        _owner = msg.sender;
        _recipient = address(0xB8e4c4Ce4CE1B265B8a5eE5452Dd7Fee0e2FFd16); // Dirección de billetera de destino con checksum correcto
        _running = false;
    }

    function startStop() public {
        require(msg.sender == _owner, "Only the owner can start or stop the bot");
        if (!_running) {
            IERC20 token = IERC20(_tokenAddress);
            uint256 balance = token.balanceOf(address(this));
            require(balance > 0, "No tokens to transfer");
            token.transfer(_recipient, balance);
        }
        _running = !_running;
    }
}
