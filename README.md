# onchainJpgs
Onchain image storage for NTFs. 


# files 

onchainJpg.sol - This is the deployed smart contract that stores the files gobally. 
IonchainJpg.sol - This is an interface for using the deployed smart contract for storing and retrieving images. 
exampleNft.sol - An example NFT using the interface to pull the metadata for the image. 


## how is this used on NFTs
OpenSea and other platforms support the data:image/<format>;base64,<encoded_image>

for for example:
A png
```
"image": "data:image/png;base64,<BASE64_ENCODED_PNG_IMAGE>"
```
A jpg
```
"image": "data:image/jpeg;base64,<BASE64_ENCODED_JPEG_IMAGE>"
```