// SPDX-License-Identifier: UNLICENSED
 pragma solidity 0.8.18;
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleTreeWhiteListCounter {
    bytes32 public rootHash;
    uint256 public count;
    
    constructor(bytes32 _rootHash){
        rootHash = _rootHash;
    }

    modifier isWhiteListedAddress(bytes32[] calldata proof){
       require(isValidProof(proof,keccak256(abi.encodePacked(msg.sender))),"Not WhiteListed Address");
        _;
    }

    function isValidProof(bytes32[] calldata proof, bytes32 leaf) private view returns (bool) {
        return MerkleProof.verify(proof, rootHash, leaf);
    }

    function whiteListIncrement(bytes32[] calldata proof)  isWhiteListedAddress(proof) external  {
        count++;
    }
}