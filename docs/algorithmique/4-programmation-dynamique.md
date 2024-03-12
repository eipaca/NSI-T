# Programmation dynamique

## Un exemple simple

![Chemin d'un pion sur un damier](assets/4-damier-0.png){width=30% align=right}
Le jeu de Dames se pratique sur un damier de 10 cases sur 10. Les pions sont placés sur les cases foncées et ne peuvent se déplacer que d'une case à la fois, toujours vers l'avant en diagonale. Une des stratégies du jeu consiste à amener un pion sur la dernière rangée pour être promu en dame. 

La question est la suivante :  Sur le damier ci-contre, combien de chemins peut emprunter le pion blanc depuis cette case de départ pour arriver à la case vide sur la rangée du haut et être promu en dame ? 

Si on essaie de compter tous les chemins on risque de vite perdre le compte. Une idée simple pour répondre à ce problème efficacement consiste à noter à chaque intersection le nombre de chemins en partant de la fin. Découpons le processus en plusieurs étapes.

=== "Etape 1"

    On peut déjà observer qu'un certain nombre de cases ne peuvent pas être atteintes par le pion blanc depuis sa position de départ, ou ne peuvent pas mener à la case d'arrivée, on peut donc les exclure de nos calculs.

    ![Chemin d'un pion sur un damier-étape 1](assets/4-damier-1.png){width=30%}

=== "Etape 2"
    Il n'y a que deux cases sur la deuxième rangée qui permettent d'aller sur la case d'arrivée, et pour chacune il n'y a qu'un seul chemin possible. 

    Marquons ces cases avec leur nombre de chemins possibles.

    
    ![Chemin d'un pion sur un damier-étape 2](assets/4-damier-2.png){width=30%}

=== "Etape 3"
    Il y a trois cases sur la troisième rangée pouvant aller sur les deux cases précédentes. 
    
    Un pion sur la case à gauche ou celle à droite n'a qu'un seul chemin possible. 
    
    Par contre un pion sur la case au milieu peut se déplacer soit vers le haut à droite, soit vers le haut à gauche. Dans les deux cas, il n'a plus qu'un chemin possible ensuite. Il y a donc deux chemins possibles au départ de cette case.
    
    ![Chemin d'un pion sur un damier-étape 3](assets/4-damier-3.png){width=30%}


=== "Etape 4"
    Continuons à la rangée suivante. Comme dans la rangée précédente, un pion sur la case à gauche ou celle à droite n'a qu'un seul chemin possible.

    Les deux pions placés au milieu peuvent se déplacer soit vers le haut à droite, soit vers le haut à gauche. Selon le choix que l'on fait, ils pourront emprunter 1 ou 2 chemins différents. Au total, il y a donc 3 chemins possibles au départ de ces deux cases. On comprend que le nombre de chemins possibles à partir d'une case est égal à  la somme des nombres de chemins au départ des cases à gauche et à droite de la rangée du dessus.


    **On a décomposé un problème en deux sous-problèmes plus simples**.
    
    ![Chemin d'un pion sur un damier-étape 4](assets/4-damier-4.png){width=30%}


=== "Etape 5"
    Appliquons cette même idée à la rangée suivante, et notons le nombre de chemins possibles égal à la somme des nombres de chemins indiqués dans les cases à gauche et à droite sur la rangée du dessus.
    
    On constate le nombre de chemins calculé pour une case, par exemple 3, est utilisé deux fois : pour la case qui a 4 chemins possibles et pour la case qui a 6 chemins possibles.

    **Il faut donc garder en mémoire les résultats intermédiaires pour ne pas recalculer la même chose plusieurs fois**.

    
    ![Chemin d'un pion sur un damier-étape 5](assets/4-damier-5.png){width=30%}

=== "Etape 6"
    Continuons à descendre dans le damier rangé par rangée en appliquant le même principe : pour chaque case on ajoute les nombres de chemins trouvés pour les cases à gauche et à droite de la rangée de dessus.  

    On arrive au résultat final : il y a  126 chemins possibles pour aller de la case de départ jusqu'à l'arrivée.

    
    ![Chemin d'un pion sur un damier-étape 6](assets/4-damier-6.png){width=30%}


On peut observer deux choses dans la réalisation de cet algorithme : 

1.	Pour chaque case, il suffit de faire la somme du nombre de chemins depuis la case de gauche et depuis la case de droite sur la rangée au-dessus : on **découpe le problème en sous-problèmes plus faciles à résoudre**.  

2.	Le nombre de chemins calculé pour une case est utilisé pour calculer les nombres de chemins de plusieurs autres cases. Les sous-problèmes se chevauchent. Il faut **garder en mémoire les résultats intermédiaires pour ne pas recalculer la même chose plusieurs fois**.

Ce sont les deux principes de la **programmation dynamique**.




!!! question "Exercice corrigé"
    Mario veut rejoindre la princesse Beach. Il ne peut se déplacer que vers la gauche et vers le haut, et ne peut jamais revenir en arrière. Combien de chemins différents peut-il emprunter ?

    ![Chemin de mario sur un quadrillage 3 x 4](assets/4-mario-question-light-mode.png#only-light){width=50%}
    ![Chemin de mario sur un quadrillage 3 x 4](assets/4-mario-question-dark-mode.png#only-dark){width=50%}


??? Success "Réponse"
    Notons à chaque intersection le nombre de chemins en partant de la fin. Pour chaque intersection, il suffit de faire la somme du nombre de chemins depuis l‘intersection à sa gauche et des chemins depuis l'intersection au dessus.   

    ![Chemin de mario sur un quadrillage 3 x 4](assets/4-mario-answer-light-mode.png#only-light){width=50%}
    ![Chemin de mario sur un quadrillage 3 x 4](assets/4-mario-answer-dark-mode.png#only-dark){width=50%}


    Mario peut prendre 10 chemins différents.

!!! abstract "Cours" 
    La **programmation dynamique**[^4.1] résout un problème en combinant des solutions de **sous-problèmes qui se chevauchent**, c'est à dire qu'il possède des sous-sous-problèmes identiques.  
    
    Afin d'éviter les calculs redondants, **chaque sous-sous-problème n'est résolu qu'une seule fois et sa réponse est gardée en mémoire**.

[^4.1]:   Cette méthode a été introduite au début des années 1950 par Richard Bellman.  Le terme "programmation" dans "programmation dynamique", ne doit pas s'entendre comme "utilisation d'un langage de programmation", mais comme synonyme de planification et ordonnancement.

On peut voir la programmation dynamique comme une amélioration ou une adaptation de la méthode « diviser pour régner » puisqu'on divise un problème en sous problèmes, à la différence que la programmation dynamique s'applique quand les sous-problèmes se chevauchent, autrement dit un sous-problème peut être utilisé dans la solution de plusieurs sous-problèmes différents. Tandis que l'approche  « diviser pour régner » crée des sous-problèmes qui sont complètement séparés et peuvent être résolus indépendamment les uns des autres.

![Graphe comparant la méthode diviser pour regner et la programmation dynamique](assets/4-diviser-regner-vs-prog-dynamique-light-mode.png#only-light){width=80% }
![Graphe comparant la méthode diviser pour regner et la programmation dynamique](assets/4-diviser-regner-vs-prog-dynamique-dark-mode.png#only-dark){width=80% }

## Rendu de monnaie

Problème : On dispose d'un nombre illimité de pièces de ①, ②, ⑤ et ⑩ euros pour rendre une certaine somme. Quel est le plus petit nombre de pièces nécessaire ?

### Algorithme glouton

On a vu en classe de première une solution donnée par un algorithme glouton, qui consiste à faire, étape par étape, un choix optimum local, dans l'espoir d'obtenir un résultat optimum global : dans ce cas on choisit de façon répétitive la pièce de plus grande valeur qui ne dépasse pas la somme restante : 

=== "Programme itératif"

    ``` py
    pieces = [10, 5, 2, 1]

    def rendu_monnaie_gouton(x):
        nombre_pieces = 0
        i = 0 # on commence par la plus grande pièce
        while x > 0:
            if x >= pieces[i]: # on peut rendre pieces[i]
                nombre_pieces += 1
                x = x - pieces[i]
            else:    # on passe à la pièce suivante
                i = i + 1
        return nombre_pieces	
    ```

=== "Programme récursif"
    ``` py
    pieces = [10, 5, 2, 1]

    def rendu_monnaie_gouton(x, i=0):
        if x == 0: 
           return 0  
        if pieces[i] <= x:  # on peut rendre pieces[i]
            return 1 + rendu(x - pieces[i], i)
        return rendu(x, i + 1)   # on passe à la pièce suivante
    ```


Testons l'algorithme glouton pour rendre 13 euros. On obtient bien les 3 pièces ⑩ + ② + ① qui font un total de 13.

``` py
>>> rendu_monnaie_gouton(13)
3
```

Mais que se passe-t-il si on n'a pas de pièce de 1 euro ? Remplaçons `pieces = [10, 5, 2]` et testons l'algorithme : 

```py
IndexError: list index out of range
```

Pourtant on peut rendre ⑤ + ② + ② + ② + ② qui font aussi un total de 13 euros !

C'est le **propre des algorithmes gloutons : une fois qu'une décision a été prise, on ne revient pas en arrière**. Dans certains cas l'algorithme ne trouve pas de solution, ou pas la meilleure solution.  Ici l'algorithme choisit la pièce de 10 euros qui ne mène à rien, il ne peut pas revenir en arrière et ressayer avec une autre pièce !

### Programmation dynamique

La programmation dynamique consiste à résoudre notre problème en combinant les solutions de sous-problèmes. Ici, rendre une somme x peut se faire de plusieurs manières  :

-	rendre x – 10 et rajouter une pièce de ⑩, ou
-	rendre x – 5 et rajouter une pièce de ⑤, ou
-	rendre x – 2 et rajouter une pièce de ②.

Dans notre exemple, pour rendre 13 euros on peut :

-	rendre 3 et rajouter une pièce de ⑩, ou
-	rendre 8 et rajouter une pièce de ⑤, ou
-	rendre 11 et rajouter une pièce de ②.

![Graphe de rendu de monnaie pour 13 euros - première étape](assets/4-rendu-monnaie-1-light-mode.png#only-light){width=80% }
![Graphe de rendu de monnaie pour 13 euros - première étape](assets/4-rendu-monnaie-1-dark-mode.png#only-dark){width=80% }


Chacun de ces sous-problèmes peut être résolus de la même façon. Constituons l'arbre des possibilités :

![Graphe de rendu de monnaie pour 13 euros - complet](assets/4-rendu-monnaie-2-light-mode.png#only-light){width=80% }
![Graphe de rendu de monnaie pour 13 euros - complet](assets/4-rendu-monnaie-2-dark-mode.png#only-dark){width=80% }

Certaines branches mènent à une solution, quand il reste 0 euros à rendre, d'autres pas. 

Implémentons cet algorithme en considérant trois cas :

-	Si x est égal à 0, alors on a rendu x, il n'y a pas de pièces supplémentaires à rendre, on renvoie 0.
-	Si x < la plus petite pièce, on ne pourra pas rendre x de cette façon, on renvoie une valeur infinie (`from math import inf`) afin de ne pas impacter une autre branche qui ménerait à une solution.
-	Sinon, on renvoie  1 + le plus petit nombre de pièces de tous les rendus de x – p, pour toutes les pièces p telles que p <= x. 

Traduit en Python, on obtient la fonction suivante :
```py
from math import inf

pieces = [10, 5, 2]
def rendu_monnaie_dynamique(x):
    if x == 0: return 0
    if x < min(pieces): return inf
    return 1 + min([rendu_monnaie_dynamique(x - p) for p in pieces if p <= x]) 

>>> rendu_monnaie_dynamique(13)
5
```

Avec la programmation dynamique, tous les cas possibles ont été traités, et plusieurs cas ont renvoyé la même solution. On a donc une solution optimale au problème.


Mais testons maintenant cette fonction avec quelques valeurs plus grandes que `13`. Très vite la fonction prend beaucoup de temps pour s'exécuter. Quelques secondes pour exécuter `rendu_monnaie_dynamique(60)`, dizaines de secondes pour `  rendu_monnaie_dynamique(70)`, plusieurs minutes pour `  rendu_monnaie_dynamique(80)`, etc.  Le programme devient vite trop lent, même pour des rendus très simples de quelques pièces de ⑩ euros !

Essayons d'estimer la complexité temporelle de cette fonction. Le nombre d'opérations pour rendre un montant $n$ avec des pieces de 10, 5 et 2 est le nombre d'opérations pour rendre $n-10$, plus le nombre d'opérations pour rendre $n-5$, plus celui pour rendre $n-2$, plus quelques opérations élémentaires. 

Si on appelle $T(n)$ le nombre d'opérations pour rendre $n$, alors on peut donc écrire que :

$T(n) = T(n-10) + T(n-5) + T(n-2) + O(1)$,

avec $O(1)$ pour les quelques opérations supplémentaires. Pour de grandes valeurs de $n$, on peut faire l'approximation que retirer 10, 5, 2 ou 1 euro à $n$ ne change pas grand chose, donc que $T(n-10)$, $T(n-5)$, et $T(n-2)$ sont du même ordre de grandeur que $T(n-1)$,  donc que  $T(n) \approx 3 \times T(n-1) + O(1)$. A chaque fois que $n$ augmente de 1, le nombre d'opérations est mutliplié par 3, plus quelques opérations, la complexité est donc exponentielle en $O(3^n)$ ici, ou de façon générale en $O({nbPieces}^n)$ pour un rendu avec $nbPieces$ pieces.  

### Version descendante (*top-down*), récursivité et mémoïsation

Les appels récursifs sont trop nombreux, la complexité est trop importante pour calculer un solution en temps raisonnable.



En programmation dynamique les sous-problèmes se chevauchent et les mêmes calculs reviennent plusieurs fois. Dans un exemple aussi simple que celui de rendre 13 euros, on retrouve 2 fois la branche qui part de "6" :

![Arbre de rendu de monnaie pour 13 euros - branche rendre 6](assets/4-rendu-monnaie-3-light-mode.png#only-light){width=80% }
![Arbre de rendu de monnaie pour 13 euros - branche rendre 6](assets/4-rendu-monnaie-3-dark-mode.png#only-dark){width=80% }


La solution pour limiter le nombre d'opérations consiste à ne calculer les solutions des sous-problèmes qu'une seule fois et de les garder en mémoire. C'est la technique de **mémoïsation**.

!!! abstract "Cours" 
    La mémoïsation consiste à garder en mémoire les valeurs déjà calculées.

Par exemple, avec un dictionnaire déclaré en variable globale :

```py
from math import inf

memoise = {0: 0}       # on peut déjà mettre 0 pieces pour rendre 0 euros
pieces = [10, 5, 2]

def rendu_monnaie_dynamique(x):
    if x in memoise:
        return memoise[x]
    if x < min(pieces) : return inf     # on ne peut pas mettre inf dans le dictionnaire memoise
    memoise[x] = 1 + min([rendu_monnaie_dynamique(x - p) for p in pieces if p <= x])
    return memoise[x] 
```

Cette fois ci, le résultat est immédiat, même avec des valeurs de `x` de quelques milliers (dans la limite de la pile d'appels récursifs).


### Version ascendante (*bottom-up*)

On a déjà vu dans l'exemple précédent comment écrire un algorithme récursif en utilisant la mémoïsation. Une autre approche de la programmation dynamique consiste à calculer d'abord les sous-problèmes en partant d'un cas de base et à  « remonter » jusqu'à résoudre le problème initial : c'est la version ascendante, ou *top-down*.

![Rendu de monnaie pour 13 euros bottom-up](assets/4-rendu-monnaie-bottom-up-light-mode.png#only-light){width=30% align=right}
![Rendu de monnaie pour 13 euros bottom-up](assets/4-rendu-monnaie-bottom-up-dark-mode.png#only-dark){width=30% align=right}

Appelons $nb_i$ le nombre de pièces pour rendre une somme $i$. Comme dans l'approche *top-down*,  $nb_i$ est égal à 1 + le plus petit nombre de pièces de tous les rendus de i – p, pour toutes les pièces p telles que p <= i. Si aucune pièce p ne convient, alors il n'est pas possible de rendre $i$, on peut représenter $nb_i$ par l'infini[^4.3].

[^4.3]:  $nb_i$ est donné par la formule de récurrence $nb_i = \underset{p \leq i}{\min}⁡ (1+ nb_{i-p})$.


On va créer le même dictionnaire que celui utilisé pour la mémoïsation, mais en le remplissant itérativement en partant cette fois de 0 et en incrémentant jusqu'à x.

``` py
from math import inf
nb = {0: 0}
pieces = [10, 5, 2]

def rendu_bottom_up(x):
    for i in range(1, x + 1):
        q = inf                     # on cherche le minimum pour rendre i
        for p in pieces:             # on essaie chaque piece p
            if p <= i:               
                 q = min(q, 1 + nb[i-p])
        nb[i] = q
    return nb[x]
```

Ici, aucun soucis avec la complexité de la fonction (ni de limite de pile d'appels récursifs), la fonction s'exécute instantanément même avec de très grandes valeurs de `x`. En effet, la fonction fait une double boucle imbriquée, sur la valeur à rendre $n$, et sur le nombre de pièces disponibles. La complexité est donc simplement linéaire en $O(n \times nbPieces)$.



!!! abstract "Cours" 
    La programmation dynamique peut prendre deux formes :

    - Une forme récursive descendante de haut en bas, ou *top-down*, avec mémoïsation : 
        - On utilise directement la formule de récurrence.
        - Lors d'un appel **récursif**, avant d'effectuer un calcul on regarde si son résultat n'est pas gardé en mémoire.
        - Sinon, on fait le calcul et on le garde en mémoire.

    -   Une forme itérative ascendante de bas en haut, ou *bottom-up* :
        - On résout de façon **itérative** d'abord les sous-problèmes de la plus "petite taille", puis ceux de la taille "d'au dessus", etc. Au fur et à mesure on garde les résultats en mémoire.
        - On continue jusqu'à la taille voulue.

##	Découpe de tiges d'acier

Problème : Soit une tige d'acier qu'on découpe par morceau pour les revendre selon une grille de tarif suivante :

|Longueur (m)| 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|:--     |:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-: |
|Prix (€)   | 0 | 1 | 5 | 8 | 9 | 10| 17| 17| 20| 24| 30 |

L'objectif est donc de découper la tige de façon optimale pour en tirer un prix maximum.

Prenons, l'exemple d'une tige de longueur 4 m. On peut la découper de 8 façons différentes :

![Découpe d'une tige de 4 m](assets/4-decoupe-tige-light-mode.png#only-light){width=80% }
![Découpe d'une tige de 4 m](assets/4-decoupe-tige-dark-mode.png#only-dark){width=80% }

Le meilleur revenu est le découpage en 2 tiges de 2 m, pour un prix de 10 €. Mais comment le calculer de façon systématique ? 
 
Appelons `R[n]` le revenu maximum d'une tige de longueur `n` et prenons un exemple. 


Le revenu maximum pour découper une barre de longueur 4 est le maximum de :

-	Le prix d'une barre de longueur 1  + le revenu maximum d'un barre de longueur 3 : Prix [1] + R[3]
-	Le prix d'une barre de longueur 2  + le revenu maximum d'un barre de longueur 2 : Prix [2] + R[2]
-	Le prix d'une barre de longueur 3  + le revenu maximum d'un barre de longueur 1 : Prix [3] + R[1]
-	Le prix d'une barre de longueur 4 

![Découpe d'une tige de 4 m - éape 1](assets/4-decoupe-tige-arbre-1-light-mode.png#only-light){width=80% }
![Découpe d'une tige de 4 m - étape 1](assets/4-decoupe-tige-arbre-1-dark-mode.png#only-dark){width=80% }

La valeur de `R[0]` est immédiate, c'est le revenu maximumune d'une barre de longeur de zéro, c'est-à-dire 0. Mais comment calculer `R[1]`, `R[2]` et `R[3]` ? On applique le même principe.

![Découpe d'une tige de 4 m - arbre complet](assets/4-decoupe-tige-arbre-2-light-mode.png#only-light){width=80% }
![Découpe d'une tige de 4 m- arbre complet](assets/4-decoupe-tige-arbre-2-dark-mode.png#only-dark){width=80% }

De façon générale, on peut calculer  `R[n]` avec la formule `R[n] = max(Prix[i] + R[n-i] pour 1 ≤ i  ≤ n )`  et `R[0] = 0`. On a découpé le problème en plusieurs sous-problèmes. Par ailleurs, les résultats de certains sous-problèmes, par exemple le calcul de  `R[2]`, sont réutilisés plusieurs fois.

Traduisons cet algorithme de programmation dynamique en version descendante :


``` py
from math import inf

prix = [0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30]

def R(n):
    if n == 0: return 0
    q = -inf
    for i in range(1, min(n + 1, len(prix))):
        q = max(q, prix[i] + R(n-i))
    return q
```

La complexité temporelle de la fonction est de l'ordre du nombre de nœud dans l'arbre, c'est-à-dire une complexité exponentielle en $O(2^n)$.  Cette solution n'est donc pas utilisable pratiquement, mais on constate une fois de plus que les sous-problèmes se chevauchent, on peut donc garder les résultats des sous-problèmes en mémoire pour améliorer cette situation. Appliquons cette technique de mémoïsation :

```py
from math import inf

prix = [0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30]
memoise = {0 : 0}

def R(n):
    if n in memoise: return memoise[n]
    q = -inf
    for i in range(1, min(n + 1, len(prix))):
        q = max(q, prix[i] + R(n-i))
    memoise[n] = q
    return q
```

L'ajout d'une variable globale dans la fonction permet de se convaincre facilement de l'effet sur la complexité temporelle :
``` py

cpt = 0
def R(n):
    global cpt
    cpt + = 1
    if n == 0: 
        #...
```

Alors que la première fonction, sans mémoïsation, s'appelle 1024 fois pour le calcul de R(10) et 1 043 456 fois pour R(20), la version avec mémoïsation s'appelle seulement 56 et 156 pour les mêmes calculs ! Mais cela se fait aux dépends de la complexité spatiale.


La version ascendante est une autre façon efficace de palier au problème de complexité temporelle :

```py
from math import inf

prix = [0, 1, 5, 8, 9, 10, 17, 17, 20, 24, 30]
p = [0]

def R(n):
    for j in range(1, n + 1):
        q = -inf
        for i in range(1, min(j + 1, len(prix))):
            q =  max(q, prix[i] + p[j - i])
        p.append(q)
    return p[n]
```

Ici, avec deux boucles imbriquées, la complexité est quadratique en $O(n^2)$.




## Alignement de séquences

Un problème utile aux généticiens est celui de l'alignement de séquences, qui se décline en de nombreuses variations, dont plusieurs peuvent être abordées à l'aide de la programmation dynamique.

Nous nous intéressons ici à la recherche d'une plus longue sous-chaîne commune. Étant donné deux chaine de caractères `str1`  et `str2`, on cherche une chaine de caractères, la plus longue possible, qui soit à la fois extraite de `str1`  et de `str2`. Dire qu'une sous-chaîne est extraite de `str1` signifie que l'on peut obtenir cette sous-chaîne en effaçant certains caractères de `str1`. Autrement dit, tous les caractères de la sous-chaîne commune doivent apparaître dans l'ordre dans `str1` et `str2`, même s'ils ne sont pas consécutifs dans ces deux chaînes, seul l'ordre des caractères compte.

Prenons l'exemple de :
``` py
str1 = 'CGCATA'
str2 = 'GACT'
```

Une plus longue sous-chaîne commune est  `'GAT'`. En effet, tous les caractères de `'GAT'` apparaîssent dans le même ordre dans `str1` :

``` py
CGCATA
-G-AT-
```

de même dans `str2` :

``` py
G-ACT 
G-A-T
```
On peut aligner les deux chaines l'une sous l'autre et faire apparaître la sous-chaîne commune dans la troisième ligne :
``` py
CGCA-TA
-G-ACT- 
-G-A-T-
```

Les caractères `G`, `A` et `T` sont alignés, on peut donc extraire la sous-chaine `'GAT'` à la fois de `str1` et `str2`

Notons bien qu'il n'y a pas unicité de la plus longue sous-chaine commune ! `'GCT'` est également une plus longue sous-chaîne commune, de même longueur 3 :
``` py
CG-CATA
-GAC-T-
-G-C-T-
```

Abordons ce problème sous l'approche de programmation dynamique. Pour trouver la plus longue sous-chaine commune entre `'CGCATA'` et `'GACT'` , on commence par aligner les deux chaines en partant de la fin et par comparer les deux derniers caractères :

![Alignement séquences - Etape 1](assets/4-alignement-sequence-1-light-mode.png#only-light){width=100% }
![Alignement séquences - Etape 1](assets/4-alignement-sequence-1-dark-mode.png#only-dark){width=100% }


Les deux caractères `A` et `T` sont différents, ils ne pourront pas être alignés dans une plus longue sous-chaine commune. On peut avancer dans notre recherche en cherchant ces deux sous-problèmes : 

1.	la plus longue sous-chaine commune entre la première chaine, `'CGCATA'`, et la seconde chaine réduite de son dernier caractère,  `'GAC'`, ou 
2.	la plus longue sous-chaine commune entre la première chaine réduite de son dernier caractère, `'CGCAT'`, et la seconde chaine, `'GACT'`.

![Alignement séquences - Etape 2](assets/4-alignement-sequence-2-light-mode.png#only-light){width=100% }
![Alignement séquences - Etape 2](assets/4-alignement-sequence-2-dark-mode.png#only-dark){width=100% }


La  plus longue sous-chaine commune entre `str1` et `str2` sera la solution trouvée la plus longue à ces deux sous-problèmes.
 
Commençons par le premier sous-problème : trouver la plus longue sous-chaine commune entre `'CGCATA'` et `'GAC'`. A nouveau, les deux derniers caractères sont différents, ils ne pourront pas être alignés dans une plus longue sous-chaine commune, on peut encore partager ce problème en deux sous problèmes.

Abordons ensuite, le second sous-problème : trouver la plus longue sous-chaine commune entre `'CGCAT'` et `'GACT'`. Cette fois-ci, les deux derniers caractères sont identiques, ils pourront être alignés dans la plus longue sous-chaine commune. On garde en mémoire le caractère `'T'` qu'on rajoutera au résultat de la plus longue sous-chaine commune entre ces deux dernière chaines réduites de ce `'T'`  :   `'CGCA'` et `'GAC'`.

![Alignement séquences - Etape 3](assets/4-alignement-sequence-3-light-mode.png#only-light){width=100% }
![Alignement séquences - Etape 3](assets/4-alignement-sequence-3-dark-mode.png#only-dark){width=100% }

Passons à l'étape suivante. Les chaînes `'CGCATA'` et `'GA'`  ont le même dernier caractère, ils pourront être alignés dans la plus longue sous-chaine commune. On garde en mémoire le caractère `'A'` qu'on rajoutera au résultat de la plus longue sous-chaine commune entre ces deux dernière chaines réduites de ce `'A'`  :  `'CGCAT'` et `'G'`.

Par contre, les chaînes `'CGCAT'` et `'GAC'`  ont un dernier caractère différent, on va donc chercher les plus longues chaines communes entre `'CGCAT'` et `'GA'` d'une part  et `'CGCAT'` et `'GA'` d'autre part. Notons que le sous problème de la plus longue chaine commune entre `'CGCA'` et `'GAC'` a déjà été rencontré. C'est le propre de la programmation dynamique, les sous-problèmes se chevauchent, il ne faut pas les recalculer plusieurs fois !

![Alignement séquences - Etape 4](assets/4-alignement-sequence-4-light-mode.png#only-light){width=100% }
![Alignement séquences - Etape 4](assets/4-alignement-sequence-4-dark-mode.png#only-dark){width=100% }

On continue ainsi jusqu'à trouver des sous-chaines vide, il n'y a alors plus de sous-chaine commune à chercher.

![Alignement séquences - Etape 5](assets/4-alignement-sequence-5-light-mode.png#only-light){width=100% }
![Alignement séquences - Etape 5](assets/4-alignement-sequence-5-dark-mode.png#only-dark){width=100% }

On trouve ici deux chemins qui permettent d'aligner 3 caractères entre les deux chaines : `'GAT'`et `'GCT'`.

Généralisons l'approche que l'on vient de faire sur l'exemple. Soit deux sous-chaines `str1` et `str2` et essayons de calculer  la plus longue sous-chaîne commune entre les deux, que l'on note `T(str1, str2)`. Deux cas se présentent :

-	Si l'une des deux sous-chaîne est vide, alors il n'y a pas de plus longue sous-chaine commune : `T(str1, str2) = ''`.

-	Si les deux sous-chaîne ont un ou plusieurs caractères, alors :

    1.	Si les deux sous-chaînes ont le même dernier caractère, `str1[-1] == str2[-1]`, alors ces caractères pourront être alignés, la plus longue chaine commune est la plus longue chaîne commune entre les deux sous-chaînes réduite de leur dernier caractère, à laquelle on ajoute ce caractère commun : `T(str1, str2) = T(str1[:-1], str2 [:-1]) + str[-1]`. 

    2.	Si les derniers caractères sont différents, `str1[-1] != str2[-1]`, alors ces caractères ne  pourront pas être alignés, la plus longue chaine commune est la chaîne qui a le plus de caractères entre :

        -	la plus longue chaîne commune de la première chaîne et de la seconde réduite de son dernier caractère d'une part, et

        -	La plus longue chaîne commune de la seconde chaîne et de la première réduite de son dernier caractère d'autre part,

        Donc   `T(str1, str2) =  max_len(T(str1, str2[:-1]), T(str1[:-1], str2))`, où `max_len` renvoie la chaîne la plus longue entre les deux.

Cette relation de récurrence se traduit directement en Python en version dynamique descendante :

``` py
str1 = 'CGCATA'
str2 = 'GACT'

def maxi(str1, str2):
    """ str, str -> str
    Renvoie la plus longue chaine des deux
    ou la premiere si les deux chaines on la même longueur
    """
    if len(str1) >= len(str2):
        return str1
    else:
        return str2


memo = {}
def alignement_sequence_top_down(str1, str2):
    """ str, str -> str
    Renvoie une plus longue chaine commune
    """
    if (str1, str2) in memo: return memo[(str1, str2)]
    if str1 =='' or str2 == '': memo[(str1, str2)] = ''
    elif str1[-1] == str2[-1]:
        memo[(str1, str2)] = alignement_sequence_top_down(str1[:-1], str2[:-1]) + str1[-1]
    else:
        # on garde str1 et enlève le dernier car de str2
        lsc1 = alignement_sequence_top_down(str1, str2[:-1])
        # on garde str2 et enlève le dernier car de str1
        lsc2 = alignement_sequence_top_down(str1[:-1], str2)
        if len(lsc1) >= len(lsc2):
            memo[(str1, str2)] = lsc1
        else:
            memo[(str1, str2)] = lsc2
    return memo[(str1, str2)]


print(alignement_sequence_top_down(str1, str2))
```

La version ascendante utilise la même relation de récurrence mais de façon un peu plus complexe que les exemples précédents. L'idée est de construire un tableau de tableaux `T` rempli des résultats des sous-problèmes rencontrés, c'est-à-dire des plus longues sous-chaînes communes entre les chaines `str1[ :i+1]` et `str[:j+1]` pour les valeurs de `i` allant et `j` allant de `0` à `len(str1)` et `len(str2)` respectivement.

On peut faire les constatations suivantes : 

-	Pour `i = 0` on remplit la première ligne pour les valeur de `j` avec `''` si `str1[0]`  n'est pas présent dans  `str2[:j+1]` car il n'y a pas d'alignement possible ; ou sinon avec `str1[0]` s'il est présent. 

-	Pour  `j = 0`, alors on remplit la première colonne pour les valeur de `i` avec `''` si `str2[0]`  n'est pas présent dans  `str1[:i+1]` car il n'y a pas d'alignement possible ; ou sinon  avec `str2[0]` s'il est présent. 

-	Ensuite pour chaque valeur de `i` et `j` à partir de `1`, deux cas de figure se présentent :

    -	Si les deux dernier caractères de `str1[:i+1]` et `str2[:j+1]` sont identiques ,  c'est-à-dire `str1[i] == str2[j]`, alors ils peuvent être alignés :  
    `T[i][j] = T[i-1][j-1] + str[i]`

    - S'ils sont différents, c'est-à-dire `str1[i] != str2[j]`, alors ils ne peuvent pas être alignés, il faut prendre la plus longue sous-chaîne entre les deux sous-chaînes calculées en enlevant l'un des dernier caractère :   
    `T[i][j] = max_len(T[i][j-1], T[i-1][j])`

    La plus longue sous-chaine commune est calculée dans la dernière ligne dernière colonne du tableau de tableaux.

![Alignement séquences - tableau de tableaux](assets/4-alignement-sequence-tableau-light-mode.png#only-light){width=100% }
![Alignement séquences - tableau de tableaux](assets/4-alignement-sequence-tableau-dark-mode.png#only-dark){width=100% }


Traduite en Python, on obtient le code suivant :

``` py
def alignement_sequence_bottom_up(str1, str2):
    """ str, str -> str
    Renvoie une plus longue chaine commune
    """
    n1, n2 = len(str1), len(str2)
    T = [['' for j in range(n2)] for i in range(n1)]
    for i in range(n1):
        if str2[0] in str1[:i+1]:
            T[i][0] = str2[0]
    for j in range(n2):
        if str1[0] in str2[:j+1]:
            T[0][j] = str1[0]

    for i in range(1, n1):
        for j in range(1, n2):
            if str1[i] == str2[j]:
                T[i][j] = T[i-1][j-1] + str1[i]
            else:
                T[i][j] = maxi(T[i][j-1], T[i-1][j])

    return T[n1-1][n2-1]

print(alignement_sequence_bottom_up(str1, str2))

```





## Problème du sac à dos


![Un sac à dos avec des objets de poids et valeurs différents à mettre dans le sac à dos](assets/4-sac-a-dos.png){width=30%  align=right}

Problème : On dispose d'un sac à dos avec une capacité maximum de poids à transporter. Parmi plusieurs objets de poids et de valeurs différents, lesquels peut-on mettre dans le sac à dos de façon à maximiser la somme des valeurs des objets choisis sans que leur poids total ne dépasse la capacité du sac. C'est un problème d'**optimisation avec contrainte**.

Par exemple, on peut considérer les objets suivants et un sac à dos avec une capacité maximum de 15 kg.

|Poids (kg)| 12 | 4 | 2 |1 | 1 | 
|:--      |:-:|:-:|:-:|:-:|:-:|
|Prix (€) |  4 | 10 | 2 | 2 | 1 | 



On peut choisir plusieurs combinaisons d'objets, par exemple les objets de poids 12kg, 2kg, 1kg et 1kg ont un poids total inférieur à la capacité du sac de 15kg et une valeur totale de 9 €, ou encore les objets de poids 4kg, 2kg, 1kg et 1kg pour une valeur totale de 15 €. Mais comment trouver la combinaison optimale dans toutes les situations ?

![Exemples d'objets mis dans le sac à dos](assets/4-sac-a-dos-2-exemples-light-mode.png#only-light){width=60% }
![Exemples d'objets mis dans le sac à dos](assets/4-sac-a-dos-2-exemples-dark-mode.png#only-dark){width=60% }



Représentons les objets dans une liste de p-uplets nommés :

```py
liste_1 = [{'poids': 12, 'valeur': 4},
           {'poids': 4, 'valeur': 10},
           {'poids': 2, 'valeur': 2},
           {'poids': 1, 'valeur': 2},
           {'poids': 1, 'valeur': 1}]
```


### Algorithme glouton

L'algorithme glouton le plus simple consiste à prendre les objets en ordre de valeur décroissante tant que leur poids ne fait pas dépasser la capacité du sac. On peut écrire le code suivant :

!!! note inline end "" 
    L'utilisation de la fonction `sorted()` permet de ne pas modifier la liste `liste_objets`.

``` py linenums="1"
def sac_glouton(liste_objets, poids_max):
    """ list[dict], int -> int
    Renvoie la valeur maximale d'objets {'poids', 'valeur'}
    qui peuvent être mis dans le sac sans que leur poids dépasse poids_max
    """

    poids_sac = 0
    valeur_sac = 0
    # objets pris en ordre de valeur décroissante
    for objet in sorted(objets, key=lambda x: x['valeur'], reverse=True):
        # si le poids de objet ne fait pas dépasser la capacité du sac
        if objet['poids'] + poids_sac <= poids_max:
            # on le met dans le sac
            poids_sac += objet['poids']
            valeur_sac += objet['valeur']
    return valeur_sac

assert sac_glouton(liste_1, 15) == 15
```

L'algorithme glouton renvoie `15` pour l'exemple précédant d'une liste d'objets `liste_1` et d'un sac de capacité 15 kg, c'est bien la plus grande valeur d'objets :

![Algorithme glouton par valeur dans l'exemple précédant](assets/4-sac-a-dos-glouton-valeur-1-light-mode.png#only-light){width=50%}
![Algorithme glouton par valeur dans l'exemple précédant](assets/4-sac-a-dos-glouton-valeur-1-dark-mode.png#only-dark){width=50%}


![Algorithme glouton par valeur dans un autre exemple](assets/4-sac-a-dos-glouton-valeur-2-light-mode.png#only-light){width=40% align=right}
![Algorithme glouton par valeur dans un autre exemple](assets/4-sac-a-dos-glouton-valeur-2-dark-mode.png#only-dark){width=40% align=right}

Mais en favorisant les objets ayant la plus grande valeur, l'algorithme ne prend pas en compte leur poids ce qui conduit à une solution qui n'est pas optimale dans tous cas. 


Regardons ce qu'il se passe avec la liste d'objets suivante :


```py
liste_2 = [{'poids': 12, 'valeur': 4},
          {'poids': 15, 'valeur': 10},
          {'poids': 1, 'valeur': 9}]
```


L'algorithme choisit d'abord l'objet de 15 kg, il n'est plus possible d'en ajouter d'autres, ni de revenir en arrière pour enlever l'objet. C'est le principe des algorithmes gloutons, on ne revient pas en arrière sur une décision qui a été prise. L'algorithe renvoie donc `10`, ce n'est pas optimal, les objets de 1 kg et 12 kg avaient une valeur totale de 13 €.



Une approche plus fine consiste à prendre en priorité les objets ayant le meilleur ratio valeur/poids. Modifions la boucle `for` dans le programme pour trier les objets par ce ratio :

```py linenums="9"
    # objets pris en l'ordre de ratio valeur/poids décroissant
    for objet in sorted(liste_objets, key=lambda x: x['valeur']/x['poids'], reverse=True):
```


Ce nouvel algorithme glouton renvoie aussi la valeur attendue `15`  pour l'exemple précédant d'une liste d'objets `liste_1` et d'un sac de capacité 15 kg, c'est bien la plus grande valeur d'objets : 


![Algorithme glouton par valeur/poids dans un autre exemple](assets/4-sac-a-dos-glouton-valeur-poids-1-light-mode.png#only-light){width=50%}
![Algorithme glouton par valeur/poids dans un autre exemple](assets/4-sac-a-dos-glouton-valeur-poids-1-dark-mode.png#only-dark){width=50%}

Essayons maintenant cette nouvelle liste :

![Algorithme glouton par valeur/poids dans un autre exemple](assets/4-sac-a-dos-glouton-valeur-poids-2-light-mode.png#only-light){width=40% align=right}
![Algorithme glouton par valeur/poids dans un autre exemple](assets/4-sac-a-dos-glouton-valeur-poids-2-dark-mode.png#only-dark){width=40% align=right}


``` py
liste_3 = [{'poids': 12, 'valeur': 7},
          {'poids': 9, 'valeur': 10},
          {'poids': 5, 'valeur': 2},
          {'poids': 2, 'valeur': 1}]
```

Les objets triés par ratio valeur/poids décroissants sont 9 kg, 12 kg, 2 kg puis 5 kg. L'algorithme glouton commence par mettre l'objet de 9 kg dans le sac et ensuite celui de 2 kg, il renvoie donc la valeur `11`.  La solution n'est encore pas optimale, le premier algorithme par valeur renvoyait `12` ! 


###	Programmation dynamique


Une fois de plus la programmation dynamique offre une solution optimale au problème.

Reprenons l'exemple d'un sac de capacité 15 kg avec les objets de la `liste_1` et calculons la valeur maximale des objets qui peuvent être mis dans ce sac. On la note `V[15]`.

![Objet de poids 1 kg et valeur 1 euro](assets/4-sac-a-dos-objet-1kg-1euro.png){width=10% align=right}


Au début le sac est vide. On se pose la question de mettre un premier objet dans le sac, par exemple l'objet de 1kg avec une valeur d'1 €. Deux cas se présentent :

1.	Cas 1 : On met l'objet d'1kg dans le sac, il restera à calculer la valeur maximale d'un sac de 14kg, `V[14]`, puis de lui ajouter la valeur de 1 € de l'objet.
2.	Cas 2 : On ne met pas l'objet dans le sac, il restera à calculer la valeur maximale  d'un sac de 15kg, `V[15]`, sans lui ajouter aucune valeur ensuite.

Si on peut trouver la solution de ces deux sous-problèmes, il suffira ensuite de prendre la plus grande valeur entre les deux.
On remarque que pour calculer `V[15]`, le deuxième cas consiste à calculer `V[15]`, c'est circulaire ! Alors quelle est la différence ? 

La différence réside dans la liste d'objets disponibles. Au début, tous les objets sont disponibles pour être mis, ou pas, dans la sac à dos.  Ensuite l'objet pesant 1kg de valeur 1 euro n'est plus disponible, soit il a été mis dans le sac (cas 1), soit il a été écarté (cas 2) et on ne le considère plus pour être mis dans le sac.


![Le calcul de la valeur maximum dépend du poids max p et de la liste d'objet indicée jusqu'à i](assets/4-sac-a-dos-v(i,p)-light-mode.png#only-light){width=100% }
![Le calcul de la valeur maximum dépend du poids max p et de la liste d'objet indicée jusqu'à i](assets/4-sac-a-dos-v(i,p)-dark-mode.png#only-dark){width=100%}

On en déduit que le calcul de la valeur maximale d'un sac de capacité $p$ ne dépend pas que de la valeur de $p$, mais aussi de la liste d'objets disponibles. On identifie les objets par leur indice $i$ dans la liste, et on notera $V_{i,p}$  la valeur maximale d'un sac de capacité $p$ en choisissant parmi les objets d'indices $0$, $1$, $2$, …, $i-1$, $i$.

Généralisons cette approche. Soit un sac de capacité p et une liste d'objet  d'indices $0$, $1$, $2$, …, $i-1$, $i$, et essayons de calculer $V_{i,p}$. On se pose la question de mettre le dernier objet de la liste, de poids $poids_{i}$  et de valeur $valeur_{i}$ dans le sac, ou pas. Plusieurs cas se présentent :

- Si $poids_{i} > p$, alors l'objet est trop lourd pour le sac, il est écarté. On calculera la valeur maximale pour la même capacité de sac $p$, mais avec une liste d'objet qui s'arrête à $i-1$ : $V_{i, p}= V_{i-1, p}$.

- Si $poids_{i} \leq p$, alors l'objet $i$ peut rentrer dans le sac. On retombe sur les deux cas de l'exemple précédant :

    1. 	Cas 1 : On met l'objet $i$ dans le sac, il reste à calculer la valeur maximale d'un sac de capacité $p - poids_{i}$ avec les objets restants, $V_{i-1,p - poids_i}$,  puis de lui ajouter la valeur de l'objet $valeur_{i}$.

	2. Cas 2 : On ne met pas l'objet $i$ dans le sac, il reste à calculer la valeur maximale d'un sac de capacité $p$ avec les objets restants, sans lui ajouter aucune valeur ensuite : $V_{i-1, p}$.

    3. $V_{i, p}$ est le cas le plus favorable entre les deux : $V_{i, p} = \max(V_{i-1, p} , valeur_{i} + V_{i-1, p - poids_{i}})$
    


![Relation de récurence donnant Vi,p](assets/4-sac-a-dos-recurence-light-mode.png#only-light){width=80% }
![Relation de récurence donnant Vi,p](assets/4-sac-a-dos-recurence-dark-mode.png#only-dark){width=80%}


Cette relation de récurrence se traduit directement en Python en version dynamique descendante :

```py
def sac_dynamique_top_down(liste_objets, poids_max):
    """ int, list[dict] -> int
    Renvoie la valeur maximale d'objets {'poids', 'valeur'}
    qui peuvent être mis dans le sac     sans que leur poids dépasse poids_max
    """

    # V[(i, p)] est la valeur max d'un sac de capacité p avec les premiers objets de liste_objets
    # jusqu'à liste_objets[i] inclus

    V = {(0, p): 0 for p in range(poids_max  + 1)}
   # on remplit la premiere ligne avec la valeur du premier objet (i=0)
    # pour tous les sac de capacité p >= poids de cet objet
    for p in range(liste_objets[0]['poids'], poids_max + 1):
        V[(0, p) ] = liste_objets[0]['valeur']



    def sac_dynamique(i, p):
        if (i, p) in V:
            return V[(i, p)]

        if p < liste_objets[i]['poids']:
            # on ne le met pas dans le sac
            V[(i, p)] = V[(i-1, p)]
        else:
            # on prend la plus grande valeur entre ne pas mettre i dans le sac
            V[(i, p)] = max( sac_dynamique(i-1, p),
                # et ajouter l'objet i au sac
                sac_dynamique(i - 1, p - liste_objets[i]['poids']) + liste_objets[i]['valeur'])
        return V[(i, p)]
    return sac_dynamique(len(liste_objets) - 1 , poids_max)


assert sac_dynamique_top_down(liste_1, 15) == 15
assert sac_dynamique_top_down(liste_2, 15) == 13
assert sac_dynamique_top_down(liste_3, 15) == 12
```

La version ascendante consiste à construire un tableau de tableaux contenant les valeurs maximales du problème réduit aux premiers objets de la liste `V[i][p]`, jusqu'à l'objet `liste_objets[i]` inclus et d'un sac de capacité `p`. 

La première ligne du tableau est simple  : Si `i = 0`, alors seulement le premier objet de liste_objet est disponible pour remplir le sac, donc `V[0][p]` est égal à zéro pour toutes les valeurs de `p` inférieure au poids du premier objet et `V[0][p]` est égal au poids du premier objet pour les valeurs suivantes. 

Les autres valeurs de `V[i][p]` sont calculées à partir de la relation de récurence précédente. La solution du problème se trouve sur la dernière ligne et la dernière colonne du tableau de tableau :


![Construction du tableau de tableaux des Vi,p en bottom-up](assets/4-sac-a-dos-bottom-up-light-mode.png#only-light){width=80% }
![Construction du tableau de tableaux des Vi,p en bottom-up](assets/4-sac-a-dos-bottom-up-dark-mode.png#only-dark){width=80%}



``` py
def sac_dynamique_bottom_up(liste_objets, poids_max):
    """ int, list[dict] -> int
    Renvoie la valeur maximale d'objets {'poids', 'valeur'}
    qui peuvent être mis dans le sac     sans que leur poids dépasse poids_max
    """
    n = len(liste_objets)

    V = [[0]*(poids_max + 1) for i in range(n)]
    # V[i][p] est la valeur max d'un sac de capacité p avec les premiers objets de liste_objets
    # jusqu'à liste_objets[i] inclus

    # on remplit la premiere ligne avec la valeur du premier objet (i=0)
    # pour tous les sac de capacité p >= poids de cet objet
    for p in range(liste_objets[0]['poids'], poids_max + 1):
        V[0][p] = liste_objets[0]['valeur']

    # on remplit les lignes suivantes
    for i in range(1, n):
        for p in range(poids_max + 1):
            # si l'objet i est plus lourd que p
            if p < liste_objets[i]['poids']:
                # on ne le met pas dans le sac
                V[i][p] = V[i-1][p]
            # sinon
            else:
                # on prend la plus grande valeur entre ne pas mettre i dans le sac
                V[i][p] = max( V[i-1][p],
                    # et ajouter l'objet i au sac
                    V[i-1][p - liste_objets[i]['poids']] + liste_objets[i]['valeur'])
    return V[n-1][poids_max]

assert sac_dynamique_bottom_up(liste_1, 15) == 15
assert sac_dynamique_bottom_up(liste_2, 15) == 13
assert sac_dynamique_bottom_up(liste_3, 15) == 12
```








