# Probing Dataset
This repository is composed by a Dataset of Probing Attacks (Port Scan) performed with nmap, unicornscan, hping3, zmap and masscan.

It also presents a way to extract background traffic to be used as "normal" traffic to support Machine Learning algorithms development in IDS research. In this project the current source are the MAWILab datasets.

## Folders and Files Description

### testbed/
Contains all VMs infrasctrure to generate the malicious dataset.

### mawilab/

- splitPcap.sh

Split the original MAWILab dataset (~10Gb) to reduced size to support use on a regular PC

- filterPcap.sh

Filter out anomalous and suspicious packets based on mawilabExtract.py output

- randomPcap.sh

Extract random packets from filtered PCAP files

## References

Fontugne, R., Borgnat, P., Abry, P., & Fukuda, K. (2010, November). Mawilab: combining diverse anomaly detectors for automated anomaly labeling and performance benchmarking. In Proceedings of the 6th International Conference (p. 8). ACM.

da Silva Rodrigues, M., Barbieri, S., de Oliveira, J. P., Marcondes, C. A., & Pereira Jr, L. A. (2019, September). Geração de workload para treinamento, teste, avaliação e comparação de sistemas de detecção de intrusão baseado na replicação de características estatísticas. In Anais do II Workshop de Segurança Cibernética em Dispositivos Conectados (pp. 1-11). SBC.

## Cite this repository

Gustavo de Carvalho Bertoli, Lourenço Alves Pereira Júnior, Filipe Alves Neto Verri, & Osamu Saotome. (2019). Probing Dataset (Version v1.0.0) [Data set]. Zenodo. http://doi.org/10.5281/zenodo.3558350

