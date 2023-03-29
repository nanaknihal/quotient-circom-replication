circom --r1cs --sym --wasm main.circom
#phase 1 (don't need to run each time but eh)
# snarkjs powersoftau new bn128 9 pot9_0000.ptau
# snarkjs powersoftau contribute pot9_0000.ptau pot9_0001.ptau --name="First contribution"
# snarkjs powersoftau prepare phase2 pot9_0001.ptau pot9_final.ptau
#phase 2
snarkjs groth16 setup main.r1cs pot9_final.ptau main_0000.zkey
snarkjs zkey contribute main_0000.zkey main_0001.zkey --name="abc"

snarkjs zkey export verificationkey main_0001.zkey verification_key.json

node main_js/generate_witness.js main_js/main.wasm input.json witness.wtns

snarkjs groth16 prove main_0001.zkey witness.wtns proof.json public.json
snarkjs groth16 verify verification_key.json public.json proof.json
