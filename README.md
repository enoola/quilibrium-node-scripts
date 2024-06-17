#15/06/2024, 12:46
# quilibrium-node-scripts
small scripts for quilibrium nodes, it only complete what I couldn't find on docs.quilibrium.com.


### Lists

[ ] oneshot stepbystep keybackup
[ ] backup node
[ ] log revenu



### Backup your store to destination server

```
tar -cvzf
rsync -e "ssh -i ~/.ssh/id_ed25519" /root/ceremonyclient/node/.config/key.yml user@yourserver.tld
rsync -e "ssh -i ~/.ssh/id_ed25519" /root/ceremonyclient/node/.config/config.yml user@yourserver.tld
```

the idea is that our nodes sync github via a common pub key

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_qnode

then
git clone git@github.com:enoola/quilibrium-node-scripts.git