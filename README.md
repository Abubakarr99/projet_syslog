# **Mise en place d'un système de journalisation RSYSLOG**

## **L'objectif du projet**

Le but de ce projet est de pouvoir proposer un solution d'un système de journalisation sur une architecture réseau pour un client dans des conditions équivelant à un milieu professionnel.

## **Organisation du groupe sur le projet**

Ainsi, nous sommes répartie de cette façon suivante :

|   CCTP    |     SPECS    |     ARCHI    |        POC        |
|-----------|--------------|--------------|-------------------|
| Hugo DIAZ | Abdoulaye BA | Vinoth EBOLY | Abubarkarr KAMARA |
|           | Erwan GOUR   | Hazem BRINI  | Hazem BRINI       |
|           |              |              | Vinoth EBOLY      |
|           |              |              | Abdoulaye BA      |
|           |              |              | Hugo DIAZ         |
|           |              |              | Erwan GOUR        |

## **Exécution du POC**

Pour éxécuter le projet, il suffit d'utiliser la commande **make** et de suivre les instructions dans cette ordre :

```text
rolex@ubuntuz:~/Documents/projet_syslog$ make

build                            build docker images
network                          create network
push                             push docker image
run                              run infrastructure
shutdown                         shutdown infra
```
