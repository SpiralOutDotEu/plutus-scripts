Quick and Dirty Alonzo Bash Scripts
===================================

These are some helper scripts I used while working with the Alonzo testnet.

I use this repo in some of [my notes](https://plutus-pioneer-program.readthedocs.io/en/latest/alonzo.html) on running the Alonzo White exercises.

# Cardano-cli 

Please refer to the [cardano-node releases](https://github.com/input-output-hk/cardano-node/releases/latest) page to ensure you are working with the latest version of the node.

1. Download correct cardano-node version
```
docker image pull inputoutput/cardano-node:<TAG>
```

```
docker volume create cardano-node-data
docker volume create cardano-node-ipc
```

```
docker run -e NETWORK=mainnet -v cardano-node-ipc:/ipc -v cardano-node-data:/data inputoutput/cardano-node
```

```
docker run -e NETWORK=testnet -v cardano-node-ipc:/ipc -v cardano-node-data:/data inputoutput/cardano-node
```

`NetworkMagic: 1097911063`

```
export CLI='docker run -it --entrypoint cardano-cli -e NETWORK=mainnet -e CARDANO_NODE_SOCKET_PATH=/ipc/node.socket -v cardano-node-ipc:/ipc inputoutput/cardano-node'
$CLI version
$CLI query tip --mainnet
$CLI transaction build-raw ... --mainnet
```

```
export CARDANO_CLI='docker run -it --entrypoint cardano-cli -e NETWORK=testnet -e CARDANO_NODE_SOCKET_PATH=/ipc/node.socket -v cardano-node-ipc:/ipc inputoutput/cardano-node'
$CARDANO_CLI version
$CARDANO_CLI query tip --testnet-magic 1097911063
$CARDANO_CLI transaction build-raw ... --testnet-magic 1097911063
export TESTNET_MAGIC_NUM=1097911063
```

```
export CARDANO_CLI=/home/v-dev/WebstormProjects/Crypt/cardano-node-1.30.0/cardano-cli
```

```
$CARDANO_CLI query tip --testnet-magic $TESTNET_MAGIC_NUM
$CARDANO_CLI query tip --testnet-magic $TESTNET_MAGIC_NUM | jq -r '.syncProgress'
```

```
$CARDANO_CLI query utxo --address addr_test1vzxvyh23348u5a750sncs047etxd4ygn3gd3hq82asazuggp66ey8 --testnet-magic
$CARDANO_CLI query utxo --address addr_test1qpzrv9xhphka8xaxccrwu453n3y8lr7g0fxf5g78zhnse75vaz65x5uf3ph6njugekzden73kk7d6c5yaqnq4uakl0zss5cqaz --testnet-magic $TESTNET_MAGIC_NUM
```
# Payment to wallet

## Generate payment wallet key-pair

```
$CARDANO_CLI address key-gen \
--verification-key-file ./receive-ada-sample/keys/payment.vkey \
--signing-key-file ./receive-ada-sample/keys/payment.skey
```

## Generate payment key-pair
```
$CARDANO_CLI address build \
--payment-verification-key-file ./receive-ada-sample/keys/payment.vkey \
--out-file ./receive-ada-sample/keys/payment.addr \
--testnet-magic $TESTNET_MAGIC_NUM
```
## Generate payment key-pair for main wallet
```
$CARDANO_CLI address build \
--payment-verification-key-file ./receive-ada-sample/keys/main.vkey \
--out-file ./receive-ada-sample/keys/payment.addr \
--testnet-magic $TESTNET_MAGIC_NUM
```


https://plutus-pioneer-program.readthedocs.io/en/latest/alonzo/wallets_and_funds.html

