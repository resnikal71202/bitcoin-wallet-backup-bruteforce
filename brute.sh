#!/bin/bash

SOLVED="org.bitcoin.production"

file=$1

while read line; do
        openssl enc -d -aes-256-cbc -md md5 -a -in $2 -pass pass:$line > bitcoin-wallet-decrypted-backup 2> /dev/null

        if [ $(cat bitcoin-wallet-decrypted-backup | tr -cd '[:print:]' | awk '{print $1}' | cut --bytes=-25) == "$SOLVED" ];
        then
                echo "Password: $line"
                rm bitcoin-wallet-decrypted-backup
                exit
        fi
done <$file
