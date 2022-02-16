pragma solidity >= 0.8.0 < 0.9.0;

contract Item {
    uint public priceInWei;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager _parentConract, uint _priceInWei, uint _index){

    }
}

contract ItemManager {

    enum SupplyChainState{Created, Paid, Delivered}

    struct S_Item {
        string _identifier;
        uint _itemPrice;
        ItemManager.SupplyChainState _state;
    }

    mapping(uint => S_Item) public items;
    uint itemIndex;

    function createItem(string memory _identifier, uint _itemPrice) public {
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice = _itemPrice;
        items[itemIndex]._state = SupplyChainState.Created;
        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state));
        itemIndex++;
    }
    
    event SupplyChainStep(uint _itemIndex, uint _step);

    function triggerPayment(uint _itemIndex) public payable {
       require(items[_itemIndex]._itemPrice == msg.value, "Must be fully paid");
       require(items[_itemIndex]._state == SupplyChainState.Created, "Item is further in the chain");
       items[_itemIndex]._state = SupplyChainState.Paid;

       emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state));
    }

    function triggerDelivery(uint _itemIndex) public {
        require(items[_itemIndex]._state == SupplyChainState.Created, "Item is further in the chain");
        items[_itemIndex]._state = SupplyChainState.Delivered;

        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state));
    }
}