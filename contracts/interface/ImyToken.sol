pragma solidity ^0.5.0;

interface IMyToken {

    function initialize(
        uint256 initialSupply,
        address[] memory defaultOperators
    ) public

    function addMinter(address[] memory minterAddrs) public

    function delMinter(address[] memory minterAddrs) public

    // Only minters can mint
    function mint(address to, uint256 amount) public; 

    /**
        以下是ERC777的interface
     */
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function granularity() external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function send(address recipient, uint256 amount, bytes calldata data) external;

    function burn(uint256 amount, bytes calldata data) external;

    function isOperatorFor(address operator, address tokenHolder) external view returns (bool);

    function authorizeOperator(address operator) external;

    function revokeOperator(address operator) external;

    function defaultOperators() external view returns (address[] memory);

    function operatorSend(address sender, address recipient, uint256 amount, bytes calldata data, bytes calldata operatorData) external;

    function operatorBurn(address account,uint256 amount,bytes calldata data,bytes calldata operatorData) external;

    event Sent(address indexed operator,address indexed from,address indexed to,uint256 amount,bytes data,bytes operatorData);

    event Minted(address indexed operator, address indexed to, uint256 amount, bytes data, bytes operatorData);

    event Burned(address indexed operator, address indexed from, uint256 amount, bytes data, bytes operatorData);

    event AuthorizedOperator(address indexed operator, address indexed tokenHolder);

    event RevokedOperator(address indexed operator, address indexed tokenHolder);
}