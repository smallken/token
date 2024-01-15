pragma solidity ^0.8.23;

contract ERC22 {

    //代币名称
    string private tokenName;
    // 总供给量
    uint256 private  supply;
    // 记录每个账户的代币数
    mapping(address => uint256) private balance;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor (string memory _name, uint256  _totalSupply) {
        tokenName = _name;
        supply = _totalSupply;
    }

    // 返回名称
    //不加memory报这个错： TypeError: Data location must be "memory" or "calldata" for return parameter in function, but none was given.
    function name() external view returns (string memory){
        return tokenName;
    }

    //返回代币总数
    function totalSupply() external view returns (uint256) {
        return supply;
    }

    // 返回每个账户余额
    function balanceOf(address account) external view returns (uint256) {
        return balance[account];
    }

    // 转账,币都存在合约里，只是记录了每个账户的余额
    function transfer(address to, uint256 amount) external returns (bool) {
        balance[to] += amount;
       return  payable(to).send(amount);
    }

    // 转账到其他账户
    function transferFrom(address from, address to, uint256 amount) external returns (bool){
        require(balance[from] >= amount, "Not enough balance!");
        balance[from] -= amount;
        balance[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

}