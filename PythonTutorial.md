# MED 263 Python Tutorial

## Data types

#### Numbers
```python
>>> 1 + 2
3
>>> 5 + 5 + 5
15
>>> 5 ** 3
125
>>> 5^3
6
>>> help('^')
>>> 1^1
0
>>> 1^0
1
>>> 12 / 5
2
>>> 11 / 5
2
>>> 11.0 / 5
2.2
```

#### String
```python
>>> motif = 'CCTTATAAGG'
>>> len(motif)
10
>>> motif[0]
'C'
>>> motif[1]
'C'
>>> motif[2]
'T'
>>> motif[0:3]
'CCT'
>>> motif[4:7]
'ATA'
>>> motif[-2]
'G'
```


#### File parsing
```Shell
$ cd ~/annotation
$ python
```
```python
>>> fname = "chr21anno.vcf"
>>> fh = open(fname)
>>> line = fh.readline()
>>> while line.startswith("#"):
...     line = fh.readline()
... 
>>> line = line.rstrip("\n")
>>> arr = line.split("\t")
>>> arr
['21', '9412105', '.', 'A', 'T', '50.0', 'PASS', 'platforms=3;platformnames=Illumina,CG,Solid;datasets=3;datasetnames=HiSeqPE300x,CGnormal,SolidSE75bp;callsets=4;callsetnames=HiSeqPE300xfreebayes,HiSeqPE300xGATK,CGnormal,SolidSE75GATKHC;datasetsmissingcall=IonExome,SolidPE50x50bp;lowcov=CS_IonExomeTVC_lowcov,CS_SolidPE50x50GATKHC_lowcov,CS_SolidSE75GATKHC_lowcov;filt=CS_HiSeqPE300xfreebayes_filt,CS_HiSeqPE300xGATK_filt;ANN=T|intergenic_region|MODIFIER|CR381670.1|ENSG00000238411|intergenic_region|ENSG00000238411|||n.9412105A>T||||||', 'GT:PS:DP:GQ', '0/1:.:1157:99']

```