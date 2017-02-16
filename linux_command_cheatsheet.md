# MED 263 Linux command cheatsheet

---

#### Report the disk space usage
```Shell
df -h
```

#### Find the top 20 large files size larger than 100 MB (and delete them if not needed)
```Shell
sudo find / -type f -size +100M -print |  xargs du -s | sort -k 1 -nr  | head -n 20
```

#### Delete a target directory '/home/johndoe/week2run' recursively.
```Shell
rm -rf /home/johndoe/week2run
```

#### Create a 'workspace' directory and change its owner to 'johndoe'
```Shell
sudo mkdir /tmp/workspace
sudo chown johndoe:johndoe /tmp/workspace
cd /tmp/workspace
```

#### Move a directory '/home/johndoe/week2run' to under '/tmp/workspace'
```Shell
mv /home/johndoe/week2run /tmp/workspace
```