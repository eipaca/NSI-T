# Recherche textuelle

!!! abstract "Cours" 
    La recherche  textuelle consiste à trouver les occurrences d'une sous-chaîne, appelée **motif** ou **clé**, dans une **chaine** de caractères.  

C'est un problème très fréquent, par exemple quand on fait CTRL+F pour chercher un mot dans un fichier ou sur une page web.  En Python, la recherche textuelle est nativement présente avec les instructions `motif in chaine` ou `chaine.index(motif)` et `chaine.find(motif)`. 

Il existe de nombreux algorithmes de recherche textuelle, on étudie dans ce chapitre l'algorithme de Boyer-Moore et sa version simplifiée de Horpsool sur un exemple de bio-informatique: chercher la séquence `TCACTC` (le motif) dans un brin d'ADN `CTTCCGCTCGTATTCGTCTCACTCG` (la chaine).

##	 Recherche naïve par « force brute »

Il s'agit de faire « glisser » le motif de gauche à droite pour parcourir la chaîne caractère après caractère, et de vérifier pour chaque caractère du motif s'il correspond à celui de la chaine. Ce traitement est long mais on est certain d'avoir un bon résultat.

Commençons par aligner le motif à droite de la chaine et par comparer le premier caractère du motif à celui de la chaine :

![Recherche naïve - étape 1](assets/5-naive-1.png)

Le `T` du motif ne correspond pas au `C` de la chaine. On décale le motif d'un caractère à droite et on essaie à nouveau :

![Recherche naïve - étape 2](assets/5-naive-2.png)

Le `T` correspond à celui de la chaine, on compare les caractères suivants à droite : le `C` ne correspond pas au `T`. On décale d'un caractère à droite :

![Recherche naïve - étape 3](assets/5-naive-3.png)

Le `T` et le `C` correspondent à la chaine, mais pas le `A`. On décale d'un caractère :

![Recherche naïve - étape 4](assets/5-naive-4.png)

Le `T` ne  correspond pas au `C` de la chaine. On décale d'un caractère :

L'opération se répète jusqu'à trouver tous les caractères du motif qui correspondent. 

![Recherche naïve - étape 5](assets/5-naive-5.png)

Le recherche naïve est très longue car il faut parcourir toute la chaîne, caractère par caractère, et à chaque fois comparer avec un ou plusieurs caractères du motif jusqu'à trouver un caractère qui ne coïncide pas.  Dans le pire des cas, le motif et la chaine contiennent tous les deux une seule et même lettre, le coût est donc en $O(n \times m)$, où $n$ est la longueur de la chaine et $m$ celle du motif. Et dans le meilleur des cas, le premier caractère du motif n'est pas présent dans la chaine, le coût est en $O(n)$.

Traduit en Python, on obtient le programme suivant :

``` py linenums="1"

chaine = 'CTTCCGCTCGTATTCGTCTCACTCG'
motif = 'TCACTC'


def naive(motif, chaine):
    """ str, str -> list
    Renvoie la liste des positions trouvées du motif dans la chaîne
    """
    positions = []
    n = len(chaine)
    m = len(motif)
    i = 0    # position du début du motif dans la chaine
    while i <= n - m  :
        j = 0       # position du caractère dans le motif
        while j < m and chaine[i + j] == motif[j]:
            j = j + 1
        if j == m:       # on a trouvé le motif
            positions.append(i)
        i = i + 1   # on décale d'un caractère à droite
    return positions

assert naive(motif, chaine) == [18]
assert naive('AAA', 'AAAAA') == [0, 1, 2]
assert naive('AT', 'ATATAT') == [0, 2, 4]
assert naive('AZ', chaine) == []

```

![La valeur finale de i est n-m inclus](assets/5-naive-i-final-light-mode.png#only-light){width="25%" align=right}
![La valeur finale de i est n-m inclus](assets/5-naive-i-final-dark-mode.png#only-dark){width="25%" align=right}

Attention à prendre soin de terminer la boucle sur le dernier caractère quand `i` vaut `n – m` **inclus**.

On constate que si l'algorithme fonctionne très bien, il est coûteux en temps machine et peut donc être optimisé. 

##	Recherche naïve à rebours

Une première modification consiste à inverser l'ordre des caractères à comparer : on part du dernier caractère du motif et s'il correspond à celui de la chaîne on passe au caractère précédent jusqu'à trouver une discordance ou avoir parcouru l'ensemble du motif (on a alors trouvé le motif).

![Recherche naïve à rebours - étape 1](assets/5-rebours-1.png)
Le `C` du motif  ne correspond pas au `G` de la chaine, on décale d'un caractère à droite. 

![Recherche naïve à rebours - étape 2](assets/5-rebours-2.png)
Le `C`  correspond, mais le `T` ne correspond pas au `G` de la chaine, on décale d'un caractère à droite.

![Recherche naïve à rebours - étape 3](assets/5-rebours-3.png)

Le `C`  ne correspond pas au `T`, on décale d'un caractère à droite.

![Recherche naïve à rebours - étape 4](assets/5-rebours-4.png)

Le `A`  puis le `T` correspondent à la chaine, mais pas le `C`, on décale d'un caractère à droite,  et ainsi de suite...

On modifie donc le code Python de la façon suivante :

``` py linenums="13"
    while i <= n - m  :
        j = m -  1       # position du caractère dans le motif
        while j >= 0 and chaine[i + j] == motif[j]:
            j = j - 1
        if j == -1:       # on a trouvé le motif
            positions.append(i)
        i = i + 1   # on décale d'un caractère à droite
    return positions
```

La modification n'a pas changé le cout de l'algorithme. Mais alors quel est l'intérêt ?

##	L'algorithme de Horspool

Horspool propose une version simplifiée de l'algorithme de Boyer-Moore.

Dans la recherche naïve, lorsque que le dernier caractère ne correspond pas à une lettre de la chaîne, on décale le motif d'un caractère, mais on peut faire mieux en regardant si ce caractère de la chaîne est présent autre part dans le motif :


![Recherche Horspool - étape 1](assets/5-horspool-1.png)

Le `C` ne correspond pas au `G` de la chaine. Plutôt que de décaler le motif d'une seule position vers la droite, on voit qu'il y n'y a pas de  `G`  dans le motif, on peut donc « sauter »  de toute la longueur du motif, et gagner beaucoup de temps :

![Recherche Horspool - étape 2](assets/5-horspool-2.png)

Le `C` ne correspond pas au `A` de la chaine, mais il y a un `A` dans la chaîne 3 caractères à gauche du dernier caractère du motif, on peut donc aligner immédiatement ce dernier `A` du motif en « sautant »  de 3 caractères :


![Recherche Horspool - étape 3](assets/5-horspool-3.png)

Le `C` ne correspond pas au `T` de la chaine.  Il y a un `T`dans le motif 5 caractères à gauche du dernier caractère du motif et un autre 1 caractère à gauche. On peut aligner ce dernier  `T` du motif en « sautant » de 1 caractère. 


![Recherche Horspool - étape 4](assets/5-horspool-4.png)

Le `C` ne correspond pas au `T` de la chaine, mais il y a un `T` dans la chaîne 1 caractère à droite du dernier caractère du motif. On aligne ce `T` du motif en décalant de 1 caractère :

![Recherche Horspool - étape 5](assets/5-horspool-5.png)

Le `C` et le `T`  correspondent à la chaine, mais ensuite le  `C` ne correspond pas au `G`, on « saute » de 2 caractères pour aligner les `C` :

![Recherche Horspool - étape 6](assets/5-horspool-6.png)

Le `C`, le `T` et le `C` correspondent, mais pas le `A` au `T` de la chaine, on « saute » de 2 caractères pour aligner les `C` :

![Recherche Horspool - étape 7](assets/5-horspool-7.png)

Le `C` correspond, mais pas le `T` avec le `A` de la chaine , on « saute » de 2 caractères pour aligner les `C` :

![Recherche Horspool - étape 8](assets/5-horspool-8.png)

Tous les caractères correspondent. On a trouvé le motif en 8 étapes, au lieu de 18 avec l'algorithme naïf !

On voit que le saut est déterminé par le caractère de la chaine qui est aligné sur le dernier caractère du motif. Ce saut est toujours le même pour un même caractère, quelle que soit la position où la différence est trouvée. Ici, dans notre exemple :

-   Quand cette lettre est un `A` on fait toujours un saut de 3 caractères.

![Saut quand la lettre est A](assets/5-horspool-saut-A.png){height="10%"}

-	Quand ce caractère est un `C` on fait toujours un saut de 2 caractères quelle que soit la position du caractère différent de la chaine.

![Un exemple de saut quand la lettre est C](assets/5-horspool-saut-C.png){height="10%" }



On voit aussi que si un caractère apparaît plusieurs fois dans le motif, on ne garde que celui qui est le plus à droite.  Par exemple, ici `T` apparaît plusieurs fois dans le motif, on calcule le saut pour `T` en considérant celui qui est le plus à droite du motif, c'est-à-dire 1.

![Saut quand la lettre est T](assets/5-horspool-saut-T.png){height="10%"}

Enfin, on voit que le dernier caractère du motif  n'est pas pris en compte pour calculer le saut correspondant (puisqu'il aurait un saut de 0). Par exemple, ici le dernier `C` n'est pas pris en compte pour calculer le saut correspondant à `C`, on prend en compte celui qui est 2 caractères avant.

![Un exemple de saut quand la lettre est C (en ignorant le dernier caractére)](assets/5-horspool-saut-C-2.png){height="10%" }

Plutôt que de recalculer ces sauts à chaque fois qu'une différence est trouvée, on peut donc faire un prétraitement de l'algorithme de Horspool en calculant au début une seule fois tous les sauts associés à chaque lettre du motif. 

!!! abstract "Cours" 
    Prétraitement :  Pour chaque lettre du motif (sauf la dernière), le saut à effectuer est égal à l'écart entre la dernière occurrence de cette lettre dans le motif et la fin du motif. On ne calcule pas de saut pour le dernier caractère.


Dans notre exemple, la table des sauts pour le motif  `'TCACTC'` est donc la suivante :

|A|C|T|autres|
|:-:|:-:|:-:|:-:|
|3|2|1|6|

Un dictionnaire Python permet d'enregistrer simplement les valeurs des sauts calculés pendant le prétraitement : `{'A': 3, 'C': 2, 'T': 1}`. Les autres caractères qui n'apparaissent pas dans le dictionnaire auront un saut maximum de la longueur du motif.

Ecrivons le prétraitement en Python :

``` py
def table_sauts(motif):
    d = {}
    m = len(motif)
    for i in range(m - 1):  # on exclut la derniere lettre du motif
        d[motif[i]] = m - i - 1
    return d

```

et le reste de l'algorithme de Horspool :

``` py linenums="1"
def horspool(motif, chaine):
    positions = []
    n = len(chaine)
    m = len(motif)
    sauts = table_sauts(motif) # on construit le dictionnaire « table de saut »
    print(chaine)
    i = 0
    while i <= n - m:
        print(' ' * i + motif)     # affiche le motif aligné avec la chaine
        j = m -  1       # position du caractère dans le motif
        while j >= 0 and chaine[i + j] == motif[j]:
            j = j - 1
        # si on a trouvé le motif
        if j == -1:
            positions.append(i)
            i = i + 1
        # sinon si le dernier caractère est dans la table des sauts
        elif chaine[i + m - 1] in sauts:
            i = i + sauts[chaine[i + m - 1]]   # on saute de la table de sauts
        # sinon
        else:      # le caractère n'est pas dans le motif
            i = i + m    # on saute tout le motif
    return positions
```

L'algorithme de Horspool n'améliore pas le pire des cas de la recherche naïve, si le motif et la chaine contiennent tous les deux une seule et même lettre, le coût est toujours en $O(n \times m)$, où $n$ est la longueur de la chaine et $m$ celle du motif. Par contre dans le meilleur des cas, si le dernier caractère du motif n'est pas présent dans la chaine, les sauts permettent d'améliorer fortement le coût en $O(n/m)$.


## L'algorithme de Boyer-Moore 

### La règle du mauvais caractère (*bad character*)

On peut généraliser l'idée du saut calculé sur la lettre alignée avec le dernier caractère du motif en calculant le saut sur le premier mauvais caractère.

Comme avec Horspool[^5.1], quand on trouve un caractère qui n'est pas présent dans le motif, on peut « sauter »  derrière celui-ci :

[^5.1]:[https://webhome.cs.uvic.ca/~nigelh/Publications/stringsearch.pdf](https://webhome.cs.uvic.ca/~nigelh/Publications/stringsearch.pdf)

![Recherche Boyer-Moore - étape 1](assets/5-horspool-1.png)

Le `C` ne correspond pas au `G` de la chaine. Il y n'y a pas de `G`  dans le motif, on « saute »  de toute la longueur du motif :

![Recherche Boyer-Moore - étape 2](assets/5-horspool-2.png)

Le `C` ne correspond pas au `A` de la chaine, mais il y a un `A` dans la chaîne 3 caractères à droite du dernier caractère du motif. On peut aligner ce dernier `A` du motif en « sautant » de 3 caractères.

![Recherche Boyer-Moore - étape 3](assets/5-boyer-moore-3.png)

Le `C` et le `T` correspondent, mais pas le `C`  avec le `T` de la chaine. Plutôt que de calculer le saut en fonction du `C` comme avec Horspool, c'est-à-dire un saut de 2 caractères,  on utilise le premier mauvais caractère, ici `T`. Il y a un `T` dans le motif à gauche du mauvais caractère, on peut aligner ces `T` et  sauter de 3 caractères.  Attention, on ne prend pas en compte le `T` dans le motif à droite du mauvais caractère.

C'est comme si on calculait la table des sauts pour un motif réduit `TCAC` :

|A|C|T|autres|
|:-:|:-:|:-:|:-:|
|1|2|3|4|



![Recherche Boyer-Moore - étape 4](assets/5-boyer-moore-4.png)

Le `C`  et le `T` correspondent, mais pas le `C` avec le `G` de la chaine.  Il n'y a pas de `G` dans la partie droit du motif,  (il n'y en a pas du tout), on « saute » de 4 caractères après ce `G` .

![Recherche Boyer-Moore - étape 5](assets/5-boyer-moore-5.png)

Le `C` correspond, mais  pas le  `T` avec le `A`. Le mauvais caractère est un `A` et il y a un `A` à droite du mauvais caractère, on « saute » de 2 caractères pour aligner les `A`. 

![Recherche Boyer-Moore - étape 6](assets/5-boyer-moore-6.png)

Tous les caractères correspondent. On a trouvé le motif en 6 étapes, au lieu de 8 avec Horspool !

La règle du mauvais caractère dans l'algorithme de Boyer-Moore consiste donc à examiner la chaîne en partant du bout du motif et en remontant les caractères du motif un par un jusqu'à trouver une discordance :

- 	si la lettre de la chaîne examinée est identique à celle du motif on remonte  le motif d'un cran
- 	si la lettre de la chaîne examinée est en discordance avec celle du motif on regarde si cette lettre existe dans le motif _parmi les caractères non examinés_. 
    -	si elle existe, on réalise un saut correspondant;
    -	si elle n'existe pas,  on saute au-delà de la cette dernière position examinée.

A la différence de Horspool, les sauts ne dépendent pas que de la lettre qui ne coïncide pas, mais aussi de la position de cette lettre.  La table des sauts a donc deux entrées : les caractères du motif et la position j dans le motif à laquelle se trouve la discordance :

-	Pour `j = 5`, les sauts sont calculés sur la position du dernier caractère du motif, on retrouve les sauts de Horspool.

-	Pour les autres valeurs de j, il faut calculer les sauts sans prendre en compte les caractères qui coïncident, par exemple pour `j = 3`, les sauts correspondent aux sauts Horpsool pour le motif  `TCAC`, c'est-à-dire en ignorant les derniers caractères `TC` (puisqu'ils coïncident avec la chaîne).

-	Certaines valeurs ont un `X` pour les caractères qui correspondent au motif (ce n'est pas un mauvais caractère). 

|j(lettre)|A|C|T|autres|
|:-:|:-:|:-:|:-:|:-:|
|0 (T)|1|1|X|1|
|1 (C)|2|X|1|2|
|2 (A)|X|1|2|3|
|3 (C)|1|X|3|4|
|4 (T)|2|1|X|5|
|5 (C)|3|X|1|6|



En Python, on peut construire cette table des sauts avec un tableau de dictionnaire :

``` py
[{},
 {'T': 1},
 {'C': 1, 'C': 2},
 {'A': 1, 'T': 3},
 {'A': 2, 'C': 1},
 {'A': 3, 'T': 1}]
```

La programmation de l'algorithme complet de Boyer-Moore dépasse le niveau attendu en NSI. 

``` py linenums="1"
def table_sauts_bm(motif):
    """ str -> list(dict)
    Renvoie un tableau de dictionnaires de sauts pour les valeurs de j
    """
    tab = []
    for j in range(len(motif)):
        tab.append(table_sauts(motif[:j+1]))
    return tab

def boyer_moore(motif, chaine):
    positions = []
    n = len(chaine)
    m = len(motif)
    sauts = table_sauts_bm(motif) # on construit le dictionnaire « table de saut »
    print(chaine)
    i = 0
    while i <= n - m: # On ne peut pas utiliser la boucle for avec les sauts
        print(' ' * i + motif)     # affiche le motif aligné avec la chaine
        j = m - 1   # position du caractère dans le motif
        coincide = 0
        while j >= 0 and chaine[i + j] == motif[j]:
            j = j - 1
        # si on a trouvé le motif
        if j == -1:
            positions.append(i)
            i = i + 1
        # sinon si le mauvais caractère est dans le motif
        elif chaine[i + j] in sauts[j]:    #
            i = i + sauts[j][chaine[i + j]]    # on saute de la table de sauts
        else:                # le caractère n'est pas dans le motif
            i = i + j + 1    # on saute tout le motif
    return positions
```

###	Règle du bon suffixe (good suffix)
L'algorithme complet de Boyer-Moore ajoute une règle du “bon suffixe” qui n'a pas été présentée ici.

Reprenons à l'étape 3 :
![Recherche Boyer-Morre avec la règle du bon suffixe - étape 3](assets/5-boyer-moore-3-bs.png)

Le `C` et le `T` correspondent, mais pas le `C`  avec le `T` de la chaine. Plutôt que de calculer le saut en fonction du `C` comme avec Horspool, c'est-à-dire un saut de 2 caractères,  on utilise le premier mauvais caractère, ici `T`. Il y a un `T` dans le motif à gauche du mauvais caractère, on peut aligner ces `T` et  sauter de 3 caractères.  Attention, on ne prend pas en compte le `T` dans le motif à droite du mauvais caractère. On applique la meilleure des deux :

![Recherche Boyer-Morre avec la règle du bon suffixe - étape 4](assets/5-boyer-moore-4-bs.png)

Ici, le mauvais caractère est `T`, la règle du « mauvais caractère » nous permet d'aligner ce `T` avec le `T` du motif à gauche, c'est-à-dire de « sauter » d'1 caractère. 

![Recherche Boyer-Morre avec la règle du bon suffixe - étape 5](assets/5-boyer-moore-5-bs.png)

Le `T` correspondant `A` du motif est le mauvais caractère, la règle du « mauvais caractère » nous permettrait de « sauter » de 2 caractères. Mais on a encore un bon suffixe, `TC`, on peut donc faire mieux et aligner les `TC` en « sautant » de 4 caractères. On applique la meilleure des deux règles :

![Recherche Boyer-Morre avec la règle du bon suffixe - étape 6](assets/5-boyer-moore-6-bs.png)

On a trouvé le motif en 6 étapes.

La règle du « bon suffixe » consiste à calculer une seconde table :


|Bon suffixe|Saut| |
|--:|:-:|:-:|
|`C`|2|Si le bon suffixe est `C`, on peut « sauter » de 2 caractères comme Horspool|
|`TC`|4||
|`CTC`|4|On aligne avec le `TC` du début du motif|
|`ACTC`|4||
|`CACTC`|4||


L'algorithme de Boyer Moore consiste à prendre à chaque étape le plus grand saut entre les deux tables .



On peut regarder l'animation de [http://fred.boissac.free.fr/AnimsJS/recherchetextuelle/index.html](http://fred.boissac.free.fr/AnimsJS/recherchetextuelle/index.html)