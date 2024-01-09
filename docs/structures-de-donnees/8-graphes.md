# Structures relationnelles : graphes

!!! abstract "Cours"

    Un graphe est un type abstrait de données constitué de **sommets** reliés entre eux par des **arêtes** ou **arcs** (selon le type de graphe). 
    
    Un graphe peut être :

    -	**non-orienté**, chaque **arête** peut-être parcourue dans les deux sens.
    -	**orienté**, chaque **arc** ne peut-être parcouru que dans un seul sens indiqué par une flèche.
    -	**pondéré**, chaque arête porte une valeur (aussi appelée poids ou coût).

    === "graphe non orienté"
        ![Exemple de graphe non orienté](assets/8-graphe-0-light-mode.png#only-light){width="30%"}
        ![Exemple de graphe non orienté](assets/8-graphe-0-dark-mode.png#only-dark){width="30%"}
    

    === "graphe orienté"
        ![Exemple de graphe orienté](assets/8-graphe-1-light-mode.png#only-light){width="30%"}
        ![Exemple de graphe orienté](assets/8-graphe-1-dark-mode.png#only-dark){width="30%"}

    === "graphe pondéré"
        ![Exemple de graphe pondéré](assets/8-graphe-2-light-mode.png#only-light){width="30%"}
        ![Exemple de graphe pondéré](assets/8-graphe-2-dark-mode.png#only-dark){width="30%"}


Les graphes trouvent de nombreuses applications en informatique, par exemple dans une modélisation de réseau de routeurs, de réseau social, de réseau routier, de labyrinthe, etc.


!!! abstract "Cours"
    Le nombre de sommets d'un graphe est l'**ordre** du graphe, le nombre d’arêtes est la **taille** du graphe.

    Deux sommets reliés entre eux par une arête sont dits **adjacents** ou **voisins**.

    === "voisinage de A dans un graphe orienté"
        ![Voisinage de A dans un graphe orienté](assets/8-graphe-3-light-mode.png#only-light){width="30%"}
        ![Voisinage de A dans un graphe orienté](assets/8-graphe-3-dark-mode.png#only-dark){width="30%"}
    

    === "voisisage de D dans un graphe orienté"
        ![Voisisage de D dans un graphe orienté](assets/8-graphe-4-light-mode.png#only-light){width="30%"}
        ![Voisisage de D dans un graphe orienté](assets/8-graphe-4-dark-mode.png#only-dark){width="30%"}

    === "voisinage de D dans un graphe non orienté"
        ![Voisisage de D dans un graphe non orienté](assets/8-graphe-5-light-mode.png#only-light){width="30%"}
        ![Voisisage de D dans un graphe non orienté](assets/8-graphe-5-dark-mode.png#only-dark){width="30%"}

    Le **degré** d'un sommet est le nombre d'arêtes issues de ce sommet. La somme des degrés des sommets est le double du nombre d'arêtes du graphe[^8.1].

    [^8.1]: En ajoutant les degrés de chaque sommet (c'est à dire le nombre d'arêtes issues de ce sommet), on comptabilise deux fois chaque arête (une fois avec le sommet d'une extrémité et une seconde fois avec le sommet de l'autre extrémité de l'arête).  Il en découle que la somme des degrés des sommets est nécessairement paire et donc que le nombre de sommets de degré impair est pair.


Un même graphe peut avoir de nombreuses représentations graphiques. Voici trois représentation d'un même graphe :

![Trois représentation d'un même graphe ](assets/8-graphe-6-light-mode.png#only-light)
![Trois représentation d'un même graphe ](assets/8-graphe-6-dark-mode.png#only-dark)

!!! abstract "Cours"
    Un **chemin** (ou **chaine** pour les graphes non orientés) est une suite de sommets reliés par des arêtes. 

    Un **cycle** (ou **circuit** pour les graphes non orientés) est un chemin fermé.

Remarque : dans un graphe orienté, il peut exister un chemin menant du sommet x au sommet y, alors que l’inverse n’est pas possible.

Exemple : chemin menant de A à C, que l’on peut noter A→B→D→C

![Chemin menant de A à C passant par B et D](assets/8-graphe-7-light-mode.png#only-light){width="30%"}
![Chemin menant de A à C passant par B et D](assets/8-graphe-7-dark-mode.png#only-dark){width="30%"}

!!! abstract "Cours"
    La **distance** entre deux sommets d’un arbre est la longueur (nombre d’arêtes) du **chemin le plus court** (s’il y en a un) reliant ces deux sommets.

Exemple : la distance entre A et C est la distance du plus court chemin de A à C (A→D→C), soit 2 (arêtes).
![Distance de A à C ](assets/8-graphe-8-light-mode.png#only-light){width="30%"}
![Distance de A à C ](assets/8-graphe-8-dark-mode.png#only-dark){width="30%"}
