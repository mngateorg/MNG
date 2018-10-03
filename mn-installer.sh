#/bin/bash
clear
echo "* Do you want to install all needed dependencies (no if you did it before)? [y/n]"
read DOSETUP

if [[ $DOSETUP =~ "y" ]] ; then
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install build-essential libssl-dev libdb++-dev libboost-all-dev libqrencode-dev autoconf automake libgmp3-dev miniupnpc libminiupnpc-dev
fi

echo "* Do you want to compile Daemon (please choose no if you did it before)? [y/n]"
read DOSETUPTWO

if [[ $DOSETUPTWO =~ "y" ]] ; then

MNGated stop > /dev/null 2>&1
wget https://github.com/mngateorg/MNG/blob/master/storage/MNGated -O /usr/local/bin/MNGated
chmod +x /usr/local/bin/MNGated

fi

echo "Enter masternode private key for node, Go To your Windows Wallet > Console, type masternode genkey"
read PRIVKEY

CONF_DIR=~/.MNGate/
CONF_FILE=MNGate.conf

mkdir -p $CONF_DIR
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` > $CONF_DIR/$CONF_FILE
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> $CONF_DIR/$CONF_FILE
echo "rpcallowip=127.0.0.1" >> $CONF_DIR/$CONF_FILE
echo "listen=1" >> $CONF_DIR/$CONF_FILE
echo "server=1" >> $CONF_DIR/$CONF_FILE
echo "daemon=1" >> $CONF_DIR/$CONF_FILE
echo "logtimestamps=1" >> $CONF_DIR/$CONF_FILE
echo "masternode=1" >> $CONF_DIR/$CONF_FILE
echo "masternodeprivkey=$PRIVKEY" >> $CONF_DIR/$CONF_FILE

MNGated -daemon -reindex
