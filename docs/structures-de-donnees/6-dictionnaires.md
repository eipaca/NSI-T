# Dictionnaires


!!! abstract "Cours"
    
    Un dictionnaire est un type abstrait de données formé de couples **clé-valeur**. Chaque couple est une **entrée** du dictionnaire.
    Un dictionnaire n'a **pas d'ordre**, on accède à **chaque valeur par sa clé**. 

La clé d'un dictionnaire peut être un mot (de type `str`), un nombre (de type `int` ou `float`), un p-uplet, etc., mais pas un tableau (type `list`) car c'est un type muable.

##	Interface

Les principales primitives constituant l'interface d'un dictionnaire sont :

- `creer() → dict` : construire d'un dictionnaire vide.
- `est_vide() → bool` : vérifier si un dictionnaire est vide ou non.
- `ajouter(clé, valeur)` : ajouter un couple clé-valeur.
- `supprimer(clé) → valeur` : supprimer une entrée associée à une clé.
- `lire(clé) → valeur` : Lire la valeur associée à une clé.
- `taille() → int` : renvoyer le nombre d'éléments dans un dictionnaire.



##	Implémentation

Prenons l'exemple d'une situation dans laquelle il est nécessaire de stocker les capitales des pays du monde. Ni les listes chaînées, ni les tableaux, ne semblent offrir une solution efficace pour manipuler ces données :

- Les pays ne sont pas classés dans un ordre particulier, un tableau ne permettrait donc pas d'accéder facilement aux informations concernant un pays identifié par son nom.

- Une liste chaînée aurait l'inconvénient de devoir parcourir toute la liste pour accéder aux informations concernant un pays donné.

Dans ce cas, un dictionnaire est la structure de donnée la mieux adaptée à cette situation.

Plusieurs implémentations de dictionnaires sont possibles, par exemple en utilisant une fonction de hachage. Python possède naturellement cette structure avec le type `dict`, mais ce  n'est pas le cas dans tous les langages.  


###	Avec le type `dict` de Python

Le type `dict` Python offre toutes les primitives d'un dictionnaire : 

``` py
>>> capitale = {}           # creer()
>>> len(capitale) == 0      # est_vide()
True
>>> capitale["France"] = "Paris"     # ajouter(cle, valeur)
>>> capitale["Allemagne"] = "Berlin"     # ajouter(cle, valeur)
>>> capitale["Italie"] = "Rome"     # ajouter(cle, valeur)
>>> capitale["France"]              # lire(cle)
'Paris'
>>> len(capitale)           # taille()
3
>>> capitale.pop("Italie")          # supprimer(clé) 
'Rome'
```

Les dictionnaires Python offrent beaucoup d'autres fonctionalités. Rappelons quelques caractéristiques vues en classe de première : 

-   Un dictionnaire peut être créer avec plusieurs éléments de clés-valeurs (*key-value* en anglais) séparés par des virgules, et le tout encadré par des accolades “{ }”.

    ``` py
    >>> capitale = {'France': 'Paris', 'Allemagne': 'Berlin', 'Italie': 'Rome'}
    ```

-   Les éléments sont affichés sans ordre particulier.
    ``` py
    >>> capitale
    {'Allemagne': 'Berlin', 'France': 'Paris', 'Italie': 'Rome'}
    ```

-   On accède à une valeur d'un dictionnaire ***uniquement par sa clé, mais pas par sa position**, les valeurs d'un dictionnaire n'ont pas de position :

    ``` py
    >>> capitale[0]
    Traceback (most recent call last):
    File "<pyshell#12>", line 1, in <module>
        capitale[0]
    KeyError: 0
    ```
    Dans ce cas, l'interpréteur renvoie un message d'erreur car la clé `0` n'existe pas dans le dictionnaire `capitale`. 

-   La méthode `get()` permet aussi de récupérer une valeur associée à une clé sans lever d'erreur si la clé n'existe pas.

    ``` py
    >>> capitale.get('France')
    'Paris'
    >>> capitale.get(0)
    >>> capitale.get('Espagne', 'Non défini')
    Non défini
    ```

-   Le mot clé `in` permet de vérifier si une clé est présente dans un dictionnaire.

    ``` py
    >>> "France" in capitale
    True
    >>> "Espagne" in capitale
    False
    ```
    :warning: Les mot clé `in` s'applique seulement aux clés d'un dictionnaire, pas à ses valeurs :
    ``` py
    >>> "Paris" in capitale
    False
    ```

-   De la même façon, `for` permet d'itérer sur les clés d'un dictionnaire :  

    ``` py
    >>> for cle in capitale:
    ...     print(cle, capitale[cle])
    ...
    Allemagne Berlin
    France Paris
    Italie Rome
    ```
    [^6.1]

[^6.1]: Il est aussi possible d'utiliser la méthode `items()` et d'écrire : : `>>> for cle, val in 'capitale.items():


-   Les méthodes `.keys()` et `.values()` renvoient les clés et les valeurs d'un dictionnaire :

    ``` py
    >>> capitale.keys()
    dict_keys(['Allemagne', 'France', 'Italie'])
    >>> capitale.values()
    dict_values(['Berlin', 'Paris', 'Rome'])
    ```
    et la méthode `.items()` renvoie tous les couples de clé-valeur d'un dictionnaire :

    ``` py
    >>> capitale.items()
    dict_items([('Allemagne', 'Berlin'), ('France', 'Paris'), ('Italie', 'Rome')])
    ```

    :warning: Les objets renvoyés par ces trois méthodes sont de types Python un peu particuliers : `dict_keys`, `dict_values` et `dict_items`. Pour les utiliser, il faut souvent les transformer en tableaux avec la fonction `list()` :

    ``` py
    >>> list(capitale.values())
    ['Berlin', 'Paris', 'Rome']
    >>> list(capitale.items())
    [('Allemagne', 'Berlin'), ('France', 'Paris'), ('Italie', 'Rome')]
    ```

-   Il est possible de modifier la valeur associée à une clé  : 

    ``` py
    capitale["Italie"] = "Roma"
    ```


-   Les méthodes `pop()` et `clear()` permettent de supprimer des éléments d'un dictionnaire (pas de méthode `remove()`).

    ||||
    |:-:|:--|:--|
    |`dico.pop(clé)`|Supprime du dictionnaire `dico` le couple clé-valeur associé à `clé` et le renvoie la valeur|`>>> d = {'one': 1, 'two': 2, 'three': 3}`<br>`>>> d.pop('two')`<br>`2`<br>`>>> d`<br>`{'one': 1, 'three': 3}`|
    |`dico.clear()`|Supprime tous les éléments du dictionnaire `dico`|`>>> d = {'one': 1, 'two': 2, 'three': 3}`<br>`>>> d.clear()`<br>`>>> d`<br>`{}`|

-   Ainsi que le mot clé `del`.

    ``` py
    >>> capitale
    {'Allemagne': 'Berlin', 'France': 'Paris', 'Italie': 'Roma'}
    >>> del capitale["Italie"]
    >>> capitale
    {'Allemagne': 'Berlin', 'France': 'Paris'}
    ```

-   Ou encore le dictionnaire entier avec l'instruction `del capitale`, alors la variable `capitale` n'existe plus.


Rappelons d'autres particularités vues en classe de première :
-   Un dictionnaire peut être créé par compréhension.

    ``` py
    >>> carres = {x:x**2 for x in range(10)}
    >>> carres
    {0: 0, 1: 1, 2: 4, 3: 9, 4: 16, 5: 25, 6: 36, 7: 49, 8: 64, 9: 81} 
    ```


- Les dictionnaires, comme les tableaux, sont muables donc les mêmes limites que pour copier un tableau ou passer un tableau en argument d'une fonction s'appliquent pour les dictionnaires.

    ``` py
    >>> d1 = {'one':1, 'two':2, 'three':3}
    >>> d2 = d1
    >>> d2['three'] = 4
    >>> d1 
    {'one':1, 'two':2, 'three':4}
    ```
    `d1` a aussi été modifiée quand on a modifié `d2` ! Les deux variables `d1` et `d2` sont en fait deux noms qui font référence vers le même objet. Pour remédier à ce problème, il faut utiliser aussi la fonction `dict()` qui renvoie un nouveau dictionnaire :

    ``` py
    >>> d1 = {'one':1, 'two':2, 'three':3}
    >>> d2 = dict(d1)
    >>> d2['three'] = 4
    >>> d1 
    {'one':1, 'two':2, 'three':3}
    >>> d2 
    {'one':1, 'two':2, 'three':4}
    ```

    Ou encore utiliser la méthode `.copy()` :

    ``` py
    >>> d1 = {'one':1, 'two':2, 'three':3}
    >>> d2 = d1.copy()
    ```

    :warning: Attention, si le dictionnaire contient des tableaux, on est dans le même cas que les tableaux de tableaux et les deux méthodes ci-dessus ne fonctionnent plus, il faut à nouveau utiliser `deepcopy`.

    :warning: Attention aussi aux dictionnaires passés en paramètre de fonction :

    ``` py
    def test(var):
        print("Adresse de la variable passée en argument: ", hex(id(var))  )
        var['3'] = 3
        print("Adresse de la variable une fois modifiée: ", hex(id(var)))

    dico = {'1': 1, '2':2}
    print("Adresse de la variable dictionnaire: ", hex(id(dico)) )
    test(dico)
    print("dictionnaire=", dico)
    ```

###	Avec un tableau et une fonction de hachage


Commençons par créer une classe `dico`, stockant les valeurs d'un dictionnaire dans un tableau de 100 valeurs :
``` py
class dico:

    def __init__(self):
        self.t = [None] * 100
```

À quelle position du tableau enregistrer les noms de capitale associés à chaque pays ? C'est le rôle d'une fonction de hachage qui permet de transformer la clé, ici le nom du pays, en un indice du tableau. 

!!! abstract "Cours"

    Une fonction de hachage est un algorithme mathématique qui transforme une valeur donnée (par exemple une chaîne de caractère ou un autre type de donnée) en une chaîne alphanumérique, appelée valeur de hachage ou *hash* en anglais. L'opération inverse qui permet de retrouver la valeur initiale à partir de la valeur de hachage est en principe difficile à réaliser.

Il existe des méthodes mathématiques complexes[^6.2] pour définir des fonctions de hachage efficaces. Pour notre exemple, nous utilisons une fonction très simple qui additionne les valeurs Unicode de chaque lettre, le tout modulo 100 :

[^6.2]: 
    Il existe de nombreux algorithme de hachage : 

    -	MD5 : un des premiers algorithmes de hachage, il est aujourd’hui considéré comme peu sûr.
    -	SHA-1  (SHA est l’acronyme de Secure Hashing Algorithm) : il n’est plus recommandé pour le stockage sécurisé des mots de passe car il est sujet à des attaques.
    -	SHA-2 : une famille d’algorithmes de hachage, comprenant SHA-256 et SHA-512. Plus sécurisé que SHA-1, il est aussi très utilisé en cryptographie, par exemple, le Bitcoin utilise SHA-256.
    -	NTLM : utilisé dans les environnements Microsoft Windows.


``` py
def hachage(chaine):
    hash = 0
    for c in chaine:
        hash += ord(c)
    return hash % 100
```

![Transformation de la clé `Allemagne` par une fonction de hachage](assets/6-allemagne-fonction-hachage-light-mode.png#only-light){width="28%" align="right"}
![Transformation de la clé `Allemagne` par une fonction de hachage](assets/6-allemagne-fonction-hachage-dark-mode.png#only-dark){width="28%" align="right"}

Le nombre renvoyé par cette fonction de hachage sera l'indice dans le tableau. Par exemple, la capitale de la France sera stockée dans le tableau à la position d'indice 91, la capitale de l'Allemagne à l'indice 2, etc. :

``` py
>>> hachage('France')
91
>>> hachage('Allemagne')
2
```



Ajoutons les primitives d'un dictionnaire à la classe `dico` :
``` py
class dico:

    def __init__(self):
        self.t = [None] * 100
        

    def ajouter(self, cle, valeur):
        self.t[hachage(cle)] = valeur

    def lire(self, cle):
        return self.t[hachage(cle)]

    def supprimer(self, cle):
        self.t[hachage(cle)] == None

    def taille(self):
        l = 0
        for elem in self.t:
            if elem is not None: l += 1
        return l

    def est_vide(self):
        return self.taille() == 0

```
et créons le dictionnaire des capitales :
``` py
capitale = dico()
capitale.ajouter('France', 'Paris')
capitale.ajouter('Allemagne', 'Berlin')
print(capitale.lire('France'))
```

Il y a une « collision » quand la fonction de hachage n'est pas assez performante, comme ici, et renvoie le même hash pour deux clés différentes :

``` py
>>> hachage("Danemark")
3
>>> hachage("Irlande")
3
```

Dans ce cas il faut penser à gérer la collision, par exemple l'indice correspondant à plusieurs clés peut pointer vers une liste chaînée contenant toutes les clés-valeurs partageant ce même indice.


