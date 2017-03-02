# How to install Jupyter and its R kernel

---

#### In a remote terminal, become a root to install Jupyter and its R kernel
```Shell
sudo su -
wget https://github.com/jihoonkim/MED263/raw/master/provision/install_Jupyter.sh
bash install_Jupyter.sh
```

---


#### In a remote terminal, start the jupyter notebook
```Shell
jupyter notebook --no-browser
```

---

#### In your laptop, type this line in your terminal
```Shell
ssh -f -N -L 8888:localhost:8888 johndoe@172.3.4.5 -p 9221
```

#### In your laptop, open a web browser
- go to http://localhost:8888

#### In your laptop, check which port number is already occupied and, to release it, kill the process ID '1234'
```Shell
ps -ax | grep ssh | grep localhost
kill  1234
```