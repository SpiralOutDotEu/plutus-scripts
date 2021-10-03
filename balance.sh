ADDRESS=$(cat wallets/main.addr)
KEY=$1
$CARDANO_CLI query utxo --address $(cat ./wallets/$1.addr) --testnet-magic $TESTNET_MAGIC_NUM

