pragma circom 2.0.0;
include "../node_modules/circomlib/circuits/poseidon.circom";
include "../node_modules/circomlib/circuits/comparators.circom";

template AadhaarProof() {
    signal input aadhaarNum;       // private input
    signal input expectedHash;     // public input

    signal computedHash;

    // Compute Poseidon hash of Aadhaar number
    component hasher = Poseidon(1);
    hasher.inputs[0] <== aadhaarNum;
    computedHash <== hasher.out;

    // Check Aadhaar >= 100000000000
    component gteMin = GreaterEqThan(64);
    gteMin.in[0] <== aadhaarNum;
    gteMin.in[1] <== 100000000000;

    // Check Aadhaar < 1000000000000
    component ltMax = LessThan(64);
    ltMax.in[0] <== aadhaarNum;
    ltMax.in[1] <== 1000000000000;

    // Enforce that hash must match
    expectedHash === computedHash;

    // Enforce Aadhaar number is in valid range
    signal isValidRange;
    isValidRange <== gteMin.out * ltMax.out;

    isValidRange === 1;
}

component main = AadhaarProof();





dog,cat=weights.predict(test_data)


