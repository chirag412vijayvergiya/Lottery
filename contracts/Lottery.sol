pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, now, players));
    }
    
    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }
    
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
}   


// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

// contract Lottery {
//     address public manager;
//     address payable[] public players;

//     // Constructor to set the manager
//     constructor() payable {
//         manager = msg.sender;
//     }

//     // Enter the lottery by sending ether
//     // In Solidity 0.5.x and above, any address that will receive Ether must be marked as payable.

//     function enter() public payable {
//         require(msg.value > 0.01 ether, "Minimum amount to enter is 0.01 ether");
//         players.push(payable(msg.sender));
//     }

//     // Private function to generate a random number
//     function random() private view returns (uint) {
//         return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players)));
//     }

//     // Function to pick a winner and transfer the contract balance
//     function pickWinner() public restricted {
//         require(players.length > 0, "No players in the lottery");
//         // require(msg.sender == manager); // use modifiers instead of this because of removing of duplication

//         uint index = random() % players.length;
//         address payable winner = players[index];
        
//         // Transfer the contract's balance to the winner
//         winner.transfer(address(this).balance);
        
//         // Reset the players array for the next round
//         players = new address payable[](0) ; // Resetting to an empty array
//     }

//     modifier restricted(){
//         require(msg.sender == manager);
//         _;
//     }

//     function getPlayers() public view returns (address payable[] memory){
//         return players;
//     }
// }
