source ./functions.sh

SCRIPT_NAME=AlwaysSucceeds
SCRIPT_FILE=./scripts/${SCRIPT_NAME}.plutus
DATUM_VALUE=6666
walletAddress=wallet1
TO_ADDR=$WALLET_ADDRESS
if [ -z "$3" ]; then REDEEMER_VALUE=42; else REDEEMER_VALUE=$3; fi

DATUM_HASH=$($CARDANO_CLI transaction hash-script-data --script-data-value "6666")
SCRIPT_ADDRESS=$($CARDANO_CLI address build --payment-script-file ./scripts/AlwaysSuccceeds.plutus --testnet-magic $TESTNET_MAGIC_NUM)
echo $SCRIPT_ADDRESS > ./wallets/${SCRIPT_NAME}.addr

section "Select Script UTxO"
getInputTx ${SCRIPT_NAME}
SCRIPT_UTXO=$SELECTED_UTXO
PAYMENT=$SELECTED_UTXO_LOVELACE

section "Select Collateral UTxO"
getInputTx fees
COLLATERAL_TX=$SELECTED_UTXO
SIGNING_WALLET=$SELECTED_WALLET_NAME
FEE_ADDR=$SELECTED_WALLET_ADDR

$CARDANO_CLI query protocol-parameters --testnet-magic $TESTNET_MAGIC_NUM > params.json

removeTxFiles

$CARDANO_CLI transaction build \
--tx-in b44e37acade2760b2aa59f2f28f00515de4c0cac24b3948679314a9f253fb12d \
--tx-in 4fd3e9446ab23484f6be5424c2ac7804ca29a33068f4405510da69c158e40ec9 \
--tx-in-datum-value 6666 \
--tx-in-redeemer-value "${REDEEMER_VALUE}" \
--tx-in-script-file ./scripts/AlwaysSuccceeds.plutus\
--tx-in-collateral=${COLLATERAL_TX} \
--change-address=${FEE_ADDR} \
--tx-out ${TO_ADDR}+${PAYMENT} \
--tx-out-datum-hash ${DATUM_HASH} \
--out-file tx.build \
--testnet-magic $TESTNET_MAGIC_NUM \
--protocol-params-file "params.json" \
--alonzo-era

$CARDANO_CLI transaction sign \
--tx-body-file tx.build \
--signing-key-file ./wallets/${SIGNING_WALLET}.skey \
--testnet-magic $TESTNET_MAGIC_NUM \
--out-file tx.signed \

$CARDANO_CLI transaction submit --tx-file tx.signed --testnet-magic $TESTNET_MAGIC_NUM

# $CARDANO_CLI transaction build \
# --tx-in ${COLLATERAL_TX} \
# --tx-in ${SCRIPT_UTXO} \
# --tx-in-datum-value "${DATUM_VALUE}" \
# --tx-in-redeemer-value "${REDEEMER_VALUE}" \
# --tx-in-script-file $SCRIPT_FILE \
# --tx-in-collateral=${COLLATERAL_TX} \
# --change-address=${FEE_ADDR} \
# --tx-out ${TO_ADDR}+${PAYMENT} \
# --tx-out-datum-hash ${DATUM_HASH} \
# --out-file tx.build \
# --testnet-magic $TESTNET_MAGIC_NUM \
# --protocol-params-file "params.json" \
# --alonzo-era

# $CARDANO_CLI transaction sign \
# --tx-body-file tx.build \
# --signing-key-file ./wallets/${SIGNING_WALLET}.skey \
# --testnet-magic $TESTNET_MAGIC_NUM \
# --out-file tx.signed \

# $CARDANO_CLI transaction submit --tx-file tx.signed --testnet-magic $TESTNET_MAGIC_NUM
