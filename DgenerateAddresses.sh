cd wallets
CLI='docker run -it --entrypoint cardano-cli -e NETWORK=testnet -e CARDANO_NODE_SOCKET_PATH=/ipc/node.socket -v cardano-node-ipc:/ipc inputoutput/cardano-node'
$CLI address key-gen --verification-key-file main.vkey --signing-key-file main.skey
$CLI address key-gen --verification-key-file wallet1.vkey --signing-key-file wallet1.skey
$CLI address key-gen --verification-key-file wallet2.vkey --signing-key-file wallet2.skey
$CLI address key-gen --verification-key-file wallet3.vkey --signing-key-file wallet3.skey
$CLI address key-gen --verification-key-file collateral.vkey --signing-key-file collateral.skey
$CLI address key-gen --verification-key-file fees.vkey --signing-key-file fees.skey
$CLI stake-address key-gen --verification-key-file stake1.vkey --signing-key-file stake1.skey
$CLI stake-address key-gen --verification-key-file stake2.vkey --signing-key-file stake2.skey
$CLI stake-address key-gen --verification-key-file stake3.vkey --signing-key-file stake3.skey

$CLI address build --payment-verification-key-file main.vkey --out-file main.addr --testnet-magic $TESTNET_MAGIC_NUM
$CLI address build --payment-verification-key-file wallet1.vkey --stake-verification-key-file stake1.vkey --out-file wallet1.addr --testnet-magic $TESTNET_MAGIC_NUM
$CLI address build --payment-verification-key-file wallet2.vkey --stake-verification-key-file stake2.vkey --out-file wallet2.addr --testnet-magic $TESTNET_MAGIC_NUM
$CLI address build --payment-verification-key-file wallet3.vkey --stake-verification-key-file stake3.vkey --out-file wallet3.addr --testnet-magic $TESTNET_MAGIC_NUM
$CLI address build --payment-verification-key-file collateral.vkey --out-file collateral.addr --testnet-magic $TESTNET_MAGIC_NUM
$CLI address build --payment-verification-key-file fees.vkey --out-file fees.addr --testnet-magic $TESTNET_MAGIC_NUM


