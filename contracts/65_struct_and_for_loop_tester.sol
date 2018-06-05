pragma solidity ^0.4.18;

// This contract creates a 9x9 map of Tile objects.
// Each tile has an elevation value (as well as an owner and descriptorContract which aren't used here)
// 
// In the constructor, the elevations are set to standard values via for loops.
contract StructAndFor {

    address public creator;
    uint8 public mapSize = 9;
    Tile[9][9] public tiles;
    
    struct Tile {
        address owner;
        address descriptorContract;
        uint8 elevation;
    }
    
    constructor() public {
        creator = msg.sender;
        for(uint8 y = 0; y < mapSize; y++) {
        	for(uint8 x = 0; x < mapSize; x++) {
        		tiles[x][y].elevation = mapSize*y + x; // row 0: 0, 1, 2, 3, 4...   row 1: 9, 10, 11, 12
        	}	
        }	
    }
    
    function getElevation(uint8 x, uint8 y) view returns(uint8) {
    	return tiles[x][y].elevation;
    }
}