# MED 263 Linux command cheatsheet

---

#### Find the top 20 large files size larger than 100 MB (and delete them if not needed)
```Shell
sudo find / -type f -size +100M -print |  xargs du -s | sort -k 1 -nr  | head -n 20
```