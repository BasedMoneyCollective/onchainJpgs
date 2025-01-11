// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./IOnchainImg.sol";

contract NFTWithOnchainImg is ERC721Enumerable, Ownable {
    IOnchainImg public onchainImg;


    // Mapping of token IDs to image IDs
    mapping(uint256 => uint256) public tokenImageIds;

    // Struct to store additional metadata or properties
    struct TokenDetails {
        uint256 imageId;
    }

    mapping(uint256 => TokenDetails) public tokenDetails;

    // Constructor to initialize the NFT contract and the onchain image storage contract
    constructor(address onchainImgAddress) ERC721("Onchain Image NFT", "OINFT") {
        require(onchainImgAddress != address(0), "Invalid OnchainImg address");
        onchainImg = IOnchainImg(onchainImgAddress);
    }

    // Mint a new NFT and associate it with an image ID from OnchainImg
    function mintNFT(address to, uint256 imageId) external onlyOwner {
        require(to != address(0), "Invalid recipient address");

        // Ensure the image exists by calling the `getImage` function
        (string memory mimeType, ) = onchainImg.getImage(imageId);
        require(bytes(mimeType).length > 0, "Invalid image");

        uint256 tokenId = totalSupply(); // Token ID is based on the total supply
        tokenImageIds[tokenId] = imageId;

        // Save additional details
        tokenDetails[tokenId] = TokenDetails(imageId);

        _safeMint(to, tokenId);
    }

    // Generate metadata for the token, including the on-chain image
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "Token does not exist");

        uint256 imageId = tokenImageIds[tokenId];
        (string memory mimeType, string memory base64Data) = onchainImg.getImage(imageId);

         string memory metadata = string(
            bytes(
                abi.encodePacked(
                    '{',
                    '"name": "Onchain Image NFT #', Strings.toString(tokenId), '",',
                    '"description": "An NFT with an on-chain image stored in the OnchainImg contract.",',
                    '"image": "data:', mimeType, ';base64,', base64Data, '",',
                    '"type": "',mimeType ,'"',
                    '}'
                )
            )
        );

        // return string(abi.encodePacked("data:application/json;base64,", json));
        return metadata;
    }


    
}
