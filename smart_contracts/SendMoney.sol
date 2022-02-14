pragma solidity >=0.7.0 <0.9.0;

contract SendMoney {

    uint public balanceReceived;
    
    function receiveMoney() public payable {
        balanceReceived += msg.value;
    
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawMoney() public {
        address payable to = payable(msg.sender);
        to.transfer(getBalance());
        }

    function withdrawMoneyTo(address payable _to) public {
        _to.transfer(this.getBalance());
    }
}