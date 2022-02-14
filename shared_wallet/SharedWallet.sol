/*Setting up a sharewallet in a smart contract
This sharedwallet could be used in a few use cases.
1. Allowance for your family (Kids, spouses)
2. Management of monthly payments for businesses
3. Budget spending for overseas business trips

Utility of the shared wallet
Balance Management
- Storefunds 
- Checkfunds (done)

User management
- users can withdraw
- Setting user who are allowed to withdraw
- Check userslist

*/

  // Using solidity system to build an owner
    // address owner;

    // constructor() {
    //     owner = msg.sender;
    // }

    // modifier onlyOwner(){
    //     require(msg.sender == owner, "You are not the owner of this contract");
    // }
    
    //using a libary to set an owner

pragma solidity >=0.8.0 < 0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

// contract SharedWallet is Ownable{

//     function isOwner() internal view returns(bool){
//         return owner() == msg.sender;
//     }

//     mapping(address => uint) public allowance;

//     //Owner of contract can add address and the amount the address will get
//     function addAllowance(address _who, uint _amount) public onlyOwner {
//         allowance[who] = _amount;
//     }

//     //Check if you are owner or address that is allowed to withdraw
//     modifier OwnerOrAllowed (uint _amount){
//         require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed");
//     }

//     function reduceAllowance(address _who, uint _amount) internal OwnerOrAllowed(_amount) {
//         allowance[_who] -= _amount;
//     }

//       // Withdraw function
//     function withdrawMoney(address payable _to, uint _amount) public OwnerOrAllowed(_amount){
//         require(_amount <= address(this).balance, "contract doesn't have enough money");
//         if(!isOwner()){
//             reduceAllowance(msg.sender, _amount);
//         }
//         _to.transfer(_amount);
//     }
//     //Check balance getter
//     function checkWalletBalance() public view returns(uint){
//         return address(this).balance;
//     }

//     receive() external payable {

//     }
// }

// improving the contract

contract Allowance is Ownable {
    function isOwner() internal view returns (bool){
        return owner() == msg.sender;
    }

    event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount);
    mapping(address => uint) public allowance;

    function setAllownace(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    modifier ownerOrAllowed(uint _amount){
        require(isOwner() || allowance[msg.sender] >= _amount, "you are not allowed!");
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount){
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[who] -= _amount;
    }
    
}

contract SharedWallet is Allowance {

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "contract doesn't have enough money");
        if(!isOwner()){
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }
    receive() external payable{
        emit MoneyReceived(msg.sender, msg.value);
    }
}