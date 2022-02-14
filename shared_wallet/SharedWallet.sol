pragma solidity >=0.8.0 < 0.9.0;

contract SharedWallet {

    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "You are not the owner of this contract");
    }

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner{
        _to.transfer(_amount);
    }

    receive() external payable
}