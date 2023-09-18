// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    //Non abbiamo bisogno di un HelperConfig perchè il nostro nft è identico in tutte le chain
    function run() external returns (BasicNft) {
        //Faccio deploy
        vm.startBroadcast();
        //Crea istanza di Raffle passando i paramentri del costruttore
        BasicNft oNft = new BasicNft();
        vm.stopBroadcast();

        return (oNft);
    }
}
