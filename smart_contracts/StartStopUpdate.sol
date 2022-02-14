pragma solidity >=0.8.0 < 0.9.0;

contract StartStopUpdate {
    address owner;

    bool public paused;

    constructor() public {
        owner = msg.sender;
    }

    function sendMoney() public payable {

    }
    
    function setPaused(bool _paused) public {
        require(owner == msg.sender, "You are not the owner");
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to) public {
        require(owner == msg.sender, "You are not the owner");
        require(!paused, "contract is paused");
        _to.transfer(address(this).balance);
    }

    function destorySmartContract(address payable _to) public {
        require(owner == msg.sender, "You are not the owner");
        selfdestruct(_to);
    }
}