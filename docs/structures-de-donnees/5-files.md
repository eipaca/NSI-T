#	Structures linéaires : Files 


!!! abstract "Cours"
    ![Animation sur enfiler et défiler un élement dans une file](assets/5-enfiler-defiler-light-mode.gif#only-light){width="45%" align=right}

    ![Animation sur enfiler et défiler un élement dans une file](assets/5-enfiler-defiler-dark-mode.gif#only-dark){width="45%" align=right}


    En informatique, une **file** (en anglais ***queue***) est un type abstrait de données sur le principe « dernier arrivé, premier sorti » (ou **FIFO** pour ***First In, First Out***).

    Le premier élément ajouté à la file, ou **enfilé**, est le premier qui sera sorti, ou **défilé**.

    Le premier élément enfilé est en **sortie** de la file, le dernier est en **entrée**.



Le fonctionnement est celui d'une **file d'attente** : les premières personnes qui arrivent dans la file sont ensuite les premières qui en sortiront. 

![Enfiler et défiler un élement dans une file](assets/5-enfiler-defiler-light-mode.png#only-light){width="70%"}
![Enfiler et défiler un élement dans une file](assets/5-enfiler-defiler-dark-mode.png#only-dark){width="70%"}


Ici aussi, les files trouvent de nombreuses applications en informatique pour mémoriser temporairement des transactions qui doivent attendre pour être traitées, par exemple :

-	Les imprimantes qui traitent les demandes dans l'ordre dans lequel elles arrivent, et les insèrent dans une file d'attente.

-	L'ordonnanceur d'un système d'exploitation qui accorde du temps machine à chaque processus dans l'ordre où il arrive, sans en privilégier aucun.



## Interface

Les principales primitives constitant l'interface d'une file sont :

- `creer() → file` : construire d'une file vide.
- `est_vide() → bool` : vérifier si une file est vide ou non.
- `enfiler(element)` : ajouter un élément sur la file (*enqueue* en anglais).
- `défiler() → element` : enlèver un élément de la file et le renvoier (*dequeue* en anglais).
- `taille() → int` : renvoyer le nombre d'éléments dans la file.

Exemples :

Soit une file `F` composée des éléments suivants : 12, 14, 8, 7, 19 et 22 (le premier élément rentré dans la file est 22 ; le dernier élément rentré dans la file est 12). Pour chaque exemple ci-dessous on repart de la file d'origine :

-	`enfiler(F,42)` la file `F` est maintenant composée des éléments suivants : 42, 12, 14, 8, 7, 19 et 22 (le premier élément rentré dans la file est 22 ; le dernier élément rentré dans la file est 42)

-	`défiler(F)` la file F est maintenant composée des éléments suivants : 12, 14, 8, 7, et 19 (le premier élément rentré dans la file est 19 ; le dernier élément rentré dans la file est 12)

-	si on applique `défiler(F)` 6 fois de suite, `est_vide(F)` renvoie vrai.

-	après avoir appliqué `défiler(F)` une fois, `taille(F)` renvoie 5.


## Implémentation

###	avec le type `list` de Python

La liste est un type abstrait, son implémentation peut se faire sous différentes formes, par exemple en reprenant l'implémentation d'une Pile avec une variable de type `list` il suffit de modifier `pop()` en `pop(0)` pour écrire la méthode `defiler()`.

``` py
    def defiler(self):
        if self.est_vide(): raise IndexError("la file est vide")
        return self.pile.pop(0)
```

###	avec deux piles

Ici on propose une autre approche, en utilisant deux piles, une pile 'entrante' et une 'sortante'. Il faut séparer plusieurs cas :

-   Enfiler : Chaque fois qu'un nouvel élément est enfilé dans la file, il est empilé dans la pile entrante. 

-   Défiler quand la pile sortante est vide : si la pile sortante est vide

    -1. il faut d'abord dépiler tous les éléments de la pile entrante pour les empiler dans la pile sortante ; puis
    -2. il faut ensuite dépiler depuis la pile sortante.

-   Défiler quand la pile sortante n’est pas vide : la pile sortante est dépilé normalement.


Pour transcrire ce fonctionnement en Python, commençons par importer le module `pile` (dans un nouveau fichier enregistré dans le même répertoire que "pile.py").  
``` py
import pile
```
Les objets des classes `Cellule` et `Pile` peuvent maintenant être utilisés :
``` py
c = pile.Cellule('a', None)
p = pile.Pile()
```

Créons nos deux piles :
``` py
import pile

class File:
    ''' File sous forme de deux Piles
    '''
    def __init__(self):
        self.entrante = pile.Pile()
        self.sortante = pile.Pile()
```

Il est déjà possible d'ajouter une méthode `est_vide` quand les deux piles sont vides :
``` py
    def est_vide(self):
        return self.entrante.est_vide() and self.sortante.est_vide()


>>> f=File()
>>> f.est_vide()
True
```

Pour enfiler un élément dans la file, il suffit de l’ajouter à la pile entrante :

``` py

    def enfiler(self, v):
        self.entrante.empiler(v)


>>> f=File()
>>> f.est_vide()
True
>>> f.enfiler('a')
>>> f.est_vide()
False
```

mais pour défiler, il faut gérer les deux cas :

``` py
    def defiler(self):
        if self.est_vide():
            raise IndexError ("La file est vide")
        if self.sortante.est_vide():
            # on depile TOUTE la pile entrante dans la sortante
            while not self.entrante.est_vide():
                self.sortante.empiler(self.entrante.depiler())
        return self.sortante.depiler()

>>> f=File()
>>> f.enfiler('a')
>>> f.enfiler('b')
>>> f.enfiler('c')
>>> f.defiler()
'a'
``` 

