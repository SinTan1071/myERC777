pragma solidity ^0.5.0;

import "@openzeppelin/upgrades/contracts/Initializable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/access/Roles.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC777/ERC777.sol";

contract MyToken is ERC777, Initializable, Ownable {
    using Roles for Roles.Role;

    Roles.Role private _minters;

    modifier onlyMinter() 
    {
        require(_minters.has(_msgSender()), "DOES_NOT_HAVE_MINTER_ROLE");
    }

    function initialize(
        uint256 initialSupply,
        address[] memory defaultOperators
    )
    public
    initializer
    {
        Ownable.initialize(_msgSender());
        ERC777.initialize("MyToken", "MYT", defaultOperators);
        _minters.add(_msgSender());
        // _mint(_msgSender(), _msgSender(), initialSupply, "", "");
    }

    function addMinter(address[] memory minterAddrs) 
    public
    onlyMinter
    {
        for (uint256 i = 0; i < minterAddrs.length; ++i) {
            _minters.add(minterAddrs[i]);
        }
    }

    function delMinter(address[] memory minterAddrs)
    public
    onlyOwner
    {
        for (uint256 i = 0; i < minterAddrs.length; ++i) {
            _minters.remove(minterAddrs[i]);
        }
    }

    // Only minters can mint
    function mint(address to, uint256 amount) 
    public 
    onlyMinter
    {
        _mint(0x0, to, amount, 0x0, 0x0);
    }
}