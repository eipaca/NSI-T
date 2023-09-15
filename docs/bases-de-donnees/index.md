# Bases de données

Comme vu en classe de première, il est possible de stocker et manipuler des données structurées dans différents formats : tableaux de tableaux, tableaux de dictionnaires, fichiers CSV ou JSON, etc. Ces formats sont vite limités quand on veut manipuler un grand nombre d'informations, en particulier lorsque celles-ci se trouvent réparties dans plusieurs tables ou fichiers.

Les premières bases de données sont apparues dans les années 1960 et se sont développées en même temps que l'informatique. Dans les années 1980 est apparu le langage SQL spécialement conçu pour faire des requêtes (sélectionner, filtrer, mettre à jour) sur les systèmes de bases de données.

De nos jours les bases de données sont omniprésentes : un smartphone utilise une base de données pour stocker l’information quand on passe d’une app à l’autre, un site internet est souvent adossé à une base de données par exemple l’e-commerce ou un blog.

!!! abstract "Cours" 
    Une base de données représente un ensemble ordonné de données...

... sur un sujet particulier, enregistré sur un système informatique ou non, et représentant une partie du monde.

Quand une base de données est stockée dans un système informatique, les données ne sont en général pas lisibles par un humain : il est nécessaire d’utiliser un système de base de données (SGBD) pour les exploiter.

!!! abstract "Cours" 
    Un  système de gestion de base de données (SGBD) est le logiciel qui permet de gérer une base de données sur un support informatique.

Un SGBD permet  la structuration, le stockage, la mise à jour et la maintenance des données. C’est l’interface entre la base de données et les utilisateurs.

Exemple de SGBD : MySQL, MS Access, Oracle, Sybase, SQLite

Dans une base de données, les données doivent être organisées de façon logique et utilisable pour les utilisateurs. C’est la conception de la base de données. Elle se fait en trois étapes :
1.	Modélisation conceptuelle : définition abstraite des données et de comment elles s’organisent.
2.	Conception logique : le modèle relationnel (ou autres[^0.1] ) modélise la structure selon laquelle les données seront
stockées. 
3.	Conception physique : l’implémentation dans un logiciel informatique (un Système de Gestion de Bases de Données ou SGBD).

[^0.1]: Il exsite d'autres modèle d'organisation de données, par exemple sous forme d’arbre (JSON, XML) ou de graphes.