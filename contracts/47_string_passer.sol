pragma solidity ^0.4.18;

/***
 *     _    _  ___  ______ _   _ _____ _   _ _____ 
 *    | |  | |/ _ \ | ___ \ \ | |_   _| \ | |  __ \
 *    | |  | / /_\ \| |_/ /  \| | | | |  \| | |  \/
 *    | |/\| |  _  ||    /| . ` | | | | . ` | | __ 
 *    \  /\  / | | || |\ \| |\  |_| |_| |\  | |_\ \
 *     \/  \/\_| |_/\_| \_\_| \_/\___/\_| \_/\____/
 *                                                 
 *   This contract DOES NOT WORK. Dynamically sized types cannot be returned (incl. "string" and "bytes").                                      
 */
contract Descriptor {

    // "pure" promise not to read or modify state
    // pure关键字代表承诺该函数不会读取或修改state
	function getDescription() pure returns (string){
		return "tencharsme";
	}
}

contract StringPasser {

    address public creator;
    
    /***
     * 1. Declare a 9x9 map of Tiles
     ***/
    uint8 public mapSize = 9;
    Tile[9][9] public tiles;

    struct Tile {
        /***
         * 2. A tile is comprised of the owner, elevation and a pointer to a 
         *      contract that explains what the tile looks like
         ****/
        address owner;
        uint8 elevation;
        Descriptor descriptor;
    }
    
    /***
     * 3. Upon construction, initialize the internal map elevations.
     *      The Descriptors start uninitialized.
     ***/
    function StringPasser(uint8[] incMap) {
        creator = msg.sender;
        uint counter = 0;
        Descriptor nothing;
        for(uint8 y = 0; y < mapSize; y++) {
           	for(uint8 x = 0; x < mapSize; x++)
           	{
           	    tiles[x][y].descriptor = nothing;
           		tiles[x][y].elevation = incMap[counter];
           	}	
        }	
    }
    
   /*** 
    * 4. get Description of a tile at x,y
    ***/ 
    function getTileDescription(uint8 x, uint8 y)
    {
    	Descriptor desc = tiles[x][y].descriptor;       // get the descriptor for this tile
    	string memory anotherVar = desc.getDescription();  // get the description from the descriptor
    	
    	// TODO validate the description
    	// TODO convert it to JSON
    	// save it to a variable for constant retrieval elsewhere
    	
    	return; 
    }
}