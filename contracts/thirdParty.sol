pragma solidity ^0.5.0;

import "@openzeppelin/upgrades/contracts/Initializable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC777/ERC777.sol";

contract ThirdParty is Initializable {
    address public tokenAddr;

    function initialize(
        address memory _tokenAddr
    )
    public
    initializer
    {
        tokenAddr = _tokenAddr
    }

    function thirdPartySend(address recipient, uint256 amount, bytes calldata data) {
        tokenContractInst = ERC777(tokenAddr);
        tokenContractInst.send(recipient, amount, data);
    }
}