# Modélisation conceptuelle 

Prenons l’exemple d’une base de données d’auteurs et de livres.

!!! abstract "Cours" 
    Les données ayant des caractéristiques similaires sont regroupées dans une **entité-type**. 

    Chaque **occurrence** d’une entité-types est appelée une **entité**[^1.1]  (ou une **instance* ou encore un **tuple**).

[^1.1]: Par abus de langages on mélange souvent les termes entités et entités-types.

Par exemple, l'entité-type `Auteur`[^1.2] ci-dessous regroupe tous les noms, prénoms et dates de naissances des auteurs.  Victor Hugo et Emile Zola sont des entités, ce sont des occurrences de l’entité-type.

[^1.2]: Par convention, les noms des entités-types sont au singulier.

![Entité-type des noms, prénoms et dates de naissances des auteurs](assets/1-entite-type-light-mode.png#only-light){width="70%"}
![Entité-type des noms, prénoms et dates de naissances des auteurs](assets/1-entite-type-dark-mode.png#only-dark){width="70%"} 


!!! abstract "Cours" 
    Les caractéristiques d’un entité-type sont appelées les **attributs** (ou propriété type).

    On appelle **domaine**  d'un attribut l'ensemble des valeurs possibles d’un attribut.

    L’identifiant ou **clé** est un attribut (ou une combinaison de plusieurs attributs) qui permet d'identifier de manière unique une entité.


![Attributs d'une entité-type d'auteurs](assets/1-attributs-light-mode.png#only-light){width=20% align=right}
![Attributs d'une entité-type d'auteurs](assets/1-attributs-dark-mode.png#only-dark){width=20% align=right}

Ici,  le nom, le prénom et la date de naissance sont des attributs de l’entité–type `Auteur`.  Le domaine de l'attribut `Date_naissance` d'un auteur est l'ensemble des dates comprises entre deux valeurs choisies. Plusieurs auteurs peuvent avoir le même `Nom`, voire les mêmes `Nom` et `Prénom`, ici on choisit de leur donner un numéro (par exemple leur numéro de sécurité sociale) pour les identifier de façon unique. `Num_auteur` est une clé de l’entité-type `Auteur`. 

!!! abstract "Cours" 
    Les entités-types sont liées entre elles par des associations. 
    
Par exemple on peut associer un auteur avec l’entité type `Pays` par l’association `Originaire de` ou avec l’entité-type `Livre` par l’association `Ecrit`. 

La modélisation conceptuelle aboutit à une représentation des données sous la forme d’un diagramme appelé **schéma conceptuel**.

![Schéma conceptuel de données concernant des auteurs et des livres](assets/1-schema-conceptuel-light-mode.png#only-light)
![Schéma conceptuel de données concernant des auteurs et des livres](assets/1-schema-conceptuel-dark-mode.png#only-dark)

Une association peut aussi avoir des attributs, par exemple ici `Ecrit` possède un attribut `NB_chapitre`.

Pour finir le schéma conceptuel montre les cardinalités d’une association pour indiquer le nombre d’associations possibles entre les entités-types:

!!! abstract "Cours" 
    La **cardinalité** d’une association entre deux entités-types indique le nombre d’associations possibles entre ces entités-types. Elle peut prendre les valeurs:

    •	`1, 1` lorsqu'une association ne permet à une entité d'être liée qu'à une, et une seule, entité d'une autre entité-type, par exemple ici un auteur (une entité d’`Auteur`) doit être originaire d'un pays (une entité de `Pays`) et un seul.

    •	`0, 1` lorsqu'une association  permet à une entité d'être liée à aucune, ou à une mais pas plus entité d'une autre entité-type.

    •	`1, N` lorsqu'une association permet à une entité d'être liée à au moins une, ou à plusieurs entités d'une autre entité-type, par exemple un auteur peut avoir écrit un ou plusieurs livres (mais pas zéro).

    •	`0, N` lorsqu'une association permet à une entité d'être liée à aucune, à une, ou à plusieurs entités d'une autre entité-type.
    
    
