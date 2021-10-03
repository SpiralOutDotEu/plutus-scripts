source ./functions.sh
getInputTx $4

FROM_ADDR=$SELECTED_WALLET_ADDR
PAYMENT=$1
SCRIPT_ADDRESS=$($CARDANO_CLI address build --payment-script-file ./scripts/${2}.plutus --testnet-magic $TESTNET_MAGIC_NUM)
DATUM_HASH=$($CARDANO_CLI transaction hash-script-data --script-data-value "$3")
TO_ADDR=$SCRIPT_ADDRESS

# ---
SCRIPT_ADDRESS='$CARDANO_CLI address build --payment-script-file ./scripts/AlwaysSucceeds.plutus --testnet-magic $TESTNET_MAGIC_NUM'
# returns test1wpnlxv2xv9a9ucvnvzqakwepzl9ltx7jzgm53av2e9ncv4sysemm8 (base)

$CARDANO_CLI transaction hash-script-data --script-data-value 6666
# returns 9e478573ab81ea7a8e31891ce0648b81229f408d596a3483e6f4f9b92d3cf710

$CARDANO_CLI query utxo --address $(cat ./wallets/$1.addr) --testnet-magic $TESTNET_MAGIC_NUM

CARDANO_CLI=/home/v-dev/WebstormProjects/Crypt/cardano-node-1.30.0/cardano-cli
# --


$CARDANO_CLI transaction build \
--tx-in f6b4cbe0c7c6365ecec28a2ba37ca09c8baecce8baf9fc955df80cc8f210b25a#0 \
--tx-out addr_test1wpnlxv2xv9a9ucvnvzqakwepzl9ltx7jzgm53av2e9ncv4sysemm8+9000000 \
--tx-out-datum-hash 9e478573ab81ea7a8e31891ce0648b81229f408d596a3483e6f4f9b92d3cf710 \
--change-address=addr_test1vzxvyh23348u5a750sncs047etxd4ygn3gd3hq82asazuggp66ey8 \
--testnet-magic $TESTNET_MAGIC_NUM \
--out-file tx.build \
--alonzo-era

$CARDANO_CLI transaction sign \
--tx-body-file tx.build \
--signing-key-file ./wallets/main.skey \
--testnet-magic $TESTNET_MAGIC_NUM \
--out-file tx.signed \

$CARDANO_CLI transaction submit --tx-file tx.signed --testnet-magic $TESTNET_MAGIC_NUM

$CARDANO_CLI query utxo --address addr_test1wpnlxv2xv9a9ucvnvzqakwepzl9ltx7jzgm53av2e9ncv4sysemm8 --testnet-magic $TESTNET_MAGIC_NUM

# $CARDANO_CLI transaction submit --tx-file tx.signed --testnet-magic $TESTNET_MAGIC_NUM

# $CARDANO_CLI transaction build \
#     --tx-in ${SELECTED_UTXO} \
#     --tx-out ${TO_ADDR}+${PAYMENT} \
#     --tx-out-datum-hash ${DATUM_HASH} \
#     --change-address=${FROM_ADDR} \
#     --testnet-magic $TESTNET_MAGIC_NUM \
#     --out-file tx.build \
#     --alonzo-era

# $CARDANO_CLI transaction sign \
#     --tx-body-file tx.build \
#     --signing-key-file ./wallets/${SELECTED_WALLET_NAME}.skey \
#     --testnet-magic $TESTNET_MAGIC_NUM \
#     --out-file tx.signed \


