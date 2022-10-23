# **Spécification de la solution du système journalière**

## **Le choix de la solution RSyslog**

**Le choix de ce logiciel est basé sur plusieurs points :**

    L’une parmi les raisons est qu’il s’agit d’un logiciel open source et facile d’utilisation.
    Il est compatible avec la plupart des OS et facilite l'accès à distance.
    Ce logiciel est très bien documenté et offre de hautes performances mais aussi de bonnes fonctionnalités de sécurité. L’une des autres caractéristiques de ce software est qu’il dispose d’une capacité de recevoir d’une large variété de sources pour l'entrée et ainsi de les transformer afin produire les résultats vers diverses destinations. Il permet aussi de créer différents fichiers de log pour plusieurs processus.
    Ce logiciel dispose de plusieurs avantages et est très utile pour la réalisation de ce projet. Il permet d’avoir une dépôt des logs consultables mais aussi une surveillance de ces derniers. A travers syslog, on est capable d’assurer une meilleure gestion des utilisateurs et l’authentification de ces derniers. Il permet aussi de mettre en place gestion des logs avec les notifications, alertes et ainsi le chiffrement des données.
    À Travers Ryslog, on est capable aussi d'intégrer différentes applications informatiques comme une base de données.

## **Choix du nombre et emplacement de chaque membre sur chaque site**

    - SL-Damas : 2 techniciens pour la gestions des erreurs et problèmes sur sites
    - SL-Beyrouth : 1 administrateur pour la gestion des erreurs mais aussi des erreurs, warnings, des logs critiques venant des autres sites.
    - SP-Montreuil : 2 techniciens pour la gestions des erreurs et problèmes sur site
    - SM-Bateau : 2 techniciens pour la gestions des erreurs et problèmes sur site.

## **Architecture système des serveurs**

### **Introduction**

    Nous avons choisis notre architecture système en fonction des besoins de chacun de nos serveurs. Dans un premier temps nous avons décidé de mettre en place une politique d’archivage des fichiers de logs lorsque ceux-ci dépassent les 500 Mo afin de ne pas saturer les espaces de stockage.

### **Sites principaux**

    Le repository /var/log aura un espace dédié de 20Go avec une mémoire vive de 32Go afin de prévenir toute saturation de la mémoire vive. Nous mettrons en place un système de swap avec un SSD Nvme pour les cas où la demande dépasse nos capacités. Cela nous permettra de ne pas causer un crash du serveur et de maintenir un service.

### **Sites secondaires / backup**

    Nous avons dédié un espace de stockage de 50 Go. Avec 16Go de ram car nous ceux-ci fonctionnent en cluster. Les sites de backup nécessitent plus d’espace de stockage des données car les logs y seront stockés beaucoup plus longtemps que sur les sites principaux.
