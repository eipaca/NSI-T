# Algorithmes sur les arbres binaires et sur les arbres binaires de recherche

!!! abstract "Cours" 
    Un arbre est une structure de données **hiérarchique** (les nœuds sont liés par des relations père-fils) et récursive. 
    
    Un **arbre binaire** (**AB**) est un cas particulier d'arbre où chaque nœud possède au **maximum deux fils ordonnés** : un fils droit et/ou un fils gauche. Ils ne sont pas intervertibles !


On a déjà implémenté un arbre binaire et ses nœuds en Python par les classes AB  et Noeud  :

![Un exemple d'arbre binaire](assets/1-ab-exemple-light-mode.png#only-light){width="25%" align=right}
![Un exemple d'arbre binaire](assets/1-ab-exemple-dark-mode.png#only-dark){width="25%" align=right}

``` py
class AB: 
    def __init__(self, racine = None): 
        self.racine = racine # type : Noeud 

class Noeud: 
    def __init__(self, v, g = None, d = None): 
        self.g = g # type Noeud 
        self.d = d # type Noeud 
        self.v = v
```

Implémentons l'arbre ci-contre.

``` py
n9, n4 = Noeud(9), Noeud(4)
n1, n12 = Noeud(1, n9, n4), Noeud(12)
n6 = Noeud(6, n1, n12)
n3 = Noeud(3)
n10 = Noeud(10, d = n3)
arbre = AB(Noeud(5, n10, n6))
```

## Calcul de la taille d'un arbre binaire

!!! abstract "Cours" 
    La taille d'un arbre est son nombre de nœuds

Pour calculer la taille d'un arbre, on parcourt toutes les branches et compter le nombre de nœuds à partir de la racine. 

Pour un arbre binaire, on peut créer une méthode récursive de la classe `Noeud` :  `taille()`. Cette méthode renvoie la somme des tailles de ses deux branches.

![Un exemple de calcul de la taille d'arbre binaire](assets/1-ab-taille-light-mode.png#only-light){width="40%" align=right}
![Un exemple de calcul de la taille d'arbre binaire](assets/1-ab-taille-dark-mode.png#only-dark){width="40%" align=right}

 Pour un arbre binaire (classe `AB`) on ajoute une autre méthode appelée aussi `taille()` qui renvoie `0` pour l'arbre vide ou sinon la taille du Nœud  racine.



``` py
class AB: 
    def taille(self):
        if self.racine == None: return 0
 # renvoie la taille du nœud racine
        return self.racine.taille()

class Noeud: 

    def taille(self):
        # taille du sous arbre gauche
        if self.gauche is None:
            tg = 0  
        else:
            tg = self.gauche.taille()

        # taille du sous arbre droit
        if self.droite is None:
            td = 0
        else:
            td = self.droite.taille()

        # la taille est 1 + la somme des deux 
        return 1 + td + tg
```

Calculons la taille de l'arbre précédent :

``` py
>>> arbre.taille()
8
``` 

Le calcul de la taille a un coût proportionnel à la taille du nombre de nœuds n de l'arbre (pour chaque nœud supplémentaire, on rajoute 3 opérations). La **complexité du calcul de la taille est en $O(n)$**. 


##	Calcul de la hauteur d'un arbre binaire

!!! abstract "Cours" 
    -	La **profondeur** d'un nœud est le nombre d'arêtes de la racine au nœud. La profondeur de la racine est donc 0.

    -	La **hauteur** d'un arbre est la plus grande profondeur d'une feuille de l'arbre. Un arbre réduit à la racine a une hauteur de 0, un arbre vide a une hauteur de -1 (par convention).

Pour calculer la hauteur d'un arbre, il faut parcourir toutes ses branches et retenir la profondeur de la feuille la plus éloignée. 

![Un exemple de calcul de la hauteur d'arbre binaire](assets/1-ab-hauteur-light-mode.png#only-light){width="40%" align=right}
![Un exemple de calcul de la hauteur d'arbre binaire](assets/1-ab-hauteur-dark-mode.png#only-dark){width="40%" align=right}

Pour un arbre binaire, on peut de la même façon que pour la taille, créer une méthode récursive de la classe `Noeud` :  `hauteur()`. Cette méthode renvoie la plus grande des hauteurs de ses deux branches plus 1. Pour un arbre binaire (classe `AB`) on ajoute une autre méthode appelée aussi `hauteur()` qui renvoie `-1` pour l'arbre vide ou sinon la hauteur du Nœud racine.


``` py 
class AB: 

    def hauteur(self):
        if self.racine == None: return -1
        # renvoie la hauteur du nœud racine
        return self.racine.hauteur()

class Noeud:     
    def hauteur(self):
        # hauteur du sous arbre gauche
        if self.gauche is None:
            hg = -1  # par convention l'arbre vide a une hauteur de -1
        else:
            hg = self.gauche.hauteur()

        # hauteur du sous arbre droit
        if self.droite is None:
            hd = -1  # par convention l'arbre vide a une hauteur de -1
        else:
            hd = self.droite.hauteur()

        # la hauteur est 1 + le plus grand des deux
        return 1 + max(hg, hd)

```

Le calcul de la hauteur a un coût proportionnel à la taille du nombre de nœuds n de l'arbre (pour chaque nœud supplémentaire, on rajoute 3 opérations). La **complexité du calcul de la hauteur est en $O(n)$**.

 
## Parcourir un arbre binaire

Parcourir un arbre consiste à visiter chaque nœud en gardant en mémoire son fils gauche et son fils droit (dans cet ordre) avant de les parcourir à leur tour. Il existe de nombreux algorithmes de parcours qui visitent chaque nœuds dans un **ordre différent**, les plus courants[^1.0] sont le parcours en largeur et le parcours en profondeur.

[^1.0]:  D'autres algorithmes existent, par exemple la recherche arborescente Monte-Carlo.

###	Parcours en largeur (BFS)

!!! abstract "Cours" 
    Le **parcours en largeur** ou **BFS** (*Breadth First Search*), consiste à parcourir l'arbre **niveau par niveau**. Les nœuds de niveau 0 sont d'abord parcourus puis les nœuds de niveau 1 et ainsi de suite. Dans chaque niveau, les nœuds sont parcourus de la **gauche vers la droite**.

![Exemple de parcours en largeur d'un AB](assets/1-ab-bfs-light-mode.png#only-light){width="40%"}
![Exemple de parcours en largeur d'un AB](assets/1-ab-bfs-dark-mode.png#only-dark){width="40%" }


L'implémentation se fait en utilisant une structure en file : 

- La racine est d'abord mise dans la file, puis
- Tant que la file n'est pas vide:
    - On défile le premier noeud entré dans la file
    - On note sa valeur dans le parcours
    - On enfile ses fils gauche et droite, dans cet ordre, s'ils existent. 

La méthode est itérative, on n'utilise pas la récursivité de la classe `Noeud`, on peut donc l'ajouter au choix dans la classe `Noeud` ou dans la classe `AB` directement:

``` py
class Noeud:
    def parcours_larg(self):
        parcours = []
        file = []         # file de noeuds en attente
        file.append(self)
        while len(file) != 0:   # tant que la file n'est pas vide
            n = file.pop(0)             # on défile le premier nœud de la file
            parcours.append(n.valeur)   # on note sa valeur
            # on enfile le fils gauche s'il existe
            if n.gauche is not None: 
                file.append(n.gauche)  
            # on enfile le fils drot s'il existe
            if n.droite is not None: 
                file.append(n.droite)
        return parcours

```

et l'appel de la méthode pour le nœud racine :

``` py
class AB :
    def parcours_larg(self):
        if self.racine is None: print("l'arbre est vide")
        else: return self.racine.parcours_larg()


>>> arbre.parcours_larg()
[5, 10, 6, 3, 1, 12, 9, 4]
```

### Parcours en profondeur (DFS)

!!! abstract "Cours" 
    Le **parcours en profondeur** ou **DFS** (*Depth First Search*) consiste à parcourir pour chaque nœud d'abord le sous-arbre gauche entièrement et ensuite le sous arbre droit.

    Chaque nœud est parcouru trois fois, on peut donc décider de traiter le nœud :

    - Avant le parcours de son sous-arbre gauche : parcours **préfixe** (ou **préordre**) ;
    - Entre le parcours de sous-arbre gauche et celui de son sous-arbre droit : parcours **infixe** (ou **en ordre**) ;
    - Après le parcours de son sous-arbre droit : parcours **postfixe** (ou **suffixe**, ou encore **postordre**).

|Parcours préfixe|Parcours infixe|Parcours postfixe|
|:--|:--|:--|
|1.	Visite du nœud<br>2.Parcours branche gauche<br>3.Parcours branche droite|1.	Visite du nœud<br>2.Parcours branche gauche<br>3.Parcours branche droite|1.Visite du nœud<br>2.Parcours branche gauche<br>3.Parcours branche droite|
|![Exemple de parcours en profondeur préfixe d'un AB](assets/1-ab-dfs-prefixe-light-mode.png#only-light)![Exemple de parcours en profondeur préfixe d'un AB](assets/1-ab-dfs-prefixe-dark-mode.png#only-dark)|![Exemple de parcours en profondeur infixe d'un AB](assets/1-ab-dfs-prefixe-light-mode.png#only-light)![Exemple de parcours en profondeur infixe d'un AB](assets/1-ab-dfs-prefixe-dark-mode.png#only-dark) |![Exemple de parcours en profondeur postfixe d'un AB](assets/1-ab-dfs-prefixe-light-mode.png#only-light)![Exemple de parcours en profondeur postfixe d'un AB](assets/1-ab-dfs-prefixe-dark-mode.png#only-dark)|

=
 	 	 
Les implémentations récursives de ces trois types de parcours en profondeur sont très semblables, seul l'ordre des instructions change. Observons la ligne `print(self.valeur, end='-')`  :

=== "Parcours préfixe"

    ``` py linenums="1"
    class AB :
        def parcours_prefixe(self):
            if self.racine is None: print("l'arbre est vide")
            else: return self.racine.parcours_prefixe()

    class Noeud:
        def parcours_prefixe(self):

            print(self.valeur, end='-')       # on traite le noeud avant son sous-arbre gauche
    
            if self.gauche is not None:  
                self.gauche.parcours_prefixe()

            if self.droite is not None: 
                self.droite.parcours_prefixe()

    >>> arbre.parcours_prefixe()
    5-10-3-6-1-9-4-12-
    ```

=== "Parcours infixe"

    ``` py linenums="1"
    class AB :
        def parcours_infixe(self):
            if self.racine is None: print("l'arbre est vide")
            else: return self.racine.parcours_infixe()

    class Noeud:
        def parcours_infixe(self):

    
            if self.gauche is not None:  
                self.gauche.parcours_infixe()

            print(self.valeur, end='-')       # on traite le noeud entre ses sous-arbre gauche et droit

            if self.droite is not None: 
                self.droite.parcours_infixe()

    >>> arbre.parcours_infixe()
    10-3-5-9-1-4-6-12-
    ```

=== "Parcours postfixe"

    ``` py linenums="1"
    class AB :
        def parcours_postfixe(self):
            if self.racine is None: print("l'arbre est vide")
            else: return self.racine.parcours_postfixe()

    class Noeud:
        def parcours_postfixe(self):

    
            if self.gauche is not None:  
                self.gauche.parcours_postfixe()

            if self.droite is not None: 
                self.droite.parcours_postfixe()

            print(self.valeur, end='-')       # on traite le noeud après son sous-arbre droit

    >>> arbre.parcours_postfixe()
    3-10-9-4-1-12-6-5-
    ```


Noter qu'il est aussi possible d'implémenter le parcours **préfixe** de façon itérative, semblable au parcours en largeur, à la différence qu'on utilise une pile plutôt qu'une file[^1.1].

[^1.1]: 
    ``` py
    class Noeud:
    def parcours_prefixe(self):
        parcours = []
        pile = []
        pile.append(self)
        while len(pile) != 0:   # tant que la pile n'est pas vide
            n = pile.pop()   # on prend le noeud au sommet de la pile
            parcours.append(n.valeur)    # on note sa valeur
            if n.droite is not None: pile.append(n.droite)  #on empile le fils DROIT d'abord
            if n.gauche is not None: pile.append(n.gauche)  #on empile le fils gauche
    ```
## 	Algorithmes sur les arbres binaires de recherche


!!! abstract "Cours" 

    Un **arbre binaire de recherche** (**ABR**) est un cas particulier d'arbre binaire où :

    -	Chaque nœud a une **clé[^1.2]:   supérieure* à celles de tous les nœuds de son **sous-arbre gauche** 
    -	Chaque nœud a une **clé inférieure** à celles de tous les nœuds de son **sous-arbre droit**
    Tous les **sous-arbres sont aussi des ABR**.

[^1.2]: Dans un ABR, l'étiquette est appelée « clé » ou « valeur ».

Note : « supérieur » et   « inférieur » peuvent être au sens strict ou large en fonction de la définition donnée.



On considère l'ABR suivant qui servira comme support pour illustrer la suite :

![Exemple d'ABR](assets/1-abr-light-mode.png#only-light)
![Exemple d'ABR](assets/1-abr-dark-mode.png#only-dark)


La classe `ABR` est une sous classe d'`AB` qui hérite[^1.3]  des méthodes d'un arbre binaire et permet d'ajouter ses propres méthodes.

[^1.3]: L'héritage est un des grands principes de la programmation orientée objet (POO) permettant de créer une nouvelle classe à partir d'une classe existante. La sous-classe hérite des attributs et des méthodes de la classe mère et en ajoute de nouveaux.

``` py
class ABR(AB):
    pass

a = ABR(Noeud(7, Noeud(4, Noeud(2), Noeud(6)), Noeud(11, Noeud(9, Noeud(8), Noeud(10)), Noeud(12))))
```

Les méthodes de la classe AB fonctionnent par héritage, en pârticulier le parcours infixe donne un résultat intéressant :

``` py
>>> a.taille()
9
>>> a.hauteur()
3

>>> a.parcours_infixe()
2-4-6-7-8-9-10-11-12-
```


!!! abstract "Cours" 
    Le **parcours infixe** d'un ABR trie les valeurs des nœuds dans l'ordre croissant.


###	Rechercher une clé


![Exemple de recheche d'une clé dans ABR](assets/1-abr-rechercher-cle-light-mode.png#only-light){width="30%" align=right}
![Exemple de recheche d'une clé dans ABR](assets/1-abr-rechercher-cle-dark-mode.png#only-dark){width="30%" align=right}

Comme son nom l'indique, un ABR est spécifiquement adapté pour rechercher rapidement une clé. On parcourt l'ABR en partant de sa racine, et on observe trois cas :

- 	si la valeur recherchée est plus grande que la valeur du nœud parcouru, on descend à droite ;
-   si la valeur recherchée est plus petite que la valeur du nœud parcouru, on descend à gauche ;
-	si c'est la même, on renvoie le nœud.

Une fois arrivé à une feuille, la clé n'a pas été trouvée. L'exemple ci-contre montre la recherche de la valeur 6 dans l'arbre précédent.

Modifions la classe `ABR`, pour gérer immédiatement le cas de l'arbre vide (la valeur n'est pas trouvée) et appeler une méthode de la classe `Noeud`.

``` py
class ABR(AB):
     def recherche(self, v):
        """ Renvoie True si v est une valeur de l'arbre"""
        if self.racine is None: return False
        return self.racine.recherche(v)
```

Voici ce que cela donne en récursif pour la classe `Noeud` : 

``` py
class Noeud:
    def chercher(self, v):
        if self.valeur == v: return True       # la valeur est trouvée
        if self.valeur > v:      # on regarde à gauche
            if self.gauche is None: 
                return False 
            else: 
                return self.gauche.chercher(v)
        if self.valeur < v:      # on regarde à droite
            if self.droite is None: 
                return False
            else: 
                return self.droite.chercher(v)
```

ou en itératif :
``` py
    def chercher(self, v):
        """ Renvoie le Noeud de valeur v
            None si aucun noeud n'a cette valeur
        """
        n = self.racine
        while n is not None:
            if v > n.valeur:
                n = n.droite
            elif v < n.valeur:
                n = n.gauche
            else:
                return n

```

A chaque appel récursif, ou itération de la boucle `while`, le nombre de nœuds à parcourir est divisé par un facteur 2 (dans un arbre équilibré), on en déduit que la **complexité de la recherche d'une clé est en $O(log_2(n))$**.
 
###	Insérer une clé

!!! abstract "Cours" 
    Lorsqu'on ajoute un nœud à un ABR, on **ajoute toujours une feuille de l'arbre, jamais un nœud interne**.  

![Exemple d'insertion d'une clé dans ABR](assets/1-abr-inserer-cle-light-mode.png#only-light){width="30%" align=right}
![Exemple d'insertion d'une clé dans ABR](assets/1-abr-inserer-cle-dark-mode.png#only-dark){width="30%" align=right}

Il suffit donc de rechercher la feuille dont la clé est la plus proche de celle du nœud à insérer (comme pour l'algorithme de recherche), puis d'ajouter le nœud à gauche si sa clé est inférieure à celle de la feuille, et à droite dans le cas contraire. L'exemple ci-contre montre l'insertion de la valeur 5.

Dans le cas d'un ABR qui n'autorise pas les clés multiples, il faut empêcher l'insertion d'un nœud dont la clé est déjà dans l'arbre. 

Modifions la classe `ABR`, pour gérer immédiatement le cas de l'arbre vide (on ajoute une racine) et appeler une méthode de la classe `Noeud`.

``` py
class ABR(AB):
    def inserer(self, v):
        """ insere la valeur v dans l'arbre"""
        # si l'arbre est vide, on ajoute une racie
        if self.racine is None: 
            self.racine = Noeud(v)
        else:
            self.racine.inserer(v)
```

Voici ce que cela donne en récursif pour la classe `Noeud` : 

``` py
class Noeud:
    def inserer(self,v):
        """insere la valeur v dans l'ABR"""
        if v < self.valeur:
            if self.gauche is None: 
                self.gauche = Noeud(v)    # on ajoute v à gauche
            else: 
                self.gauche.inserer(v)    # on descend à gauche
        if v > self.valeur: 
            if self.droite is None: 
                self.droite = Noeud(v)    # on ajoute v à droite
            else: 
                self.droite.inserer(v)    # on descend à droite
        if v == self.valeur: 
            print(v,"est déjà dans l'ABR")   # la valeur est déjà dans l'ABR
```

ou en itératif :

```py
    def inserer(self, v):
        """ Insère un nouveau Noeud de valeur v dans l'arbre    """
        if self.racine is None:
            self.racine = Noeud(v)
        else:
            n = self.racine
            while n is not None:
                if v < n.valeur:
                    if n.gauche is None:
                        n.gauche = Noeud(v)
                        return
                    n = n.gauche
                elif v > n.valeur:
                    if n.droite is None:
                        n.droite = Noeud(v)
                        return
                    n = n.droite
                else:
                    return # clé déjà dans l'arbre
```

La **complexité de l'insertion d'une clé est en $O(log_2(n))$**.

###	Supprimer une clé (hors programme)

L'opération dépend du nombre de fils du nœud à supprimer.

=== "Cas n°1 : le nœud à supprimer est une feuille"

    -	On cherche le père du nœud à supprimer ;
    -   On supprime le lien père-fils.

    Exemple : suppression du nœud 5

    ![Exemple de suppression d'une feuille dans un ABR](assets/1-abr-supprimer-cle-5-light-mode.png#only-light){width="40%" }
    ![Exemple de suppression d'une feuille dans un ABR](assets/1-abr-supprimer-cle-5-dark-mode.png#only-dark){width="40%" }



    
=== "Cas n°2 : le nœud à supprimer avec un seul fils"

    - On recherche le père du nœud à supprimer ;
    - On redirige le lien père-fils vers le fils (unique) du nœud à supprimer.

    Exemple : suppression du nœud 6

    ![Exemple de suppression d'un noeud avec un seul fils dans un ABR](assets/1-abr-supprimer-cle-6-light-mode.png#only-light){width="40%" }
    ![Exemple de suppression d'un noeud avec un seul fils dans un ABR](assets/1-abr-supprimer-cle-6-dark-mode.png#only-dark){width="40%" }



=== "Cas n°3 : le nœud à supprimer avec deux fils"

    - On recherche le nœud de sa branche de gauche ayant la plus grande valeur, comme c'est le plus grand de cette branche, il n'a pas de fils droit (voir valeur max) ;
    - On rompt le lien père-fils, (comme dans le cas n°2  ;)
    - Et on remplace la valeur du nœud à supprimer par celle du nœud décroché.

    Exemple : suppression du nœud 11

    ![Exemple de suppression d'un noeud avec deux fils dans un ABR](assets/1-abr-supprimer-cle-11-light-mode.png#only-light){width="40%"}
    ![Exemple de suppression d'un noeud avec deux fils dans un ABR](assets/1-abr-supprimer-cle-11-dark-mode.png#only-dark){width="40%"}

    Remarque : alternativement, on peut décrocher le nœud ayant la plus petite valeur de sa branche de droite.


``` py
    def supprimer(self, v):
        """ Supprime le Noeud de valeur v dans l'arbre
            (s'il existe)
        """
        # on recherche le noeud à supprimer n et son pere p
        p= None
        n = self.racine
        while n is not None:
            if v > n.valeur:
                p = n
                n = n.droite
            elif v < n.valeur:
                p = n
                n = n.gauche
            else:
                break
        if n is None: return -1  # la valeur n'existe pas
        fils = 0
        if n.gauche is not None: fils += 1
        if n.droite is not None: fils += 1

        print(fils)
        print(p.valeur)

        if n.gauche is None and n.droite is None:    # n est une feuille
            if p.droite == n: p.droite = None
            else: p.gauche = None
        elif n.gauche is not None and n.droite is None:  # 1 seul fils à gauche
            if p.droite == n: p.droite = n.gauche
            else: p.gauche = n.gauche
        elif n.gauche is  None and n.droite is not None:  # 1 seul fils à droite
            if p.droite == n: p.droite = n.droite
            else: p.gauche = n.droite
        else:               # 2 fils
            # on cherche le max et son père
            max = n.gauche
            p = n
            while max.droite is not None:
                p = max
                max = max.droite
            p.droite = max.gauche     # on rattache la gauche du max à p
            n.valeur = max.valeur     # on remplace la valeur de n par le max

```