// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MintBasicNft is Script {
    string public constant PUG =
        "ipfs://QmdPZrt9xWzBCosg9W8wDa5vwg9NzD544WyNBabVMjuA5J?filename=flower.json";

    // string public constant PUG =
    //     "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contracAddress) public {
        vm.startBroadcast();
        BasicNft(contracAddress).mintNFT(PUG);
        vm.stopBroadcast();
    }
}

//Script per mintare a moddo NFT
contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyMoodDeployed = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        mintNftOnContract(mostRecentlyMoodDeployed);
    }

    function mintNftOnContract(address moodContracAddress) public {
        vm.startBroadcast();
        MoodNft(moodContracAddress).mintNFT();
        vm.stopBroadcast();
    }
}

//Script for flipping the mood
contract FlipMoodNft is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyMoodDeployed = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        flipNftOnContract(mostRecentlyMoodDeployed);
    }

    function flipNftOnContract(address moodContracAddress) public {
        vm.startBroadcast();
        MoodNft(moodContracAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
