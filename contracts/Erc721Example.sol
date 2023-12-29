// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Erc721Example is ERC721, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;
    mapping(uint256 => PlayerIdentity) public playerIdentities;

    struct PlayerIdentity {
        string name;
        string avatar;
        uint256 ranking;
    }

    constructor(
        address initialOwner
    ) ERC721("PlayerIdentityNFT", "PID") Ownable(initialOwner) {}

    function mint(
        address player,
        string memory name,
        string memory avatar,
        uint256 ranking
    ) public onlyOwner {
        uint256 tokenId = _nextTokenId++;

        _mint(player, tokenId);

        playerIdentities[tokenId] = PlayerIdentity({
            name: name,
            avatar: avatar,
            ranking: ranking
        });
    }

    function getName(uint256 tokenId) public view returns (string memory) {
        return playerIdentities[tokenId].name;
    }

    function getAvatar(uint256 tokenId) public view returns (string memory) {
        return playerIdentities[tokenId].avatar;
    }

    function getRanking(uint256 tokenId) public view returns (uint256) {
        return playerIdentities[tokenId].ranking;
    }

    function setRanking(uint256 tokenId, uint256 newRanking) public{
        require(ownerOf(tokenId) == msg.sender, "You don't own this NFT");
        playerIdentities[tokenId].ranking = newRanking;
    }   

    /**
     * Overrides the transfer function to prevent NTTs from being transferred.
     */
    /**function safeTransferFrom(address from, address to, uint256 tokenId) public override {
        revert("NTTs cannot be transferred");
    }

        //address from, address to, uint256 tokenId
    function transferFrom(address from, address to, uint256 tokenId) public override {
        revert("NTTs cannot be transferred");
    }**/

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}
