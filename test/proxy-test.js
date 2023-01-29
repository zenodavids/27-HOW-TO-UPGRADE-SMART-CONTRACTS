// Import the expect function from the chai library and the ethers and hardhat modules
const { expect } = require('chai')
const { ethers } = require('hardhat')
const hre = require('hardhat')

// Define a test suite for the ERC721 Upgradeable contract
describe('ERC721 Upgradeable', function () {
  // Define a test case for the deployment of an upgradeable ERC721 Contract
  it('Should deploy an upgradeable ERC721 Contract', async function () {
    // Get the contract factory for the LW3NFT contract
    const LW3NFT = await ethers.getContractFactory('LW3NFT')
    // Get the contract factory for the LW3NFT2 contract
    const LW3NFT2 = await ethers.getContractFactory('LW3NFT2')

    // Deploy LW3NFT as a UUPS (Upgradeable Unstructured Packed Proxy) Contract
    // Note that the initialize function can be named anything else, its just that deployProxy by default calls the function with name initialize for the initializer
    let proxyContract = await hre.upgrades.deployProxy(LW3NFT, {
      kind: 'uups',
    })
    // Get the address of the contract owner
    const [owner] = await ethers.getSigners()
    // Get the owner of token 1
    const ownerOfToken1 = await proxyContract.ownerOf(1)

    // Expect the owner of token 1 to be equal to the contract owner
    expect(ownerOfToken1).to.equal(owner.address)

    // Upgrade the proxy contract to the LW3NFT2 contract
    // we execute the upgradeProxy method again from the @openzeppelin/hardhat-upgrades library which upgrades and replaces LW3NFT with LW3NFT2 without changing the state of the system
    proxyContract = await hre.upgrades.upgradeProxy(proxyContract, LW3NFT2)

    // Expect the test function of the upgraded contract to return "upgraded"
    expect(await proxyContract.test()).to.equal('upgraded')
  })
})
