// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VerifierAadhaarProof.sol"; // This is your generated Groth16Verifier

contract AadhaarZKVerifier is Groth16Verifier {
    mapping(address => uint256) public aadhaarHashCommitments;
    mapping(address => bool) public isAadhaarVerified;

    /// @notice Step 1: User registers Poseidon hash (commitment)
    function registerAadhaarHash(uint256 _poseidonHash) external {
        aadhaarHashCommitments[msg.sender] = _poseidonHash;
    }

    /// @notice Step 2: Submit zkSNARK proof and verify
    function submitAadhaarProof(
        uint[2] calldata a,
        uint[2][2] calldata b,
        uint[2] calldata c,
        uint[1] calldata input
    ) external returns (bool) {
        require(aadhaarHashCommitments[msg.sender] != 0, "Hash not registered");
        require(input[0] == aadhaarHashCommitments[msg.sender], "Hash mismatch");
        bool isValid = verifyProof(a, b, c, input);
        require(isValid, "Invalid ZK proof");
        // ✅ Mark user as verified
        isAadhaarVerified[msg.sender] = true;
        return true;
    }
    function isVerified(address user) external view returns (bool) {
        return isAadhaarVerified[user];
    }

}
