// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// ===========  need to write the "Proxy Contract" because Openzeppelin deploys and connects a Proxy Contract automatically when we use their library to deploy the Implementation Contract.


// Import the LW3NFT contract
import "./LW3NFT.sol";

// Define a new contract called LW3NFT2 that inherits from the LW3NFT contract
contract LW3NFT2 is LW3NFT {
// Define a new function called test that is public and pure (view) and returns a string
function test() public pure returns (string memory) {
// Return the string "upgraded"
return "upgraded";
}
}