// SPDX-License-Identifier: MIT
/*
  OnChainImages v1
  -----------------
  Onchain image storage for NFTs. Multichain support and batteries included. 
  Get started and visit the github for source and NFT example. 
  Github:    https://github.com/BasedMoneyCollective/onchainJpgs

  Brought to you by:
  Based Money Collective
  basedmoneycollective.com

  Built for Monerochan 
  Website:   https://monerochan.biz
  Telegram:  https://t.me/monerochanToken
  Twitter:   https://x.com/MonerochanToken



*/
pragma solidity ^0.8.0;

contract OnchainImg {
    struct Image {
        string mimeType; // e.g., "image/png" or "image/jpeg"
        string base64Data; // Base64-encoded image data
    }

    // The event for new images being added. 
    event NewImageAdded(uint256 indexed imageId, string mimeType);

    mapping(uint256 => Image) private images;
    uint256 public imageCount;

    //the mappings for supported mime types. More gas efficient this way. 
    mapping(bytes32 => bool) private supportedMimeTypes;

     constructor() {
        initializeSupportedMimeTypes();
    }
    
    // will only run in the construction. Precomputes it for cheaper gas later. 
    function initializeSupportedMimeTypes() internal {
        supportedMimeTypes[keccak256(abi.encodePacked("image/png"))] = true;
        supportedMimeTypes[keccak256(abi.encodePacked("image/jpeg"))] = true;
        supportedMimeTypes[keccak256(abi.encodePacked("image/jpg"))] = true;
        supportedMimeTypes[keccak256(abi.encodePacked("image/gif"))] = true;
        supportedMimeTypes[keccak256(abi.encodePacked("image/svg+xml"))] = true;
        supportedMimeTypes[keccak256(abi.encodePacked("image/webp"))] = true;
        supportedMimeTypes[keccak256(abi.encodePacked("image/tiff"))] = true;
        supportedMimeTypes[keccak256(abi.encodePacked("image/heif"))] = true;
        supportedMimeTypes[keccak256(abi.encodePacked("image/heic"))] = true;
        supportedMimeTypes[keccak256(abi.encodePacked("image/avif"))] = true;
        supportedMimeTypes[keccak256(abi.encodePacked("image/bmp"))] = true;
    }
    
    // the mime type lookup. table lookup vs on the fly computation is cheaper 
     function isSupportedMimeType(string memory mimeType) public view returns (bool) {
        return supportedMimeTypes[keccak256(abi.encodePacked(mimeType))];
    }


    // Add an image (supports both PNG and JPEG)
    function addImage(string memory mimeType, string memory base64Data) external returns (uint256) {
        // require(
        //     keccak256(abi.encodePacked(mimeType)) == keccak256(abi.encodePacked("image/png")) ||
        //     keccak256(abi.encodePacked(mimeType)) == keccak256(abi.encodePacked("image/jpeg")),
        //     "Unsupported image type"
        // );
        // gas savings this way 
        require(isSupportedMimeType(mimeType), "Unsupported image type");
        images[imageCount] = Image(mimeType, base64Data);
        // Emit the event
        emit NewImageAdded(imageCount, mimeType);
        imageCount++;
        return imageCount - 1; // Return the ID of the stored image
    }

    // Retrieve an image by its ID
    function getImage(uint256 imageId) external view returns (string memory mimeType, string memory base64Data) {
        require(imageId < imageCount, "Image does not exist");
        Image storage img = images[imageId];
        return (img.mimeType, img.base64Data);
    }
}
