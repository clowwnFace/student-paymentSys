// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract AccountPaymentSys {
    address public owner;

    struct Account {
        uint256 id;
        uint256 bal;
        bool exist;
    }

    mapping(address => Account) private accounts;

    modifier onlyOwner() {
        require(owner == msg.sender, "only the owner can make changes");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addAccount(
        address _accountAddress,
        uint _accountId
    ) public onlyOwner {
        Account storage account = accounts[_accountAddress];
        account.id = _accountId;
        account.bal = 0;
        account.exist = true;
    }

    function depositFunds(
        address _accountAddress,
        uint _amount
    ) public onlyOwner returns (uint) {
        Account storage account = accounts[_accountAddress];
        require(account.exist == true, "account does not exist");
        return account.bal += _amount;
    }

    function deductFunds(
        address _accountAddress,
        uint _amount
    ) public onlyOwner returns (uint) {
        Account storage account = accounts[_accountAddress];
        require(
            account.exist && account.bal >= 0,
            "ACC does not exist or funds low"
        );
        return account.bal -= _amount;
    }

    function getBalance(address _accountAddress) public view returns (uint) {
        // Account storage account = accounts[_accountAddress];
        if (!accounts[_accountAddress].exist) {
            return 0;
        } else return accounts[_accountAddress].bal;
    }
}
