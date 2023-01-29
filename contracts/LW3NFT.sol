// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


// =========== IMPLEMENTATION CONTRACT =================

// ====== It imports ERC721Upgradeable and OwnableUpgradeable because the original ERC721 and Ownable contracts have a constructor which cant be used with proxy contracts.===== //
// imports the ERC721Upgradeable contract from the OpenZeppelin library
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
// imports the OwnableUpgradeable contract from the OpenZeppelin library
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
// imports the Initializable contract from the OpenZeppelin library
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
// imports the UUPSUpgradeable contract from the OpenZeppelin library
// provides us with the upgradeTo(address) to be put on the Implementation Contract in case of a UUPS proxy pattern.
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

// Contract is using Initializable contract
contract LW3NFT is Initializable,
// Contract is using ERC721Upgradeable contract
ERC721Upgradeable,
// Contract is using UUPSUpgradeable contract
UUPSUpgradeable,
// Contract is using OwnableUpgradeable contract
OwnableUpgradeable
{
// Initializes the contract
function initialize() public initializer {
// Initializes the ERC721 contract and sets the name and symbol
__ERC721_init("LW3NFT", "LW3NFT");
// Initializes the Ownable contract
__Ownable_init();
// Mints a token and assigns it to the msg.sender
_mint(msg.sender, 1);
}

// Function to authorize the upgrade of the implementation
// to be implemented by the developer when they import the UUPSUpgradeable Contract from Openzeppelin.
// gives us the ability to add authorization on who can actually upgrade the given contract, it can be changed according to requirements but in our case we just added an onlyOwner modifier.
function _authorizeUpgrade(address newImplementation)
    // function is internal
    internal
    // can be overridden
    override
    // can only be called by the owner
    onlyOwner
{}
}