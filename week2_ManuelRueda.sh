#-----------------------------------------------------------------------------
# MED 263 Winter 2017
#   Week2 script
#   Author : Manuel Rueda <mrueda@scripps.edu>
#-----------------------------------------------------------------------------
sftp med263@wellderlyweb.scripps.edu
********
get *
quit
tar -xvf med263.tar.gz

# Tip 1 
gzip MA0000901P.vcf
gunzip MA0000901P.vcf.gz

# Tip 2
less MA0000901P.vcf
vi MA0000901P.vcf
head -1000 MA0000901P.vcf | grep CHR | tr '\t' '\n' | nl

# Tip 3 
grep -v ^# MA0000901P.vcf | sort -V | less

# Q1 
grep -v ^# MA0000901P.vcf | wc -l
grep -v -c ^# MA0000901P.vcf

# Q2
grep -v ^# MA0000901P.vcf | grep -w PASS | wc -l
grep -v ^# MA0000901P.vcf | grep -wc PASS

# Q3: Hint: A SNP will have only 1 character [ATGC]
grep -v ^# MA0000901P.vcf | awk 'length($5) == 1' | wc -l

# Q4: Hint: Column 9 -> GT:AD:DP:GQ:PL -> field 'DP'
#  - Min
grep -v ^# MA0000901P.vcf | cut -f 10 | cut -d':' -f 3 | sort -n | head -1
#  - Max
#  - Avg

# Q5: 
head -1 MA0000901P.sga.txt  | tr '\t' '\n' | wc -l

# Q6: Hint: See above
head -1 MA0000901P.sga.txt  | tr '\t' '\n' | nl | grep -w Gene

# Q7: Hint: Isoforms are separated by /// like in SAMD11(uc001abv.1)///SAMD11(uc001abw.1) 

# Q9: You should use the column 'ADVISER_Clinical~Disease_Entry~Explanation'
sed '1d' MA0000901P.sga.txt | cut -f 84 | sort -V > ma.txt
grep '1~Long QT syndrome 3~Pathogenic' MA0000901P.sga.txt |cut -f 9

# Q16
sed '1d' ID00009.sga.txt | cut -f 84 | sort -V > idiom.txt
grep "1~Epileptic encephalopathy, early infantile, 26~Pathogenic" ID00009.sga.txt  | tr '\t' '\n'
 
# Q17: Genotypes follow this order '01P-02M-03F'. Unique variants for the proband will have this string '01-00-00'. Note that In the Proband they will be de-novo
#  - 01P
grep -c '01-00-00' ID00009.sga.txt #  grep -wc '01-00-00' ID00009.sga.txt -> -w and '' are optional
#  - 02M
#  - 03F

# Q18: Hint: Use column 'Coding_Impact'

# Q19: Hint: You will need to download the REPORT from the website

# Q20: