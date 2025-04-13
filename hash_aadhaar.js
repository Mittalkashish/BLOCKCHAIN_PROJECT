const circomlibjs = require('circomlibjs');

async function main() {
    const poseidon = await circomlibjs.buildPoseidon();

    const aadhaarStr = "123456789012";
    const aadhaarBigInt = BigInt(aadhaarStr);
    const hash = poseidon([aadhaarBigInt]);

    const hashStr = poseidon.F.toString(hash);
    console.log("expectedHash:", hashStr);
}

main();
