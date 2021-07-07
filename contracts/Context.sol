pragma solidity ^0.6.12;

// abstract function cannot be deploy as a contract but can be inherited by another smart contract
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }


    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}
