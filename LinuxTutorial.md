
# MED 263 Linux Tutorial


### vCloud Automation Center (vCAC)
https://idash-hpc-vcacv.ucsd.edu/shell-ui-app/org/idash


### SSH client in your laptop
Windows: Putty (http://www.putty.org/)

macOS / Linux: Terminal


## Log-in to VM (type this in your local computer)
    ssh username@xxx.xxx.xxx.xxx -p xxxx 

---
## Install PLINK, a whole genome association analysis toolset
#### Change a directory
```Shell
$ cd ~ 
```
#### Download a file 
```Shell
$ wget http://pngu.mgh.harvard.edu/~purcell/plink/dist/plink-1.07-x86_64.zip
```

#### Extract a zipped file
```Shell
$ unzip plink-1.07-x86_64.zip
```

#### List files
```Shell
$ cd ~/plink-1.07-x86_64
$ ls -hl
```

#### Test run PLINK 
```Shell
$ ./plink --help 
```

#### Test run PLINK in a different directory (expected to fail)
```Shell
$ cd ~
$ plink --help 
```

#### Add a path to PLINK to the Ubuntu environment file
```Shell
$ echo 'export PATH="~/plink-1.07-x86_64:$PATH"' >> ~/.bashrc 
```

#### Test run PLINK after adding a path-to-PLINK
```Shell
$ cd ~
$ plink --help 
```





---

## Run PLINK

### Create a workspace directory
```Shell
$ mkdir ~/hapmap
$ cd ~/hapmap
```

### Download the example data
```Shell
$ wget http://pngu.mgh.harvard.edu/~purcell/plink/hapmap1.zip
$ unzip hapmap1.zip
```

### List the files
```Shell
$ ls -hl
```

### Take a look at data
```Shell
$ wc -l hapmap1.map
$ wc -l hapmap1.ped
$ head hapmap1.map
$ head hapmap1.ped | cut -d ' ' -f 1-6
```

### Make a binary PED file
```Shell
$ plink --file hapmap1 --make-bed --out hapmap1 --noweb
```

### List the files to see newly created files
```Shell
$ ls -hl
```

### Perform association test (allelic test)
```Shell
$ plink --bfile hapmap1 --assoc --out as1 --noweb
$ wc -l as1.assoc
$ head as1.assoc
$ grep rs21974  as1.assoc
$ grep -w rs219746  as1.assoc
$ sort --key=8 -nr as1.assoc | head -n 20
$ awk '{ if( $9 < 0.00005 ) print $0 }' as1.assoc 
```
### Perform association test (5 different inheritance model)
```Shell
$ plink --bfile hapmap1 --model --cell 0 --snp rs219746 --out rs219746 --noweb 
$ cat rs219746.model
```


---
## Genetic variant annotation and effect prediction 

### Install SnpEff
```ShellSession
$ mkdir ~/snpeff
$ cd ~/snpeff
$ wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip
$ unzip snpEff_latest_core.zip
```

