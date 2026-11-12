# Structures linéaires : Listes

!!! abstract "Cours"
    Une **liste**[^3.1] est une structure abstraite de données constituée d'éléments d'un même type, chacun possédant une position (ou rang) dans la liste. 

    La composition d'une liste change quand de nouveaux éléments sont **ajoutés** à la liste ou des éléments sont **supprimés** de la liste. Une liste peut éventuellement être **vide**.  
    
    Une liste (non vide) est composée de deux parties :

    -	La **tête** (parfois appelée *car*[^3.2]), qui est le **dernier élément ajouté** à la liste ;
    -   La **queue** (parfois appelée *cdr*[^3.3] ), qui contient le reste de la liste, elle-même une liste.

    La **longueur** de la liste est le nombre d'éléments composant la liste. Une liste vide a une longueur zéro.


Notons ici le caractère récursif de cette définition où la queue d'une liste est elle-même une liste ! 


[^3.1]: Le langage de programmation Lisp (inventé par John McCarthy en 1958) a été un des premiers langages de programmation à introduire cette notion de liste (Lisp signifie "list processing").

[^3.2]: *contents of address register*
[^3.3]: *contents of decrement register*



## Interface 

Les principales primitives constituant l'interface d'une liste sont :

-	`creer() → liste` : construire une liste vide.
-	`est_vide() → bool` : vérifier si une liste est vide ou non.
-	`inserer_tete(element)` : insérer un élément en tête de la la liste.
-	`supprimer_tete() →  element` : supprimer l'élément de tête.
-	`taille() → int` : renvoyer le nombre d'éléments de la liste.
-	`tete() →  element` : lire le premier élément (la tête) de la liste.
-	`queue() → liste` : accéder au reste de la liste (la queue).

Il est possible d'ajouter quelques primitives supplémentaires, par exemple :

-   `insérer(element, i)` : insérer un élément en ième position de la liste.
-   `lire(i) → element` : accéder au ième élément de la liste (*get*).


##	Implémentation

La liste est un type abstrait, son implémentation peut se faire sous de nombreuses formes, par exemple avec des p-uplets imbriqués, en utilisant un tableau ou une liste chaînée.

:warning: **Attention à ne pas confondre type abstrait de données liste avec le type `list` de Python**. Le type `list` Python est en réalité un **tableau dynamique**, ce n'est qu'une forme d'implémentation particulière de la structure de données abstraite liste mais ce n'est pas la seule.

###	Récursive avec des tuples imbriqués

Une liste peut être implémentée sous la forme :

-	d'un tuple vide `()`, si la liste est vide ; ou sinon
-	d'un couple composé de la tête de la liste et de sa queue : `(car, cdr)`.

Prenons par exemple une liste vide implémentée par le tuple `()`, et insérons l'élément `'a'` en tête, la nouvelle liste obtenue est `('a', ())`, sa tête est `'a'` et sa queue `()`. Insérons maintenant un élément `'b'` dans cette liste, la nouvelle liste obtenue est `('b', ('a', ()))`, sa tête est `'b'` et sa queue `('a', ())`. Puis insérons successivement les éléments `'c'` et `'d'`, la nouvelle liste  est `('d', ('d', ('b', ('a', ()))))`, la tête est `'d'` et la queue `('d', ('b', ('a', ())))`.

Écrivons en Python ces premières primitives de liste qui permettent de créer une liste vide puis d'insérer un élément en tête de liste :


``` py
def creer():
    return ()  # renvoie une tuple vide

def est_vide(L):
    return L == ()

def inserer_tete(L, x):
    return (x, L)

l = creer()
l = inserer_tete(l, 'a')
l = inserer_tete(l, 'b')
l = inserer_tete(l, 'c')
l = inserer_tete(l, 'd')
```

Ajoutons quelques primitives supplémentaires :

``` py
def tete(L):
    return L[0]

def queue(L):
    return L[1]
```

La taille de la liste est calculée de façon récursive :

``` py
def taille(L):
    if est_vide(L):
        return 0
    else:
        return 1 + taille(queue(L))
```

L'affichage est aussi récursif :

``` py
def afficher(L):
    if est_vide(L):
        print('')     
    else:
        print(tete(L), end=' - ' ) 
        afficher(queue(L))
```

ainsi que la recherche d'un élément dans la liste :

``` py
def chercher(L, elem):
    if est_vide(L):
        return False 
    elif tete(L) == elem:
        return True 
    else:
        return chercher(queue(L) , elem) 
```


Pour aller plus loin, il est aussi possible d'écrire en programmation orientée objet une classe `Liste` avec des méthodes similaire.


###	Avec un tableau de taille fixe

Un **tableau** informatique est en général représenté par une suite de "cases mémoire", toutes de mêmes tailles, contenant les différents éléments du tableau.  Une plage d'adresses mémoire est réservée afin de stocker tous les éléments.

![Cases mémoire d'un tableau](assets/3-liste-tableau-cases-memoire-light-mode.png#only-light){width="50%"}
![Cases mémoire d'un tableau](assets/3-liste-tableau-cases-memoire-dark-mode.png#only-dark){width="50%"}

Cette représentation présente deux avantages :

-	pour un tableau sans case vide, elle est très compacte, puisqu'elle se contente de stocker les données ;

-	l'accès un élément du tableau par son $indice$ s'effectue relativement rapidement en temps constant. Son  adresse se calcule facilement:
    $adresseElement = adresseTableau + indice \times  tailleCase$

Implémentons en Python une liste sous forme d'un tableau de taille fixe $n + 1$ en utilisant une variable de type `list` :

-   la première case du tableau contient le nombre d'éléments de la liste ;
-	les cases suivantes (d'indice `1` à `n`) contiennent les éléments de la liste ou `None`.

Exemple : une liste de taille 5 avec les éléments `'c'`, `'b'`, `'a'`  se présentera sous la forme  `[3, 'c', 'b', 'a', None, None]`.

Créons l'interface d'une telle liste :

``` py
def creer_liste(longueur):
    L = [None] * (longueur + 1)
    L[0] = 0
    return L
```

La primitive pour insérer un élément en tête de liste est alors :

``` py
def inserer_tete(L, x):
    # Vérifions si la liste est pleine
    if L[0] == len(L) - 1: 
        raise IndexError('La liste est déjà pleine')
    else:
        for i in range(L[0], 0, -1):
            L[i + 1] = L[i]
        L[1] = x
        L[0] += 1
```

A noter qu'il est inutile de renvoyer la valeur de `L` car c'est une variable de type `list`, donc muable.

``` py
>>> l =  creer_liste(4)
>>> inserer_tete(l, 'a')
>>> inserer_tete(l, 'b')
>>> inserer_tete(l, 'c')
```

Une fonction pour afficher la liste s'écrit :

``` py
def afficher(L):
    for i in range(1, L[0] + 1):
        print(L[i], end="-")
    print("")
```

Ajoutons une primitive permettant de supprimer la tête de la liste :

``` py
def supprimer_tete(L):
    # Vérifions d'abord que la liste n'est pas vide
    if L[0] == 0: 
        raise IndexError('La liste est déjà vide')
    else:
        for i in range(1, L[0] ):
            L[i]= L[i + 1]
        L[L[0]] = None
        L[0] -= 1
```

Testons le résultat :

``` py
>>> l = creer_liste(5)
>>> inserer_tete(l, 'a')
>>> inserer_tete(l, 'b')
>>> inserer_tete(l, 'c')
>>> inserer_tete(l, 'd')
>>> inserer_tete(l, 'e')
>>> afficher(l)
>>> supprimer_tete(l)
>>> supprimer_tete(l)
>>> supprimer_tete(l)
>>> afficher(l)
```

Il est aussi possible de rajouter quelques primitives pour :

-	accéder au i-ème élément de la liste (*get*) ; 
-	insérer un élément en tête d'une liste ;
- 	insérer un élément en i-ème position ;
-	etc.

Pour aller plus loin, il est aussi possible d'écrire en programmation orientée objet une classe `Liste` avec des méthodes similaire.

###  Avec le type `list` de Python

Dans de nombreux langages informatiques, un tableau est une structure de données de taille fixe[^3.4]. Pour insérer des données supplémentaires, il faut créer un nouveau tableau plus grand et déplacer les éléments du premier tableau vers le second tout en ajoutant la donnée au bon endroit.  

C'est la notion de **tableau dynamique**, c'est à dire un tableau dont la taille peut varier. 

[^3.4]:
    Par exemple pour déclarer un tableau `myNumbers` de 4 entiers en C, il faut écrire `int myNumbers[4];`.

!!! abstract "Cours"
    En Python le **type `list`** est un **tableau dynamique**. C'est une forme d'implémentation particulière de la structure de données abstraite 
	de liste. :warning: Attention de ne pas confondre les deux termes.

Le type `list` en Python offre toutes les primitives de base d'une liste :

``` py
>>> l = []       # creer une liste 
>>> l == []       # est_vide()
True
>>> l.insert(0, 'a')         # inserer_tete()
>>> l.insert(0, 'b')         # inserer_tete()
>>> l.insert(0, 'c')         # inserer_tete()
>>> l.insert(0, 'd')         # inserer_tete()
>>> l.insert(0, 'e')         # inserer_tete()
>>> len(l)       # taille()
5
>>> l.pop(0)       # supprimer_tete()
'e'
>>> l[0]       # tete()
'd'
>>> l[1:]       # queue()
['c', 'b', 'a']
```

Notons qu'ici la tête est à la première position de `l`. 

Le type `list` Python propose bien d'autres opérateurs qu'une simple liste : extraction d'une sous-liste (`l[debut:fin]`), remplacement d'un élément (`l[i] = nouvelle_valeur`), tri (`l.sort()`), retournement (`l.reverse()`), suppression d'un élément (`l.pop(i)`), application d'une fonction (`map(fonction, l`), etc. Néanmoins, s'il peut sembler la solution miracle à de nombreux besoins, les tableaux dynamiques ne sont pas efficaces pour insérer ou supprimer un élément en plein milieu du tableau.

![Insérer un élément dans un tableau de type list Python](assets/3-inserer-tableau-list-python-light-mode.png#only-light){width="25%" align=right}
![Insérer un élément dans un tableau de type list Python](assets/3-inserer-tableau-list-python-dark-mode.png#only-dark){width="25%" align=right}

Par exemple, lorsqu'une nouvelle valeur `'e'` est insérée en tête d'une liste `['d', 'c', 'b', 'a']`, c'est-à-dire à la première position du tableau Python, avec la méthode `insert()` :

``` py
>>> l
['d', 'c', 'b', 'a']
>>> l.insert(0, 'e')
>>> l
['e', 'd', 'c', 'b', 'a']
```

C'est une opération qui est en réalité très coûteuse, car elle consiste à :

1. agrandir le tableau ; 
2. déplacer tous les éléments du tableau d'une case vers la droite, en commençant par la fin ; 
3. et enfin écrire la valeur `'e'` dans la première case.

C'est donc la même chose que d'écrire :

``` py
>>> l = ['d, 'c', 'b', 'a']
>>> l.append(None)
>>> for i in range(len(l) - 1, 0, -1):
...     l[i] = l[i - 1]
>>> l[0] = 'e'
>>> l
['e', 'd', 'b', 'c', 'a']
```

Le nombre d'opérations est proportionnel à la taille du tableau. Ajouter ou supprimer le premier élément d'un tableau d'un million d'éléments nécessite près d'un million d'opérations. C'est une complexité en $O(n)$ [^3.5].

[^3.5]: 
    Le coût d'insertion d'un élément en début de tableau est proportionnel à la taille du tableau, ce qui peut être observé avec le module `time`: 
    ``` py
    import time

    l = [i for i in range (100000)]  
    start = time.time()
    for i in range(100):
        l.insert(0, 0)
    end = time.time()
    print((end - start) / 1000)
    ```
    Pour en savoir plus sur le coût des opérations sur les listes : [https://wiki.python.org/moin/TimeComplexity](https://wiki.python.org/moin/TimeComplexity)


Le choix d'implémentation qui a été fait ici de placer la tête de liste en position 0 d'un tableau Python suis les implémentations précédentes, il aurait été judicieux d'inverser l'ordre de la liste dans le tableau et d'utiliser `l.append('a')` et `l.pop()` pour `inserer_tete` et `supprimer_tete`.


### Avec une liste chaînée 

Dans une liste chaînée, les éléments ne sont pas stockés côte à côte en mémoire comme dans un tableau, mais disséminés à différents endroits. les éléments de liste sont appelés des **maillons**, ou **cellules**, ou encore **Nœuds**.  Pour lier ces maillons entre eux, chaque maillon contient deux informations[^3.6] :

-   une valeur (la donnée stockée) ;
- 	un **pointeur** (ou référence) sur le maillon suivant. 

[^3.6]: Dans certains cas, on trouve aussi un pointeur vers le maillon précédent pour créer une liste doublement chaînées.

Notons que le dernier maillon n'a pas de maillon suivant.


Exemple de la liste `'c'`, `'b'`, `'a'` :

![Liste chaînée c, b, a](assets/3-liste-chainee-1-light-mode.png#only-light){width="80%"}
![Liste chaînée c, b, a](assets/3-liste-chainee-1-dark-mode.png#only-dark){width="80%"}


Les listes chaînées sont particulièrement efficace pour supprimer ou insérer un élément de la liste. 

Par exemple, pour supprimer l'élément `'b'` de la liste `'c'`, `'b'`, `'a'`, il suffit de remplacer le suivant de `'c'` par `'a'` au lieu de  `'b'` :

![Liste chaînée c, z, b, a](assets/3-liste-chainee-2-light-mode.png#only-light){width="80%"}
![Liste chaînée c, z, b, a](assets/3-liste-chainee-2-dark-mode.png#only-dark){width="80%"}

De même, pour insérer un élément `'z'` entre `'b'`, `'a'` dans la liste `'c'`, `'b'`, `'a'`, il suffit de créer un nouveau maillon `'z'` dont le suivant `'a'` et de remplacer le suivant de `'b'` par ce nouveau maillon :

![Liste chaînée c, z, b, a](assets/3-liste-chainee-3-light-mode.png#only-light){width="80%"}
![Liste chaînée c, z, b, a](assets/3-liste-chainee-3-dark-mode.png#only-dark){width="80%"}


En revanche, les listes chaînées présentent deux inconvénients :

- elles prennent beaucoup de place, puisqu'il faut rajouter un pointeur pour chaque élément ;

- l'accès à un élément est relativement long et est proportionnel à l'indice de l'élément, puisqu'il faut parcourir la liste depuis le début (ou la fin) pour atteindre l'élément voulu.


Implémentons une telle liste chaînée en programmation orientée objet.

Commençons par la classe d'objets `Maillon` dont les instances ont deux attributs `valeur` et `suivant` qui pointe sur le maillon suivant ou sur `None` pour la dernier maillon de la liste.

``` py
class Maillon:
    ''' Un maillon de liste chaînée
    '''

    def __init__(self, valeur, suivant):
        self.valeur = valeur     # la donnée stockée
        self.suivant = suivant   # référence au maillon suivant ou None
```

Il est déjà possible de construire les premier maillons de la liste `'c'`, `'b'`, `'a'` :

``` py
>>> a = Maillon('a', None)
>>> b = Maillon('b', a)
>>> c = Maillon('c', b)
```

ou même directement toute la liste :

``` py
>>> l = Maillon('c', Maillon('b', Maillon('a', None)))
```

Bien sûr, on pourrait se contenter de cette structure de plusieurs objets `Maillon` liés les uns aux autres et construire les primitives d'une liste : lire la tête (`l.valeur`), obtenir la queue (`l.suivant`), etc. Mais elle montre certaines limites, par exemple elle ne permet pas de créer une liste vide. Habituellement, on ajoute une classe `ListeChainee` avec un attribut `tete` qui peut prendre les valeurs :

- `None` si la liste est vide ; ou 
-  une instance de `Maillon` qui est la tête de la liste.


``` py
class ListeChainee:
    ''' Liste chaînée    '''

    def __init__(self):
        """Crée une liste vide"""
        self.tete = None    # None ou le Maillon de tête
```

![Liste chaînée vide en POO](assets/3-liste-chainee-4-light-mode.png#only-light){width="20%" align=right}
![Liste chaînée vide en POO](assets/3-liste-chainee-4-dark-mode.png#only-dark){width="20%" align=right}

Créons une liste chaînée vide :

``` py
>>> l = ListeChainee()
```

Ajoutons immédiatement la première primitive qui vérifie si une liste est vide ou non :

``` py
    def est_vide(self):
        """Renvoie True si la liste est vide, False sinon"""
        return self.tete is None
```

... et une primitive pour insérer un premier `Maillon` en tête de liste :

``` py
    def inserer_tete(self, x):
        """Insère l'élément x au début de la liste"""
        # On crée un nouveau maillon dont le suivant est l'ancienne tête
        nouveau = Maillon(x, self.tete)
        # La nouvelle tête devient ce nouveau maillon
        self.tete = nouveau
```

Comme attendu, la liste n'est plus vide quand on insère un premier élément : 

``` py
>>> l.inserer_tete('a')
>>> l.est_vide()
False
```

Ajoutons deux autres éléments à cette liste :

``` py 
>>> l.inserer_tete('b')
>>> l.inserer_tete('c')
```


![Liste chaînée c, b, a en POO avec deux classes](assets/3-liste-chainee-5-light-mode.png#only-light){width="80%"}
![Liste chaînée c, b, a en POO avec deux classes](assets/3-liste-chainee-5-dark-mode.png#only-dark){width="80%"}

Ajoutons maintenant quelques primitives utiles. 

Pour connaître la taille, il n'y a pas de raccourci : il faut démarrer à la tête et compter les maillons suivants les uns après les autres jusqu'à arriver à `None`.

``` python
    def taille(self):
        """ Renvoie le nombre d'éléments de la liste"""
        compteur = 0
        actuel = self.tete   # On commence à la tête
        while actuel is not None:
            compteur += 1
            actuel = actuel.suivant  # On passe au maillon suivant
        return compteur
```



![Taille d'une liste chaînée c, b, a en POO](assets/3-liste-chainee-6-light-mode.png#only-light){width="80%"}
![Taille d'une liste chaînée c, b, a en POO](assets/3-liste-chainee-6-dark-mode.png#only-dark){width="80%"}


Il faut parcourir tous les éléments de la liste, la complexité est en \(\mathcal{O}(n)\).


De la même façon, la méthode `__str__()` permet d'afficher toute la liste avec `print()` en parcourant toute la liste :

``` py
    def __str__(self):
        """Affiche les éléments avec print"""
        affichage = ""
        actuel = self.tete   # On commence à la tête
        while actuel is not None:
            affichage = affichage + str(actuel.valeur) + "-"
            actuel = actuel.suivant   # On passe au maillon suivant
        return affichage
```
Les éléments sont affichés simplement avec la fonction `print()` : 
```
>>> print(l)
c-b-a-
```


On peut faire de même pour trouver l'élément en position `n` dans la liste :

``` python
    def get(self, n):
        position = 0
        actuel = self.tete   # On commence à la tête
        while actuel is not None:
            if position == n:
                return actuel
            position += 1
            actuel = actuel.suivant    # On passe au maillon suivant
        raise IndexError("Index hors limite")
``` 


En moyenne, s'il est immédiat de trouver l'élément de tête, il faut $n$ opérations pour trouver le dernier élément dans une liste de longueur $n$, donc en moyenne $n/2$, la complexité est en $O(n)$ ce qui est très coûteux en comparaison d'un tableau dynamique.  



Complétons l'interface avec une primitive pour insérer un élément en position `n`, (comme l'élément `'z'` entre `'b'` et `'a'` dans l'exemple précédant) :

``` py
        """Insérer la valeur x en position n."""
        # Cas de l'insertion en tête 
        if n == 0:
            self.tete = Maillon(x, self.tete)
        # Autres cas
        else:
            position = 1
            actuel = self.tete   # On commence à la tête
            while position < n and actuel is not None:
                position += 1
                actuel = actuel.suivant    # On passe au maillon suivant
            if actuel is None:
                raise IndexError("Index hors limite")
            else:
                actuel.suivant = Maillon(x, actuel.suivant)
```

En moyenne, comme pour la recherche , un élément est ajouté immédiatement en tête de liste, et après $n$ opérations en dernière position dans une liste de longueur $n$, donc en moyenne après $n/2$ opérations. La complexité est en \(\mathcal{O}(n)\) est comparable au tableau dynamique, mais le nombre d'écritures est grandement réduit.

Pour aller plus loin,  il est possible de définir une méthode pour supprimer l'élément en position `n`, vérifier la présence d'une valeur dans la liste, trier une liste, concaténer deux listes, etc.

Noter que cette implémentation crée une liste muable, comme le type `list` Python.



### Comparaison : Liste Chaînée vs Tableau dynamique

Les tableaux dynamique Python (type `list`) sont très puissants et facile à utiliser. Mais ce n'est pas toujours l'implémentation d'une liste la plus adaptée. Comparons la complexité temporelle d'un tableau dynamique avec une liste chaînée.

|Opération|	Tableau Dynamique (`list` Python)|	Liste Chaînée|
|:-|:-|:-|
|Accès à un élément par son index|	\(\mathcal{O}(1)\) (Instantané)	|\(\mathcal{O}(n)\) (Il faut parcourir la liste depuis le début)|
|Insertion / Suppression en TÊTE	|\(\mathcal{O}(n)\) (Il faut décaler tous les éléments)	|\(\mathcal{O}(1)\) (Instantané)|
|Insertion / Suppression en FIN	|\(\mathcal{O}(1)\) (Instantané)|	\(\mathcal{O}(n)\) |
|Rechercher une valeur	|\(\mathcal{O}(n)\) |	\(\mathcal{O}(n)\)  |

La liste chaînée est extrêmement efficace pour insérer ou supprimer des éléments au début sans rien déplacer en mémoire, mais elle est lente pour accéder à un élément précis au milieu (pas d'accès direct/indexé).