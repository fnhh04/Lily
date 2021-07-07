//SPDX-License-Identifier: <SPDX-License>
pragma solidity ^0.6.12;

import './Context.sol';

// this contract is used to transfer ownership to another address
contract Ownable is Context {
    address private _owner;
    address payable private _charity;
    address private _burnAddress = address(0x0000000000000000000000000000000000000000);
    address private _lockedLiquidity;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }
    
    function lockedLiquidity() public view returns (address) {
        return _lockedLiquidity;
    }
    
    function charity() public view returns (address payable)
    {
        return _charity;
    }
    
    function burn() public view returns (address)
    {
        return _burnAddress;
    }
    
    

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
    
    modifier onlyCharity() {
        require(_charity == _msgSender(), "Caller is not the charity address");
        _;
    }

     /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    
    function setCharityAddress(address payable charityAddress) public virtual onlyOwner
    {
        require(_charity == address(0), "Charity address cannot be changed once set");
        _charity = charityAddress;
    }
    
    function setLockedLiquidityAddress(address liquidityAddress) public virtual onlyOwner
    {
        require(_lockedLiquidity == address(0), "Locked liquidity address cannot be changed once set");
        _lockedLiquidity = liquidityAddress;
    }

}
