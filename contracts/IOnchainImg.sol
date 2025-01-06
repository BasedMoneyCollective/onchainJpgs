// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IOnchainImg {
    function addImage(string memory mimeType, string memory base64Data) external returns (uint256);
    function getImage(uint256 imageId) external view returns (string memory mimeType, string memory base64Data);
    function imageCount() external view returns (uint256);
}
