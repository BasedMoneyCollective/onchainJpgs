# onchainJpgs
Onchain image storage for NFTs.

## Deployment Addresses
- **Ethereum (Eth):**  
- **Sepolia testnet eth:** 0x6b62E7127B50D28D7A3Ee9867d6E76393bDd614c
- **Base:**  
- **Polygon (Matic):**

---

## Files

- **`OnchainImg.sol`**  
  This is the deployed smart contract that stores the images globally.

- **`IOnchainImg.sol`**  
  This is an interface for interacting with the deployed smart contract to store and retrieve images.

- **`exampleNft.sol`**  
  An example NFT contract that uses the interface to pull the metadata for the image.

---

## How Is This Used on NFTs?

OpenSea and other platforms support the following format for embedding images directly within metadata:

### Example of Embedded Image Metadata
#### PNG Example
```
"image": "data:image/png;base64,<BASE64_ENCODED_PNG_IMAGE>"
```
#### JPG Example
```
"image": "data:image/jpeg;base64,<BASE64_ENCODED_JPEG_IMAGE>"
```

Here is an example deployed nft with an onchain image as viewed on opensea [https://testnets.opensea.io/collection/onchain-image-nft-2](https://testnets.opensea.io/collection/onchain-image-nft-2)

