---
### MED 263 Linux Tutorial


### vCloud Automation Center (vCAC)
https://idash-hpc-vcacv.ucsd.edu/shell-ui-app/org/idash

## Log-in to VM 
    ssh username@xxx.xxx.xxx.xxx -p xxxx 


## Install PLINK, a whole genome association analysis toolset
#### Change a directory
    cd ~ 

#### Download a file 
    wget http://pngu.mgh.harvard.edu/~purcell/plink/dist/plink-1.07-x86_64.zip

#### Extract a zipped file
    unzip plink-1.07-x86_64.zip

#### List files
    cd ~/plink-1.07-x86_64
    ls -hl

#### Test run PLINK 
    ./plink --help 

#### Test run PLINK in a different directory (expected to fail)
    cd ~
    plink --help 

#### Add a path to PLINK to the Ubuntu environment file
    echo 'export PATH="~/plink-1.07-x86_64:$PATH"' >> ~/.bashrc 

#### Test run PLINK after adding a path-to-PLINK
    cd ~
    plink --help 

## Run PLINK
### Create a workspace directory
    mkdir ~/hapmap
    cd ~/hapmap

### Download the example data
    wget http://pngu.mgh.harvard.edu/~purcell/plink/hapmap1.zip
    unzip hapmap1.zip

### List the files
    ls -hl

### Take a look at data
    wc -l hapmap1.map
    wc -l hapmap1.ped
    head hapmap1.map
    head hapmap1.ped | cut -d ' ' -f 1-6

### Make a binary PED file
    plink --file hapmap1 --make-bed --out hapmap1 --noweb

### List the files to see newly created files
    ls -hl

### Perform association test (allelic test)
    plink --bfile hapmap1 --assoc --out as1 --noweb
    wc -l as1.assoc
    head as1.assoc
    grep rs21974  as1.assoc
    grep -w rs219746  as1.assoc
    sort --key=8 -nr as1.assoc | head -n 20
    awk '{ if( $9 < 0.00005 ) print $0 } ' as1.assoc 

### Perform association test (5 different inheritance model)
    plink --bfile hapmap1 --model --cell 0 --snp rs219746 --out rs219746 --noweb 
    cat rs219746.model
