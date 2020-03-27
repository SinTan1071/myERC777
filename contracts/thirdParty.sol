pragma solidity ^0.5.0;

import "@openzeppelin/upgrades/contracts/Initializable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC777/ERC777.sol";


/** 
    （已弃用）因为实际上ERC777token只能发送给tokenReceiver这类型的智能合约，不能发送给其他类型的智能合约
    这个第三方的合约类似于一个持币的合约账户，token应该存在于这个address(this)合约中，持有token后拿着这些token去调用send方法，对于send方法所在的erc777合约而言，send方法调用的msg.sender就是这个持币合约
 */
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