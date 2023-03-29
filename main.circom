include "./node_modules/circomlib/circuits/bitify.circom";

template ReplicateBug() {
    signal input x;
    // This line works:
    // signal y <== x / 30;
    // Replacing it with this means it works for witness+proof generation but causes proof verification failure
    signal y <== x \ 30;
    component asBits = Num2Bits(254);
    asBits.in <== y;
    
}

// template Failure() {

// }

component main { public [x] } = ReplicateBug();