pragma solidity ^0.8.23;

import "homework1-14/ERC22.sol";

contract tokenBank {
    // 存储每个账户对应的钱包数量
    mapping(address => uint) balanceOf;
    ERC22 private token;
    address owner;

    event Deposite(address indexed from, uint256 amount);

    constructor (address _tokenAddress) {
        token = ERC22(_tokenAddress);
        owner = msg.sender;
    }
    // 将token存入tokenBank
    function save(uint256 amount) external   {
        require(token.transferFrom(msg.sender, address(this), amount));
        emit Deposite(msg.sender, amount);
    }

    // 管理员提取所有token
    function withdrawAllToken() payable public {
        require(msg.sender == owner, "No access!");
        uint256 balance = token.balanceOf(address(this));
        // require(token.Transfer(msg.sender, address(this), balance));
        require(token.transferFrom(msg.sender, address(this), balance));
        emit Deposite(msg.sender, balance);
    }


}