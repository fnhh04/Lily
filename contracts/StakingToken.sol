pragma solidity ^0.6.12;
//SPDX-License-Identifier: <SPDX-License>
/* This contract creates a staking mechanism for the token. 
To create a token staking mechanism, we need
1. A staking token
2. Data structures to keep track of stakes, stakeholders and rewards/penalties (for withdrawal)
3. Methods to create and remove stakes
4. A rewards system
credit: https://hackernoon.com/implementing-staking-in-solidity-1687302a82cf
*/
import "./IERC20.sol";
import './Ownable.sol';
import './SafeMath.sol';
import './Fnhh.sol';
import './sToken.sol';

abstract contract StakingToken is IERC20, Ownable, sToken {
    using SafeMath for uint256;

	//Fnhh is the original token --> change contract name and file name
	//sToken is the token in return for staking
	Fnhh public fnhh;
	sToken public stoken; 
	address public liquiditypool;

	//array to keep the address of all the stakers --> keep track for transaction 
	address[] public stakers;
	mapping(address => uint) public stakingBalance;
	mapping(address=> bool) public hasStaked;

	// event to broadcast to user
	event Staking(address indexed owner, uint value, bool hasStaked);
	event Unstaking(address indexed owner, uint value, bool hasStaked);

	function staking(uint256 _amount) public {
		fnhh.transferFrom(msg.sender, address(this), _amount);
		// add to the staking balance (sToken)
		stakingBalance[msg.sender] = stakingBalance[msg.sender].add(_amount);

		// mint sToken and send to msg.sender
		_mint(msg.sender, _amount);
		
		//add user to stakers array "only if" they haven't staked already
		if(!hasStaked[msg.sender]) {
			stakers.push(msg.sender);
		}

		//update staking status
		hasStaked[msg.sender] = true;
		
		emit Staking(msg.sender, _amount, hasStaked[msg.sender]);

	}

	//allow withdrawal of tokens
	//deduct 7% 
	function unstaking(uint256 _amount, uint256 withdrawalfee) public {
		//  withdrawal fee
		require(hasStaked[msg.sender]=true, 'no staked amount');
		require(stakingBalance[msg.sender]> 0, "staking balance cannot be 0" );
		// reduce the staking balance (sToken) to lower amount
		stakingBalance[msg.sender]=stakingBalance[msg.sender].sub(_amount);
		
		// transfer fnhh token to the sender
		fnhh.transfer(msg.sender, _amount.sub(_amount*(withdrawalfee).div(100)));

		// transfer fee to liquidity pool
		fnhh.transferFrom( address(this), liquiditypool, _amount*(withdrawalfee).div(100));	
		
		// burn the whole amount of sToken that has been redeemed
		_burn(address(this), _amount);


		//Update staking status
		if(stakingBalance[msg.sender] ==0) {
			hasStaked[msg.sender]=false;
		} else {
			hasStaked[msg.sender]=true;
		}

		emit Unstaking(msg.sender, _amount, hasStaked[msg.sender]);
	}
}
