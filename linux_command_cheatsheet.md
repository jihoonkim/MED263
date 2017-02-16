# MED 263 Linux command cheatsheet

---

#### Find the top 20 large files size larger than 100 MB (and delete them if not needed)
```Shell
sudo find / -type f -size +100M -print |  xargs du -s | sort -k 1 -nr  | head -n 20
```


#### Create a 'workspace' directory and change its owner to 'johndoe'
```Shell
sudo mkdir /tmp/workspace
sudo chown johndoe:johndoe /tmp/workspace
```