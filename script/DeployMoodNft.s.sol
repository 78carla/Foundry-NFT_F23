// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        //Leggo il file svg
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    //Invece di hardcode la stringa della svg le passo come paramentro.
    //Questa funzione esegue il comando che usavo da console base64 -i nomeFile
    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        //example
        //passo: <svg viewBox="0 0 200 200" width="400"  height="400" xmlns="http://www.w3.org/2000/svg">.....
        //restituisce data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAw.....
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        //ora le concateno
        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}
