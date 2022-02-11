pragma solidity >=0.7.0 <0.9.0;

contract WorkingWithVariables {
    uint256 public myUnit;

    function setMyUnit(uint _myUnit) public {
        myUnit = _myUnit;
    }

    bool public myBool;
    function setMyBool(bool _myBool) public {
        myBool =_myBool;
    }

    uint8 public myUnit8;
    function increaseUnit() public {
        myUnit8++;
    }
    function decreaseUnit() public {
        myUnit8--;
    }

    address public myAddress; 
    function setAddress(address _myAddress) public {
        myAddress = _myAddress;
    }
}

    