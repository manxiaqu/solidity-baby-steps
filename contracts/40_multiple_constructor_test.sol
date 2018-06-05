// Just testing to see if you can have multiple constructors. Nope!

contract MultipleConstructorTest {

    address public creator;
    bool public first = false;
    bool public second = false;

    constructor() public {
        creator = msg.sender; 								
        first = true;
    }
	
	function getFirst() view returns (bool) {
		return first;
	}
	
	function getSecond() view returns (bool) {
		return second;
	}
}
