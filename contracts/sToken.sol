pragma solidity ^0.6.12;

import './IERC20.sol';
import './Ownable.sol';
import './SafeMath.sol';

abstract contract sToken is IERC20 {
    using SafeMath for uint;
    // name, symbol, decimals
    string internal constant _name = 'Staked Token';
    string internal constant _symbol = 'STK';
    uint8 internal constant _decimals = 9;

    // balance of original token
    mapping(address => uint) private balanceOf;
    mapping(address => mapping(address => uint)) private allowance;

    //broadcast transaction
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function transfer(address to, uint value) external override returns (bool) {
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(value);
        balanceOf[to] = balanceOf[to].add(value);
        emit Transfer(msg.sender, to, value);
    }

    function approve(address spender, uint value) external override returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
    }


    function transferFrom(address from, address to, uint value) external override returns (bool) {
        if (allowance[from][msg.sender] != uint(-1)) {
            allowance[from][msg.sender] = allowance[from][msg.sender].sub(value);
        }
        balanceOf[from] = balanceOf[from].sub(value);
        balanceOf[to] = balanceOf[to].add(value);
        emit Transfer(from, to, value);
        return true;
    }

    function _mint(address to, uint256 amount) internal {
        require(amount >0, 'invalid amount');
        balanceOf[to]=balanceOf[to].add(amount);
        emit Transfer(address(0), to, amount);
    } 

    function _burn(address from, uint amount) internal {
        balanceOf[from] = balanceOf[from].sub(amount);
        emit Transfer(from, address(0), amount);
    }

}