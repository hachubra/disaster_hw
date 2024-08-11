sudo apt install rsync
ssh-keygen -t rsa 
ssh-copy-id alex@192.168.123.4 
rsync -a --progress --checksum --delete --exclude='.*/' . alex@192.168.123.4:/tmp/backup