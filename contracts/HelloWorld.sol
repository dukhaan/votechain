// SPDX-License-Identifier: MIT
pragma solidity >=0.4.16 <0.9.0 ;

contract HelloWorld {
    string public yourName;

    constructor() public {
        yourName = "Unknown";
    }

    function setName(string memory name) public {
        yourName = name;
    }

}