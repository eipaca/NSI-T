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

Le principe de la recherche dichotomique dans un tableau trié est celui suivi pour jouer à 'trouver un nombre entre 1 et 100' qui consiste à proposer 50, si la réponse est 'perdu c'est plus' il faut ensuite proposer 75 et si la réponse est 'perdu c'est moins' il faut proposer 25, etc. Cela consiste à **diviser un problème en deux sous-problèmes indépendants**.

Recherche dichotomique de `x` dans un tableau trié `T[1, .. n]` :

|Etape|Description|
|:--|:--|
|**Diviser** |Découper le tableau trié `T[1, …, n]` au milieu en deux sous-tableaux  `T[1, …, n//2]` et `T[n//2 + 1, …, n]`|
|**Régner**	 |- si `x < T[n//2]`, chercher `x` dans `T[1, ..., n//2]` <br>- si `x > T[n//2]` , chercher `x` dans `T[n//2 + 1,..n]`<br>-	si `x == T[n//2]`,  `x` a été trouvé|
|**Combiner**| |

 Prenons par exemple la recherche de 35 dans le tableau [5, 7, 12, 14, 23, 27, 35, 40 ,41, 45].  On peut résumer le principe de recherche dichotomique par le schéma suivant :

![Un exemple de recherche dichotomique](assets/3-recherche-dichotomique-light-mode.png#only-light){width="40%"}
![Un exemple de recherche dichotomique](assets/3-recherche-dichotomique-dark-mode.png#only-dark){width="40%"}

Ou sous forme d'arbre :

![Un exemple de recherche dichotomique sous forme d'arbre](assets/3-recherche-dichotomique-arbre-light-mode.png#only-light){width="50%"}
![Un exemple de recherche dichotomique sous forme d'arbre](assets/3-recherche-dichotomique-arbre-dark-mode.png#only-dark){width="50%"}


Voilà ce que l'on peut écrire en mode itératif :

``` py linenums="1"
def recherche(x, T) :
    debut = 0
    fin = len(T) - 1
    while debut <= fin:      
        milieu = (fin + debut)//2
        if x < T[milieu]: fin = milieu - 1
        elif x > T[milieu]: debut = milieu + 1
        else: return True
    return False
```
Attention de ne pas écrire  `while gauche < droite:` à la ligne 4 qui ne trouverait pas `recherche(1, [1])` ni `recherche(2, [1, 2])` par exemple.

ou en récursif :

``` py linenums="1"
def recherche(x, T) :
    if len(T) == 0:
        return False
    else:
        debut = 0
        fin = len(T) - 1
        milieu = (fin + debut)//2
        if x < T[milieu]: return recherche(x, T[debut:milieu])
        elif x > T[milieu]: return recherche(x, T[milieu + 1:fin + 1])
        else: return True
```

Etudions la complexité temporelle pour un tableau de taille $n$. A chaque itération de la boucle on divise la taille du tableau par 2, cela revient donc à se demander combien de fois faut-il diviser la taille du tableau par 2 pour obtenir dans le cas le plus défavorable (`x` n’est pas dans `T`) un tableau comportant un seul entier à la fin ? Cela revient à trouver le nombre $a$ tel que $2^a  = n$ . La solution est  $a= log_2(n)$.

!!! abstract "Cours" 
    La **complexité en temps de l'algorithme de recherche dichotomique est logarithmique en  $O(log_2(n))$**.

##	Tri fusion (Mergesort)

On a vu en classe de première plusieurs algorithmes de tri simples comme le tri par sélection, tri par insertion  ou tri à bulle. 

=== "Tri par sélection"
    
    Le début du tableau étant déjà trié, on parcourt le reste pour trouver le plus petit élément à rajouter en fin de la partie triée.	

    ``` py
    def tri_selection(T):
        n = len(T)
        for i in range(n - 1):
            mini = i
            for j in range(i + 1, n):
            if T[j] < T[mini]:
                mini = j
            T[i], T[mini] = T[mini], T[i]
        return T
    ```

=== "Tri par insertion"
    
    Le début du tableau étant déjà trié, on insère l’élément suivant à la bonne place dans la partie déjà triée.	
	
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
                T[j],T[j+1] = T[j+1],T[j]
        return T
    ```

Ces algorithmes sont considérés comme inefficaces car d’une **complexité quadratique en $O(n^2)$**.

Le principe du tri fusion consiste à réunir deux tableaux triés en un seul (leur « fusion »). L'efficacité de l'algorithme vient du fait que deux tableaux triés peuvent être fusionnées en temps linéaire.

À partir de réunir deux tableaux triés, on peut facilement construire un nouveau tableau trié comportant les éléments issus de ces deux tableaux. En effet, le plus petit élément du tableau à construire est soit le plus petit élément du premier tableau, soit le plus petit élément du deuxième.


Tri Fusion d’un tableau  `T[1, .. n]` :

|Etape|Description|
|:--|:--|
|**Diviser** |Découper le tableau `T[1, …, n]` en deux sous-tableaux `T[1, …, n//2]` et `T[n//2 + 1, …, n]`|
|**Régner**	 |Trier les deux sous tableaux `T[1, …, n//2]` et `T[n//2 + 1, …, n]`|
|**Combiner**|Fusionner les deux sous-tableaux triés `T[1, …, n//2]` et `T[n//2 + 1, …, n]` |


![Exemple de tri fusion. Source wikipedia](assets/3-tri-fusion-light-mode.png#only-light){width="30%" align=right}
![Exemple de tri fusion. Source wikipedia](assets/3-tri-fusion-dark-mode.png#only-dark){width="30%" align=right}

Commençons par écrire une fonction qui fusionne deux tableaux triés T1 et T2. On construit le nouveau tableau élément par élément en retirant tantôt le premier élément du premier tableau, tantôt le premier élément du deuxième tableau (en fait, le plus petit des deux, à supposer qu'aucune des deux tableaux ne soit vide, sinon la réponse est immédiate).


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

Le tri-fusion est naturellement décrit de façon récursive.

1.	Si le tableau n'a qu'un élément, il est déjà trié.
2.	Sinon, séparer le tableau en deux parties à peu près égales.
3.	Trier récursivement les deux parties avec l'algorithme du tri fusion.
4.	Fusionner les deux tableaux triés en un seul tableau trié.

``` py
def tri_fusion(T: list) -> list:
    """ (list) -> list
    renvoie le tableau trié (tri-fusion) des éléments de T
    """
    if len(T) <= 1:
        return T
    else:
        T1 = l[:len(T)//2]
        T2 = l[len(T)//2:]
        return fusion(tri_fusion(T1), tri_fusion(T2))
``` 

Etudions la complexité temporelle pour un tableau de taille n.  Comme pour l’algorithme du tri par dichotomie, à chaque itération de la boucle de fusion on divise la taille du tableau par 2, C’est une complexité en 〖log〗_2 (n) . Mais à l’intérieur de chaque boucle, il faut effectuer une fusion qui necessite de faire entre k/2  et k comparaisons, où k est la taille des sous-tableaux , en moyenne n/2 donc. C’est une complexité supplémentaire linéaire en n.

!!! abstract "Cours" 
    La complexité en temps de l'algorithme de tri fusion est donc linéarithmique en  $O(n \times log_2(n))$.

Avec un tableau d’un milliard de valeurs, l’algorithme naïf en $O(n^2)$ demande de l’ordre de $10^18$ opérations. Avec des ordinateurs effectuant $10^9$ opérations par secondes, il faut de l’ordre de $10^9$ secondes, soit environ 30 ans.

La complexité du tri fusion est de l’ordre de $10^9 × log_2(10^9) ≈ 30 × 10^9$ opérations, ce qui se fait en 30 secondes. 
