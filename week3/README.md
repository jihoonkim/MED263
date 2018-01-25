# Week 3. Exploring Raw NGS Data (Olivier Harismendy)



### Docker

1. Install Docker

2. Choose and change to a working directory in your host computer (your laptop computer in most cases).

3. Please download and extract materials and recource data in [Zip file](https://ucsdcloud-my.sharepoint.com/:f:/g/personal/j5kim_ucsd_edu/EtUDDgyYbNxDrgZZmbWpgbMBrpJhUUMeC2J5Q6lmeJY3NA) to your working directory.

4. Start running docker by typing following command in Terminal (macOS/Linux) or Docker Quickstart Terminal (Windows). Replace `/Users/johndoe/mylocalfolder` with your own working directory in your local/host computer (=laptop computer).
```bash
docker run -it -v /Users/johndoe/mylocalfolder:/work j5kim/med263-harismendy /bin/bash
```


### Integrative Genomics Viewer (IGV)

1. Install [Java](https://www.java.com/en/download).

2. Install [Integrative Genomics Viewer (IGV)](http://software.broadinstitute.org/software/igv/download).
