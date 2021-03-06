pragma solidity >= 0.8.0 < 0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract Libraries {

    using SafeMath for uint;

    mapping(address => uint) public tokenBalance;

    constructor(){
        tokenBalance[msg.sender] - 1;
    }

    function sendToken(address _to, uint _amount) public returns(bool){
        tokenBalance[msg.sender] = tokenBalance[msg.sender].sub( _amount);
        tokenBalance[_to] = tokenBalance[_to].add(_amount);

        return true;
    }
}