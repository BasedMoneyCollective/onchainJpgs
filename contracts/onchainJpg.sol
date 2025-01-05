// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OnchainJpg {
    struct Image {
        string mimeType; // e.g., "image/png" or "image/jpeg"
        string base64Data; // Base64-encoded image data
    }

    mapping(uint256 => Image) private images;
    uint256 public imageCount;

    // Add an image (supports both PNG and JPEG)
    function addImage(string memory mimeType, string memory base64Data) external returns (uint256) {
        require(
            keccak256(abi.encodePacked(mimeType)) == keccak256(abi.encodePacked("image/png")) ||
            keccak256(abi.encodePacked(mimeType)) == keccak256(abi.encodePacked("image/jpeg")),
            "Unsupported image type"
        );
        images[imageCount] = Image(mimeType, base64Data);
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
