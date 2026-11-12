#	Structures linéaires : Piles


!!! abstract "Cours"
    ![Animation sur empiler et dépiler un élement dans une pile](assets/4-empiler-depiler-light-mode.gif#only-light){width="40%" align=right}
    ![Animation sur empiler et dépiler un élement dans une pile](assets/4-empiler-depiler-dark-mode.gif#only-dark){width="40%" align=right}

    En informatique, une **pile** (en anglais ***stack***) est un type abstrait de données sur le principe « dernier arrivé, premier sorti » (ou **LIFO** pour ***Last In, First Out***).

    Le dernier élément ajouté à la pile, ou **empilé**, est le premier qui sera sorti, ou **dépilé**.

    Le dernier élément empilé est le **sommet** de la pile.




Le fonctionnement est donc celui d'une **pile d'assiettes** : on ajoute des assiettes sur la pile, et on les récupère dans l'ordre inverse, en commençant par la dernière ajoutée. 



![Empiler et dépiler un élement dans une pile](assets/4-empiler-depiler-light-mode.png#only-light){width="70%"}
![Empiler et dépiler un élement dans une pile](assets/4-empiler-depiler-dark-mode.png#only-dark){width="70%"}


Les piles trouvent de nombreuses applications en informatique, par exemple :

-   Dans un navigateur web, une pile sert à mémoriser les pages Web visitées. L'adresse de chaque nouvelle page visitée est empilée et l'utilisateur dépile l'adresse de la page précédente en cliquant le bouton « Afficher la page précédente ».

-   La fonction « Annuler la frappe » (en anglais « Undo ») d'un traitement de texte mémorise les modifications apportées au texte dans une pile.


##	Interface

Les principales primitives constituant l'interface d'une pile sont :


- `creer() → pile` : construire une pile vide.
- `est_vide() → bool` : vérifier si une pile est vide ou non.
- `empiler(element)` : ajouter un élément sur la pile (*Push* en anglais).
- `dépiler() → element` : enlèver un élément de la pile et le renvoyer (*Pop* en anglais).
- `taille() → int` : renvoyer le nombre d'éléments dans la pile (la hauteur).

Exemple :

Soit une pile `P` composée des éléments suivants : 12, 14, 8, 7, 19 et 22 (le sommet de la pile est 22). Pour chaque exemple ci-dessous on repart de la pile d'origine :

-	`dépiler(P)` renvoie 22 et la pile `P` est maintenant composée des éléments suivants : 12, 14, 8, 7 et 19 (le sommet de `P` est 19).
-	`empiler(P, 42)` la pile `P` est maintenant composée des éléments suivants : 12, 14, 8, 7, 19, 22 et 42
-	si on applique `dépiler(P)` 6 fois de suite, `est_vide(P)` renvoie vrai.
-	après avoir appliqué `dépiler(P)` une fois, `taille(P)` renvoie 5.

##	Implémentation 

La pile est un type abstrait, son implémentation peut se faire sous différentes formes, par exemple avec une liste chaînée ou un tableau dynamique de type `list` Python.

###	Avec une liste chaînée

Sur la même idée que les classes  `Maillon` et  `ListeChainee` vues précédemment, il est possible d'implémenter un pile avec deux classes `Cellule` et  `Pile`.


``` py
class Cellule:
    '''Cellule de Pile '''

    def __init__(self, valeur, dessous=None):
        self.valeur = v      # Valeur de la Cellule
        self.dessous = d     #  None ou la cellule de dessous

class Pile:
    '''Pile sous forme d'une liste chainee de cellules'''

    def __init__(self):
        """ Crée une pile vide"""
        self.sommet = None

    def est_vide(self):
        """Renvoie True si la liste est vide, False sinon"""
        return self.sommet == None

    def empiler(self, x):
        """Empile la valeur x au sommet de la pile"""
        self.sommet = Cellule(x, self.sommet)
        

    def depiler(self):
        """Depile le sommet et renvoie la valeur"""
        if self.est_vide(): 
            raise IndexError("la pile est vide")
        v = self.sommet.valeur
        self.sommet = self.sommet.dessous
        return v
```



![Pile c, b, a en POO avec deux classes](assets/4-pile-light-mode.png#only-light){width="40%" align=right}
![Pile c, b, a en POO avec deux classes](assets/4-pile-light-mode.png#only-dark){width="40%" align=right}

Créons maintenant une instance de `Pile` :

``` py
>>> p = Pile()
>>> p.est_vide()
True
>>> p.empiler('a')
>>> p.empiler('b')
>>> p.empiler('c')
```

Puis dépilons le sommet :

``` py
>>> p.depiler()
'c'
```



On peut maintenant ajouter une méthode `taille(self)` qui parcourt la pile pour calculer son nombre d'éléments : 

``` py
    def taille(self):
        """ Renvoie le nombre d'éléments de la pile"""
        compteur = 0
        actuel = self.sommet   # On commence au sommet
        while actuel is not None:
            compteur += 1
            actuel = actuel.dessous  # On passe à l'élément en dessous
        return compteur
```
Il faut parcourir tous les éléments de la pile, la complexité est en \(\mathcal{O}(n)\).



Souvent, il est nécessaire de créer une pile temporaire pour dépiler les éléments, puis les rempiler dans la pile initiale en gardant l'ordre du début. Par exemple, pour supprimer toutes les valeurs `a` de la pile `p`, on peut écrire le programme suivant :

``` py
temp = Pile()
# on depile toutes les valeurs p
while not p.est_vide():
    v = p.depiler()
    # si la valeur n'est pas égale à 'a', on la garde en l'empilant dans temp
    if v != 'a':     
        temp.empiler()
# on rempile toutes les valeurs de temp dans p
while not temp.est_vide():
    p.empiler(temp.depiler())
```

Pour aller plus loin,  il est possible de définir des méthodes pour vérifier la présence d'une valeur dans la pile, trier une pile, concaténer deux piles, etc. 



###	Avec le type `list` de Python

Il est aussi possible de créer très facilement une classe `Pile` en utilisant le type `list` de Python avec les méthodes `pop()` et `append()` :

``` py
class Pile:
    ''' structure de Pile en utilisant le type list'''

    def __init__(self):
        self.P = []

    def est_vide(self):
        return len(self.P) == 0

    def empiler(self, v):
        self.P.append(v)

    def depiler(self):
        if self.est_vide(): raise IndexError("la pile est vide")
        return self.P.pop()

    def taille(self):
        return len(self.P)

    def __str__(self):
        ch = ''
        for v in self.P:
            ch = ch + "|\t" + str(v) + "\t|\n"   # Affiche les éléments de la pile : |  v  |
        ch = ch + "---------"
        return ch
```

Créons maintenant une instance de `Pile` :

``` py
>>> p = Pile()
>>> p.est_vide()
True
>>> p.depiler()
Traceback (most recent call last):
  File "<interactive input>", line 1, in <module>
  File "<module1>", line 15, in depiler
IndexError: la pile est vide
>>> p.empiler('a')
>>> p.empiler('b')
>>> p.empiler('c')
>>> p.est_vide()
False
>>> p.depiler()
'c''
>>>
```

Enregistrons cette classe de `Pile` dans un fichier "pile.py", elle nous sera utile par la suite.


Pour faire encore plus simple, programmons une pile avec la même idée, mais sans utiliser la POO : 

``` py
def creer():
    return  []

def est_vide(P):
    return len(P) == 0

def empiler(P, v):
    P.append(v)         # Inutile de renvoyer P, le type list est muable

def depiler(P):
    if est_vide(P):
        raise IndexError("la pile est vide")
    return P.pop()

def taille(P):
    return len(P)

def afficher(P):
    for v in P:
        print("|\t", v, "\t|\n")   # Affiche les éléments de la pile : |  v  |
    print("---------")
        
```
puis

``` py
>>> p = creer()
>>> est_vide(p)
True
>>> depiler(p)
Traceback (most recent call last):
  File "<interactive input>", line 1, in <module>
  File "<module1>", line 11, in depiler
IndexError: la pile est vide
>>> empiler(p, 'a')
>>> empiler(p, 'b')
>>> empiler(p, 'c')
>>> depiler(p)
'c'
>>> taille(p)
2
```

Finalement en Python, une simple variable de type `list` avec la fonction `len()` et les méthodes `.append()` et `.pop()` est une façon rapide et simple de créer une pile avec toutes ses primitives : 
``` py
>>> p = []           # creer()
>>> len(p) == 0      # est_vide()
True
>>> p.append('a')    # empiler()
>>> p.append('b')    # empiler()
>>> p.append('c')    # empiler()
>>> len(p)           # taille()
3
>>> p.pop()          # depiler()
'c'
```