pragma solidity ^0.5.0;

import "@openzeppelin/upgrades/contracts/Initializable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/ownership/Ownable.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC777/IERC777.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC777/IERC777Recipient.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/introspection/IERC1820Registry.sol";

import "./interface/ImyToken.sol";

contract TokenReceiver is IERC777Recipient, Initializable, Ownable {
    IERC1820Registry private _erc1820 = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);
    bytes32 constant private TOKENS_RECIPIENT_INTERFACE_HASH = keccak256("ERC777TokensRecipient");

    // IERC777 private _token;
    ImyToken private _token;

    event DoneStuff(address operator, address from, address to, uint256 amount, bytes userData, bytes operatorData);

    function initialize(
        address token
    )
    public
    initializer
    {
        Ownable.initialize(_msgSender());
        // _token = IERC777(token);
        _token = ImyToken(token);
        _erc1820.setInterfaceImplementer(address(this), TOKENS_RECIPIENT_INTERFACE_HASH, address(this));
    }

    function tokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) 
    external 
    {
        require(_msgSender() == address(_token), "Simple777Recipient: Invalid token");
        // do stuff
        emit DoneStuff(operator, from, to, amount, userData, operatorData);
    }

    function receiverMintAndSend(address recipient, uint256 amount, bytes calldata data) 
    public
    onlyOwner
    {
        _token.mint(address(this), amount);
        _token.send(recipient, amount, data);
    }

}