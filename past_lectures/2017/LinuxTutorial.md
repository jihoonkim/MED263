
# MED 263 Linux Tutorial

---

## Aim : learn basic linux commands through bioinformatics apps
1. Perform genotype-phenotype association test with [PLINK](http://pngu.mgh.harvard.edu/~purcell/plink)
2. Create a small subset from the raw .vcf file with [VCFTools](https://vcftools.github.io) 
3. Annotate genetic variants with [SnpEff](http://snpeff.sourceforge.net)


## Log-in to VM (in your local computer)
```diff
- Please type the command below in the terminal of your local laptop computer
```
```Shell
$ ssh username@xxx.xxx.xxx.xxx -p xxxx 
password: 8-digit-RSA_app_passcode
```
<!---
#### vCloud Automation Center (vCAC)
https://idash-hpc-vcacv.ucsd.edu/shell-ui-app/org/idash
-->

#### SSH client in your laptop
Windows: Putty (http://www.putty.org/)

macOS / Linux: Terminal


---
## Install PLINK, a whole genome association analysis toolset

#### Change a shell to bash
```Shell
$ bash 
```

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
$ source ~/.bashrc
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
$ cd ~/hapmap
$ wget http://pngu.mgh.harvard.edu/~purcell/plink/hapmap1.zip
$ unzip hapmap1.zip
```

### List the files
```Shell
$ cd ~/hapmap
$ ls -hl
```

### Take a look at data
```Shell
$ cd ~/hapmap
$ wc -l hapmap1.map
$ wc -l hapmap1.ped
$ head hapmap1.map
$ head hapmap1.ped | cut -d ' ' -f 1-6
```

### Make a binary PED file
```Shell
$ cd ~/hapmap
$ plink --file hapmap1 --make-bed --out hapmap1 --noweb
```

### List the files to see newly created files
```Shell
$ cd ~/hapmap
$ ls -hl
```

### Perform association test (allelic test)
```Shell
$ cd ~/hapmap
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
$ cd ~/hapmap
$ plink --bfile hapmap1 --model --cell 0 --snp rs219746 --out rs219746 --noweb 
$ cat rs219746.model
```


---
## Genetic variant annotation and effect prediction 

### Install SnpEff
```ShellSession
$ cd ~
$ wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip
$ unzip snpEff_latest_core.zip
```


### Download resource data (pre-built human database)
```ShellSession
$ cd ~/snpEff
$ nohup java -jar snpEff.jar download -v GRCh37.75 & 
```



### Download VCF file
```ShellSession
$ mkdir ~/annotation
$ cd ~/annotation
$ wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/NISTv3.2/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2_highconf.vcf.gz
$ gunzip NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2_highconf.vcf.gz 
$ wc -l NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2_highconf.vcf 
```


### Install and run vcfools to create a small VCF (for a quick test-run during the class)
```ShellSession
$ cd ~
$ sudo apt-get install -y -y build-essential git g++ htop libncurses5-dev libssl-dev make pkg-config software-properties-common make zlibc zlib1g zlib1g-dev  
$ git clone https://github.com/vcftools/vcftools.git
$ cd vcftools
$ sudo ./autogen.sh
$ sudo ./configure
$ sudo make
$ sudo make install
$ vcftools --help
$ cd ~/annotation
$ vcftools --vcf NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2_highconf.vcf  --chr 21 --recode --recode-INFO-all --out chr21
$ wc -l chr21.recode.vcf
```


### Annotate the VCF 
```ShellSession
$ cd ~/annotation
$ java -Xmx7g -jar ~/snpEff/snpEff.jar -v GRCh37.75  chr21.recode.vcf > chr21anno.vcf
$ wc -l chr21anno.vcf
$ head chr21anno.vcf
$ tail chr21anno.vcf
```

### Filter the high-impact variants only.
#### high-impact: high (disruptive) impact in the protein, probably causing protein truncation, loss of function or triggering nonsense mediated decay.  
```ShellSession
$ cd ~/annotation
$ grep HIGH chr21anno.vcf 
$ grep HIGH chr21anno.vcf | wc -l
$ grep HIGH chr21anno.vcf  >> chr21annohigh.vcf
$ wc -l chr21annohigh.vcf
$ head chr21annohigh.vcf
$ tail chr21annohigh.vcf
```

### Transfer annotation output to your local laptop computer
```diff
- Please type the commands below in the terminal of your local laptop computer
```
```ShellSession
$ cd ~/annotation
$ zip archive.zip chr21annohigh.vcf snpEff_summary.html 
$ scp -P portnumber username@IPaddress:/home/username/annotation/archive.zip .
```

### Repeat SnpEff annotation with the whole .vcf file



