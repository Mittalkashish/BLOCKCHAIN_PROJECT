import { buildPoseidon } from "https://cdn.jsdelivr.net/npm/circomlibjs@0.0.8/+esm";

export async function generateAndSubmitAadhaarZKP(contract, userAddress, aadhaarNum) {
    try {
        // 2. Hash Aadhaar number with Poseidon
        aadhaarNum = aadhaarNum ? BigInt(aadhaarNum) : BigInt(0);
        const poseidon = await buildPoseidon();
        const hash = poseidon([aadhaarNum]);
        const expectedHash = poseidon.F.toString(hash);

        console.log("Poseidon hash (on-chain commitment):", expectedHash);

        // 3. Register the hash on-chain
        await contract.methods.registerAadhaarHash(expectedHash).send({ from: userAddress });
        console.log("✅ Aadhaar hash registered on-chain");

        // 4. Generate ZK proof using snarkjs (in browser)
        const { proof, publicSignals } = await window.snarkjs.groth16.fullProve(
            {
                aadhaarNum: aadhaarNum.toString(),
                expectedHash: expectedHash.toString()
            },
            "zkp/aadhaar_proof_js/aadhaar_proof.wasm",
            "zkp/aadhaar_final.zkey"
        );
        console.log('aadhar number:' + aadhaarNum.toString());
        console.log("✅ ZK Proof Generated");

        // 5. Format the calldata for Solidity
        const calldata = await window.snarkjs.groth16.exportSolidityCallData(proof, publicSignals);
        const argv = calldata.replace(/["[\]\s]/g, "").split(",").map(x => BigInt(x).toString());

        const a = [argv[0], argv[1]];
        const b = [
            [argv[2], argv[3]],
            [argv[4], argv[5]]
        ];
        const c = [argv[6], argv[7]];
        const input = [argv[8]];

        // 6. Call submitAadhaarProof on-chain
        await contract.methods.submitAadhaarProof(a, b, c, input).send({ from: userAddress });
        console.log("✅ Aadhaar ZK Proof submitted and verified");

        alert("✅ Aadhaar Proof Verified & Access Granted!");

    } catch (err) {
        console.error("❌ Error in Aadhaar ZK Pipeline:", err);
        alert("❌ Proof generation or submission failed. Check console.");
    }
}
