# Méthode « diviser pour régner »

!!! abstract "Cours" 

    La méthode « **diviser pour régner** » consiste à découper un problème en sous-problèmes similaires de plus en plus petits jusqu'à obtenir des cas simples permettant une résolution directe. Elle consiste en trois étapes :  
    
    1.	**Diviser** : découper un problème initial de **taille n** en **sous-problèmes indépendants de taille n/2** (ou une fraction de n);
    2.	**Régner** : résoudre les sous-problèmes (récursivement ou directement s'ils sont assez petits) ;
    3.	**Combiner** : calculer une solution au problème initial à partir des solutions des sous-problèmes.

    Cette méthode tire souvent avantage de la **récursivité**.  Le **faible coût** des algorithmes diviser pour régner est l'un de leurs principaux intérêts.


Cette technique fournit des algorithmes efficaces pour de nombreux problèmes, comme la recherche dichotomique d'un élément dans un tableau trié, le tri fusion, la multiplication de grands nombres (algorithme de Karatsuba), etc.

##	Recherche dichotomique dans un tableau trié

Considérons un algorithme naïf de recherche dans un tableau en parcourant tous les éléments du tableau :

``` py
def recherche(x, T):
    for elt in T:
        if x == elt: return True
    return False
```

Dans le pire des cas (x n'est pas dans le tableau), l'algorithme parcourt l'ensemble du tableau, le coût est donc en $O(n)$.

Le principe de la **recherche dichotomique dans un tableau trié** est celui suivi naturellement par les enfants quand ils jouent à un jeu bien connu. Le but du jeu est de découvrir un nombre secret compris entre 0 et 100 en un minimum d'essais. A chaque proposition on lui répond s'il a trouvé ou si le nombre secret est plus petit ou plus grand. La meilleure technique consiste à proposer un nombre au milieu de 0 et 100, c'est-à-dire 50. Si on lui répond « gagné », il a eu de la chance et il a trouvé le nombre secret imméditement. Si on lui répond « perdu, c'est plus » alors il sait que le nombre secret est entre 51 et 100, il va donc proposer le milieu, c'est-à-dire 75. Si la réponse est « perdu, c'est moins » alors le nombre secret est entre 0 et 49, il va proposer 25. Il va continuer ainsi de suite jusqu'à trouver le nombre secret. Cette technique consiste à **diviser un problème en deux sous-problèmes indépendants**, c'est un algorithme du type **diviser pour regner**.

Recherche dichotomique de `x` dans un tableau trié `T[1, .. n]` :

|Etape|Description|
|:--|:--|
|**Diviser** |Découper le tableau trié `T[1, …, n]` au milieu en deux sous-tableaux  `T[1, …, n//2]` et `T[n//2 + 1, …, n]`|
|**Régner**	 |- si `x < T[n//2]`, chercher `x` dans `T[1, ..., n//2]` <br>- si `x > T[n//2]` , chercher `x` dans `T[n//2 + 1,..n]`<br>-	si `x == T[n//2]`,  `x` a été trouvé|
|**Combiner**| |

 Faisons par exemple des recherches dans le tableau **trié** [5, 7, 12, 14, 23, 27, 35, 40 ,41, 45]. 
 
 Plusieurs cas se présentent :
    
=== "Recherche de la valeur 40"

    ![Recherche dichotomique de 40 dans le [5, 7, 12, 14, 23, 27, 35, 40 ,41, 45]](assets/3-recherche-dichotomique-40-light-mode.png#only-light){width="50%"}
    ![Recherche dichotomique de 40 dans le [5, 7, 12, 14, 23, 27, 35, 40 ,41, 45]](assets/3-recherche-dichotomique-40-dark-mode.png#only-dark){width="50%"}

    1. On cherche la valeur `40` dans le tableau `[5, 7, 12, 14, 23, 27, 35, 40 ,41, 45]`. 
    2. On partage le tableau en deux parties en son milieu : `milieu =  23`.
    3. `40 > milieu`, on cherche la valeur `40` dans la partie supérieure du tableau `[27, 35, 40 ,41, 45]`.
    4. On partage le tableau en deux parties en son milieu : `milieu = 40`.
    5. `40 = milieu`, on a trouvé la valeur `40`.
        
    

=== "Recherche de la valeur 35"
                
    ![Recherche dichotomique de 35 dans le [5, 7, 12, 14, 23, 27, 35, 40 ,41, 45]](assets/3-recherche-dichotomique-35-light-mode.png#only-light){width="50%"}
    ![Recherche dichotomique de 35 dans le [5, 7, 12, 14, 23, 27, 35, 40 ,41, 45]](assets/3-recherche-dichotomique-35-dark-mode.png#only-dark){width="50%"}

    1. On cherche la valeur `35` dans le tableau `[5, 7, 12, 14, 23, 27, 35, 40 ,41, 45]`. 
    2. On partage le tableau en deux parties en son milieu : `milieu =  23`.
    3. `35 > milieu`, on cherche la valeur `35` dans la partie supérieure du tableau `[27, 35, 40 ,41, 45]`.
    4. On partage le tableau en deux parties en son milieu : `milieu = 40`.
    5. `35 < milieu`, on cherche la valeur `35` dans la partie inférieure du tableau `[27, 35]`.
    6. On partage le tableau en deux parties en son milieu : `milieu = 27`.
    7. `35 > milieu`, on cherche la valeur `35` dans la partie supérieure du tableau `[35]`.
    8. On partage le tableau en deux parties en son milieu : `milieu = 35`.
    5. `35 = milieu`, on a trouvé la valeur `35`.

    On voit ici que la recherche s'effectue jusqu'à ce que le tableau n'ait plus qu'une seule valeur, c'est à dire que `debut` est égal à `fin`. 


=== "Recherche de la valeur 34"
                
    ![Recherche dichotomique de 34 dans le [5, 7, 12, 14, 23, 27, 35, 40 ,41, 45]](assets/3-recherche-dichotomique-34-light-mode.png#only-light){width="50%"}
    ![Recherche dichotomique de 34 dans le [5, 7, 12, 14, 23, 27, 35, 40 ,41, 45]](assets/3-recherche-dichotomique-34-dark-mode.png#only-dark){width="50%"}

    1. On cherche la valeur `34` dans le tableau `[5, 7, 12, 14, 23, 27, 35, 40 ,41, 45]`. 
    2. On partage le tableau en deux parties en son milieu : `milieu =  23`.
    3. `34 > milieu`, on cherche la valeur `34` dans la partie supérieure du tableau `[27, 35, 40 ,41, 45]`.
    4. On partage le tableau en deux parties en son milieu : `milieu = 40`.
    5. `34 < milieu`, on cherche la valeur `34` dans la partie inférieure du tableau `[27, 35]`.
    6. On partage le tableau en deux parties en son milieu : `milieu = 27`.
    7. `34 > milieu`, on cherche la valeur `34` dans la partie supérieure du tableau `[35]`.
    8. On partage le tableau en deux parties en son milieu : `milieu = 35`.
    5. `34 < milieu`, on cherche la valeur `34` dans la partie inférieure du tableau `[]`
    6. On n'a pas trouvé la valeur `34`.

    On voit ici que la recherche s'effectue jusqu'à ce que le tableau soit vide , c'est-à-dire que `debut` est plus grand que `fin`. 


Voilà ce que l'on peut écrire en mode itératif :

``` py linenums="1"
def recherche(x, T) :
    debut = 0
    fin = len(T) - 1
    while debut <= fin:      
        milieu = (fin + debut)//2
        if x < T[milieu]: 
            fin = milieu - 1
        elif x > T[milieu]: 
            debut = milieu + 1
        else: 
            return True   # ou return milieu si on veut la position dans T
    return False    # ou return None par exemple si on veut la position dans T 
```
:warning: Un bug classique est d'écrire  `while debut < fin:` à la ligne 4, alors qu'on a vu que la recherche doit se poursuivre jusqu'à ce que `debut` soit plus grand que `fin`, c'est-à-dire que le tableau est vide. 

Ce programme contient une boucle `while`, il faut donc s'assurer qu'il se termine. Ici le variant de boucle est `fin - debut`. A chaque itération de boucle, on voit qu'il y a trois cas :

- `x < T[milieu]` : dans ce cas, `fin` devient `milieu - 1`, donc le variant décroit strictement ; 
- `x > T[milieu]` : dans ce cas, `debut` devient `milieu + 1`, donc le variant décroit strictement ;
- `x == T[milieu]` : dans ce cas, l'instruction `return True` sort de la boucle et même de la fonction.

Tant qu'on est dans la boucle, le variant de boucle `fin - debut` décroit strictement, la boucle `while debut <= fin:` se terminera donc.

Pour prouver la correction de cet algorithme, on va utiliser la technique de l’invariant de boucle. Ici, un invariant de boucle est : si x est dans T alors `T[debut] <= x <= T[fin]`. Si l'invariant est vrai quand on entre dans la boucle, alors il y a les mêmes trois possibilités :

- `x < T[milieu]` : alors la recherche se poursuit dans `T[debut:milieu - 1]`, l'invariant est encore vrai quand on retourbne dans la boucle; 
- `x > T[milieu]` : alors la recherche se poursuit dans `T[milieu + 1:fin]`, l'invariant est encore vrai quand on retourbne dans la boucle ;  
- `x == T[milieu]` : alors on l'a trouvé.

On a donc bien un invariant de boucle et l'algorithme trouve bien si une valeur est dans un tableau trié ou pas.


Etudions la complexité temporelle pour un tableau de taille $n$. A chaque itération de la boucle on divise la taille du tableau par 2, cela revient donc à se demander combien de fois faut-il diviser la taille du tableau par 2 pour obtenir dans le cas le plus défavorable (`x` n'est pas dans `T`) un tableau comportant un seul entier à la fin ? Cela revient à trouver le nombre $a$ tel que $2^a  = n$ . La solution est  $a= log_2(n)$.


!!! abstract "Cours" 
    La **complexité en temps de l'algorithme de recherche dichotomique est logarithmique en  $O(log_2(n))$**.

On peut bien sûr écrire l'algorithme en mode récursif :

``` py linenums="1"
def recherche(x, T) :
    if len(T) == 0:
        return False
    else:
        debut = 0
        fin = len(T) - 1
        milieu = (fin + debut)//2
        if x < T[milieu]: 
            return recherche(x, T[debut:milieu])
        elif x > T[milieu]: 
            return recherche(x, T[milieu + 1:fin + 1])
        else: 
            return True
```

##	Tri fusion (*mergesort*)

On a vu en classe de première plusieurs algorithmes de tri simples comme le tri par sélection, tri par insertion  ou tri à bulle. 

=== "Tri par sélection"
    
    Le début du tableau étant déjà trié, on parcourt le reste pour trouver le plus petit élément à rajouter en fin de la partie triée.	

    ``` py
    def tri_selection(T):
        n = len(T)
        for i in range(n-1):
            mini = i
            for j in range(i+1, n):
            if T[j] < T[mini]:
                mini = j
            T[i], T[mini] = T[mini], T[i]
        return T
    ```

=== "Tri par insertion"
    
    Le début du tableau étant déjà trié, on insère l'élément suivant à la bonne place dans la partie déjà triée.	
	
    ``` py
    def tri_insertion(T):
        n = len(T)
        for i in range(1, n):
            elt = T[i]
            j = i
            while j > 0 and elt < T[j-1]:
                T[j] = T[j-1]
                j = j - 1
            T[j] = elt
        return T	
    ```

=== "Tri à bulles"

    La fin du tableau étant déjà triée, on parcourt le début du tableau en inverse les éléments successifs qui ne sont pas en ordre croissant.

    ``` py
    def tri_a_bulle(T):
        n = len(T)
        for i in range(n):
            for j in range(n-i-1):
            if T[j] > T[j+1]:
                T[j], T[j+1] = T[j+1], T[j]
        return T
    ```

Ces algorithmes sont considérés comme inefficaces car d'une **complexité quadratique en $O(n^2)$**. 

L'efficacité du tri fusion repose sur la facilité de réunir deux tableaux triés en un seul (leur « fusion »). En effet, pour construire le nouveau tableau élément par élément, il suffit de choisir à chaque fois le plus petit entre le premier élément du premier tableau et le premier élément du second tableau. Inutile de regarder les éléments suivants de chaque tableau puisqu'ils seront plus grands que les premiers. De cette façon, la fusion entre deux tableaux triés se fait en temps linéaire.

Tri Fusion d'un tableau  `T[1, .. n]` :

|Etape|Description|
|:--|:--|
|**Diviser** |Découper le tableau `T[1, …, n]` en deux sous-tableaux `T[1, …, n//2]` et `T[n//2 + 1, …, n]`|
|**Régner**	 |Trier les deux sous tableaux `T[1, …, n//2]` et `T[n//2 + 1, …, n]`|
|**Combiner**|Fusionner les deux sous-tableaux triés `T[1, …, n//2]` et `T[n//2 + 1, …, n]` |


![Exemple de tri fusion. Source wikipedia](assets/3-tri-fusion-light-mode.png#only-light){width="30%" align=right}
![Exemple de tri fusion. Source wikipedia](assets/3-tri-fusion-dark-mode.png#only-dark){width="30%" align=right}

Commençons par écrire une fonction qui fusionne deux tableaux triés T1 et T2. On construit le nouveau tableau élément par élément en retirant tantôt le premier élément du premier tableau, tantôt le premier élément du deuxième tableau, en prenant à chaque fois le plus petit des deux (à supposer qu'aucun des deux tableaux ne soit vide, sinon la réponse est immédiate).

En voici une version itérative[^3.1] : 

``` py linenums="1"
def fusion(T1: list, T2: list) -> list:
    """ (list, list) -> list
    T1 et T2 sont des tableaux triés
    Renvoie le tableau trié des éléments de T1 et T2 ensembles
    """
    T = []
    i1, i2 = 0, 0     # Indices des éléments à comparer de T1 et T2
    # Tant qu'il reste des éléments dans les deux tableaux
    while i1 < len(T1) and i2 < len(T2):
        # On ajoute le plus petit des deux éléments dans T
        if T1[i1] <= T2[i2]:
            T.append(T1[i1])
            i1 += 1
        else:
            T.append(T2[i2])
            i2 += 1
    # Un des deux tableaux et vide, on transfère tous les élements restants dans T
    while i1 < len(T1):
        T.append(T1[i1])
        i1 += 1
    while i2 < len(T2):
        T.append(T2[i2])
        i2 += 1
    return T

```

[^3.1]: Il existe aussi une version récursive en utilisant les tranches de tableau :
    ``` py
    def fusion(T1: list, T2: list) -> list:
        """ (list, list) -> list
        T1 et T2 sont des tableaux triés
        renvoie le tableau trié des éléments de T1 et T2 ensembles 
        """
        if len (T1) == 0: return T2
        if len (T2) == 0: return T1
        if T1[0] < T2[0]:
            return [T1[0]] + fusion(T1[1:], T2)
        else:
            return [T2[0]] + fusion(T1, T2[1:])
    ```

A partir de là, le tri-fusion se construit naturellement de façon récursive :

1.	Si le tableau n'a qu'un élément, il est déjà trié.
2.	Sinon, "diviser" le tableau en deux parties à peu près égales.
3.	Trier récursivement les deux parties avec l'algorithme du tri fusion.
4.	Fusionner les deux tableaux triés en un seul tableau trié.

``` py linenums="1"
def tri_fusion(T: list) -> list:
    """ (list) -> list
    Renvoie le tableau trié (tri-fusion) des éléments de T
    """
    if len(T) <= 1:            # Si le tableau n'a qu'un élément, il est déjà trié
        return T
    else:
        # On divise en deux parties à peu près égales
        T1 = T[:len(T)//2]     
        T2 = T[len(T)//2:]
        # Et on fusionne les deux tableaux après les avoir triés
        return fusion(tri_fusion(T1), tri_fusion(T2))
``` 

Etudions la complexité temporelle pour un tableau de taille $n$.  Comme pour l'algorithme du tri par dichotomie, à chaque itération de la boucle de fusion on divise la taille du tableau par 2, on a donc une complexité en $log_2(n)$. Mais à l'intérieur de chaque boucle, il faut effectuer une fusion qui necessite de faire entre $k/2$ et $k$ comparaisons, où $k$ est la taille des sous-tableaux, c'est donc de l'ordre de $O(n)$.  La complexité du tri fusion est donc de l'ordre  $O(n \times log_2(n))$

!!! abstract "Cours" 
    La complexité en temps de l'algorithme de tri fusion est donc linéarithmique en  $O(n \times log_2(n))$.

Avec un tableau d'un milliard de valeurs, l'algorithme naïf en $O(n^2)$ demande de l'ordre de $10^{18}$ opérations. Avec des ordinateurs effectuant $10^9$ opérations par secondes, il faut de l'ordre de $10^9$ secondes, soit environ 30 ans.

Avec le tri fusion est, le nombre d'opérations est de l'ordre de $10^9 × log_2(10^9) \simeq 10^9 \times 30$, ce qui s'exécute en 30 secondes sur les ordinateurs précédants[^3.2]. 


[^3.1]:
    ``` py
    >>> import math
    >>> math.log(10**9,2)
    29.897352853986263
    ``` 

## 	Rotation d'une image d'un quart de tour

Commençons par analyser un algorithme naïf de rotation d'image pixel par pixel.

Observons la rotation de deux pixel A et B sur le schéma suivant : Le pixel A initialement en position  `[0][0]` devient A' en position `[0][5]`. Le pixel B en `[2][3]` devient B' en `[4][4]`. De façon générale, un pixel en position `[ligne][colonne]` se déplace en position`[colonne][nb pixels – 1 - ligne]`.  


![Transformation des coordonnées de pixels dans une rotation d'image naive](assets/3-rotation-naive-light-mode.png#only-light)
![Transformation des coordonnées de pixels dans une rotation d'image naive](assets/3-rotation-naive-dark-mode.png#only-dark)


Utilisons cette observation pour écrire une rotation pixel par pixel :

``` py
import matplotlib.pyplot as plt

def rotation_naif(image):
    n = len(image)
    new = [[0 for i in range(n)] for j in range(n)]
    for lig in range(n):
        for col in range(n):
            new[col][n-1-lig] = image[lig][col]
    return new

image = plt.imread('R2D2.jpg')
image = rotation_naif (image)

plt.imshow(image)
plt.show()
```

Avec deux boucles imbriquées de taille $n$ , la complexité temporelle de l'algorithme naif est en $O(n^2)$. 

Comparons cette algorithme naïf à une méthode « diviser pour régner » effectuant une rotation d'un quart de tour sur une image carrée, dont le côté est une puissance de 2.

Pour effectuer une rotation d'un quart de tour sur une image :

![Image de R2D2 avant rotation](assets/3-rotation-r2d2-1.png){width="25%"}

on commence par diviser l'image en 4 sous-images :

![Image de R2D2 divisée en 4 sous-images](assets/3-rotation-r2d2-2.png){width="25%"}

puis on effectue une permutation circulaire des quatre sous-images :

![Image de R2D2 avec chaque sous-image tournée](assets/3-rotation-r2d2-3.png){width="25%"}

et enfin une rotation d'un quart de tour pour chaque sous-image :

![Image de R2D2 avec les sous-image reassemblées](assets/3-rotation-r2d2-4.png){width="25%"}
 


Le processus est récursif, on le répète jusqu'à obtenir des sous-images ne contient qu'un seul pixel, un pixel étant uniformément colorié, il est inutile de le tourner.

Rotation d'une image d'un quart de tour : 

|Etape|Description|
|:--|:--|
|**Diviser** |Découper l'image en 4 sous-images et effectuer une permutation circulaire |
|**Régner**	 |Effectuer une rotation d'1/4 de tour pour chaque sous-image|
|**Combiner**|egrouper les 4 sous-images ensembles|

Voilà ce qu'on obtient étape par étape :

![Image de R2D2 avant rotation](assets/3-rotation-r2d2-5.png)

On poursuit sans représenter le quadrillage devenu trop fin pour les deux dernières étapes.

![Image de R2D2 trounées](assets/3-rotation-r2d2-6.png){width="50%"} 

Le code suivant applique ce procédé, en utilisant l'import d'une image par la fonction `imread` de `matplotlib.pyplot` qui donne un tableau de tableaux des pixels.

``` py
import matplotlib.pyplot as plt

def rotation(image):
    n = len(image)
    if n > 1:
        # Diviser en 4 sous image
        quart_haut_gauche = [[image[i][j] for j in range(n//2)] for i in range(n//2)]
        quart_haut_droite = [[image[i][j] for j in range(n//2, n)] for i in range(n//2)]
        quart_bas_gauche = [[image[i][j] for j in range(n//2)] for i in range(n//2, n)]
        quart_bas_droite = [[image[i][j] for j in range(n//2, n)] for i in range(n//2, n)]
        
        # Permutation circulaire
        temp = quart_haut_gauche
        quart_haut_gauche = quart_bas_gauche
        quart_bas_gauche = quart_bas_droite
        quart_bas_droite = quart_haut_droite
        quart_haut_droite = temp

        # Rotation des sous images
        quart_haut_gauche = rotation(quart_haut_gauche)
        quart_haut_droite = rotation(quart_haut_droite)
        quart_bas_gauche = rotation(quart_bas_gauche)
        quart_bas_droite = rotation(quart_bas_droite)

        # Combiner les 4 sous images ensembles
        image = []
        # les lignes du haut
        for i in range(n//2):
            image.append([quart_haut_gauche[i][j] for j in range(n//2)] \
                       + [quart_haut_droite[i][j] for j in range(n//2)])
        # puis les lignes du bas
        for i in range(n//2):
            image.append([quart_bas_gauche[i][j] for j in range(n//2)] \
                        +[quart_bas_droite[i][j] for j in range(n//2)])
    return image

image = plt.imread('R2D2.jpg')
image = rotation(image)
plt.imshow(image)
plt.show()

```

Essayons d'estimer la complexité. La fonction `rotation` exécute 4 boucles imbriquées de taille $n/2$ pour découper l'image en 4 sous-image, chaque boucle a donc une compléxité en $O(n^2)$. Ensuite, la fonction fait appel 4 fois à elle-même sur ces images de taille réduite de 2, suivi de boucles imbriquées à nouveau en $O(n^2)$ pour combiner les 4 images. On a donc un nombre d'opérations qui vérifie $C(n) = 4 \times O(n^2) + 4 \times C(n/2) + 4 \times O(n^2)$. On peut montrer par un calcul mathématique que la complexité en temps de rotation est de l'ordre de $O(n^2 \times log_2(n))$.

Cette complexité en temps est donc (un peu) moins bonne que celle de l'algorithme naïf. Par contre, dans cette procédure, il n'y a pas de création d'une nouvelle image mais de simples permutations de pixels, un à un. La complexité en mémoire est donc ici en $O(1)$, bien meilleure que celle de l'algorithme naïf.


##	Tri Rapide (*quicksort*)


La méthode consiste à placer un élément du tableau, souvent choisi au hasard, (appelé pivot) à sa place définitive, en permutant tous les éléments de telle sorte que tous ceux qui lui sont inférieurs soient à sa gauche et que tous ceux qui lui sont supérieurs soient à sa droite (le « partitionnement »). 

Pour chacun des sous-tableaux, on définit un nouveau pivot et on répète l'opération de partitionnement. Ce processus est répété récursivement, jusqu'à ce que l'ensemble des éléments soit trié.


![Exemple de tri rapide, le pivot est le dernier élément ](assets/3-quicksort-light-mode.png#only-light){width=80% }
![Exemple de tri rapide, le pivot est le dernier élément](assets/3-quicksort-dark-mode.png#only-dark){width=80%}


Tri Rapide d'un tableau `T[1, …, n]`

|Etape|Description|
|:--|:--|
|**Diviser** |Découper le tableau `T[1, …, n]` de part et d'autre d'un pivot en deux sous-tableaux : le  premier contenant toutes les valeurs inférieures au pivot, le second celles qui lui sont supérieures |
|**Régner**	 |Trier les deux sous-tableaux|
|**Combiner**|Regrouper les deux sous tableaux triés|


En pratique, le programme Python est construit en utilisant trois sous-tableaux contenant respectivement les valeurs inférieures, supérieures et égales au pivot. On trie les deux premiers et on combine les trois.
from random import randint


``` py
def tri_rapide(T):
    n = len(T)
    if n == 0: return []

    pivot = T[randint(0, n-1)]
    egales = [x for x in T if x == pivot]
    inferieures = tri_rapide([x for x in T if x < pivot])
    superieures = tri_rapide([x for x in T if x > pivot])
    return inferieures + egales + superieures

```

Le *quicksort* est un tri dont la complexité moyenne est en $O(n \times log_2(n))$, mais dont la complexité dans le pire des cas est un comportement quadratique en $O(n^2)$. Malgré ce désavantage théorique, c'est en pratique un des tris les plus rapides pour des données réparties aléatoirement.
