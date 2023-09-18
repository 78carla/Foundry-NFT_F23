// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract BasicNftTest is StdCheats, Test {
    BasicNft public basicNft;
    DeployBasicNft public deployer;

    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    // Test the name of the BasicNFT contract
    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();

        keccak256(abi.encodePacked(expectedName)) ==
            keccak256(abi.encodePacked(actualName));
    }

    // Test minting a new NFT and checking if the owner is correct
    function testMintAndHaveTheCorrectBalance() public {
        vm.prank(USER);

        basicNft.mintNFT(PUG);
        assert(basicNft.balanceOf(address(USER)) == 1);
        assert(
            keccak256(abi.encodePacked(basicNft.tokenURI(0))) ==
                keccak256(abi.encodePacked(PUG))
        );
    }
}
