# Structures linéaires : Listes

!!! abstract "Cours"
    Une **liste**[^3.1] est une structure abstraite de données constituée d'éléments d'un même type, chacun possédant une position (ou rang) dans la liste. 

    La composition d'une liste change quand de nouveaux éléments sont **ajoutés** à la liste ou des éléments sont **supprimés** de la liste. Une liste peut éventuellement être **vide**.  
    
    Une liste (non vide) est composée de deux parties :

    -	La **tête** (notée *car*[^3.2]), qui est le **dernier élément ajouté** à la liste ;
    -   La **queue** (note *cdr*[^3.3] ), qui contient le reste de la liste, elle-même une liste.

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

La liste est un type abstrait, son implémentation peut se faire sous différentes formes, en particulier les tableaux et les listes chaînées.

:warning: **Attention à ne pas confondre type abstrait de données liste avec le type `list` de Python**. Le type `list` Python est en réalité un **tableau dynamique**, ce n'est qu'une forme d'implémentation particulière de la structure de données abstraite liste mais ce n'est pas la seule.

###	Récursive avec des tuples imbriqués

Une liste peut être implémentée sous la forme :

-	d'un tuple vide `()`, si la liste est vide ; ou sinon
-	d'un couple composé de la tête de la liste et de sa queue : `(car, cdr)`.

Prenons par exemple une liste vide implémentée par le tuple `()`, et insérons l'élément `'a'` en tête, la nouvelle liste obtenue est `('a', ())`, sa tête est `'a'` et sa queue `()`. Insérons maintenant un élément `'b'` dans cette liste, la nouvelle liste obtenue est `('b', ('a', ()))`, sa tête est `'b'` et sa queue `('a', ())`. Puis insérons successivement les éléments `'c'` et `'d'`, la nouvelle liste  est `('d', ('d', ('b', ('a', ()))))`, la tête est `'d'` et la queue `('d', ('b', ('a', ())))`.

Ecrivons en Python ces premières primitives de liste qui permettent de créer une liste vide puis d'insérer un élément en tête de liste :


``` py
def creer():
    return ()  # renvoie une tuple vide

def est_vide(L):
    return L == ()

def inserer_tete(L, e):
    return (e, L)

ma_liste = creer()
ma_liste = inserer_tete(ma_liste, 'a')
ma_liste = inserer_tete(ma_liste, 'b')
ma_liste = inserer_tete(ma_liste, 'c')
ma_liste = inserer_tete(ma_liste, 'd')
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



