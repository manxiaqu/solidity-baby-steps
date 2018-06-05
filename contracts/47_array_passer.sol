pragma solidity ^0.4.18;

//import "mortal";

contract ArrayPasser {

    address public creator;
    
    /***
     * 1. Declare a 3x3 map of Tiles
     ***/
    uint8 public mapSize = 3;
    Tile[3][3] public tiles;

    struct Tile {
        /***
         * 2. A tile is comprised of the owner, elevation and a pointer to a 
         *      contract that explains what the tile looks like
         ****/
        uint8 elevation;
        //Descriptor descriptor;
    }
    
    /***
     * 3. Upon construction, initialize the internal map elevations.
     *      The Descriptors start uninitialized.
     ***/
    function ArrayPasser(uint8[9] incMap) {
        creator = msg.sender;
        uint8 counter = 0;
        for(uint8 y = 0; y < mapSize; y++) {
           	for(uint8 x = 0; x < mapSize; x++) {
           		tiles[x][y].elevation = incMap[counter];
           		counter = counter + 1;
           	}	
        }	
    }
   
    /***
     * 4. After contract mined, check the map elevations
     ***/
    function getElevations() view returns(uint8[3][3]) {
        uint8[3][3] memory elevations;
        for(uint8 y = 0; y < mapSize; y++) {
        	for(uint8 x = 0; x < mapSize; x++) {
        		elevations[x][y] = tiles[x][y].elevation; 
        	}	
        }	
    	return elevations;
    }
}