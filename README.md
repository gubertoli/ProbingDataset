# Probing Dataset
**[UPDATE] For a more detailed approach, take a look in a proposed framework for end-to-end Network Intrusion Detection Systems** *(dataset generation, ML model, performance evaluation and deployment)* **on the [AB-TRAP framework repository](https://github.com/c2dc/AB-TRAP)!**

This repository is composed by a Dataset of Probing Attacks (Port Scan) performed with nmap, unicornscan, hping3, zmap and masscan.

It also presents a way to extract background traffic to be used as "normal" traffic to support Machine Learning algorithms development in IDS research. In this project the current source are the MAWILab datasets.

## Folders and Files Description

### testbed/
Contains all VMs infrastructure to generate the malicious dataset.

### mawilab/

Contains all scripts to generate the normal packets dataset.

## References

Fontugne, R., Borgnat, P., Abry, P., & Fukuda, K. (2010, November). Mawilab: combining diverse anomaly detectors for automated anomaly labeling and performance benchmarking. In Proceedings of the 6th International Conference (p. 8). ACM.

## Cite this repository

Gustavo de Carvalho Bertoli, Lourenço Alves Pereira Júnior, Filipe Alves Neto Verri, & Osamu Saotome. (2019). Probing Dataset (Version v1.0.0) [Data set]. Zenodo. http://doi.org/10.5281/zenodo.3558350

