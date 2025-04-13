pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/comparators.circom";

template AgeProof() {
    signal input birthYear;     // private
    signal input currentYear;   // public
    signal output valid;        // 1 if over 18

    signal targetYear;
    targetYear <== currentYear - 18;

    component lt = LessThan(32); // 32-bit comparison

    lt.in[0] <== birthYear;
    lt.in[1] <== targetYear;

    valid <== lt.out; // 1 if birthYear < targetYear => age > 18
}

component main = AgeProof();
