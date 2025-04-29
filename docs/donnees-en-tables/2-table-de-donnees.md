# Table de données

La notion de table est apparue dans les années 1970 chez IBM avec l'algèbre relationnelle. Les tables de données, stockées dans des bases de données relationnelles deviennent rapidement le moyen le plus rependu de stocker et traiter de l'information structurée. 

!!! abstract "Cours" 
    Une table de données est un ensemble d'éléments organisés sous forme d'une table :
    
    -	où chaque **ligne** correspond à un **élément**, appelé aussi une **entité** ou une **entrée** de la table,
    -	où chaque **colonne** correspond à une catégorie d'information de même type, appelé un **champs** ou **attribut**. 

Exemple : une liste d'information sur les pays utilisée au chapitre 'Types construits':

|Pays|Capitale|	Population (ml)|
|:-:|:-:|:-:|
|France|Paris|68|
|Allemagne|Berlin|82|
|Italie|Rome|60|


!!! abstract "Cours" 
    Les noms des colonnes, ici Pays, Capitale et Population (ml), sont appelés les **descripteurs** de la table.

De nombreux formats de fichiers sont utilisés pour stocker des donnéess en table : txt, csv, json, excel, etc. 


##	Le format csv

!!! abstract "Cours" 
    Le format **csv**, pour ***Comma-Separated Values***, est un format texte représentant des données en table séparées par des virgules (comme son nom l'indique) ou d'autres séparateurs, par exemple point-virgule (« `;` »), tabulation (« `\t` »), etc. 

Chaque ligne du texte correspond à une ligne du tableau et les virgules correspondent aux séparations entre les colonnes. Un fichier csv est un fichier texte mais on utilise l'extension .csv pour indiquer la nature de ses données.

Exemple : Reprenons la table des pays, en fichier csv on écrit dans un fichier texte.

```py
Pays,Capitale,Population (ml)
France,Paris,68
Allemagne,Berlin,82
Italie,Rome,60
```

Le format csv est un format de fichier texte, ouvert qui peut être créé, lu et modifié par tous les logiciels, en particulier des éditeurs de texte (bloc note), mais aussi des tableurs comme Microsoft Excel[^2.1] ou OpenOffice Calc.

Il existe d'autres formats de données structurées, par exemple JSON ou XML.

[^2.1]: Avec le menu Fichier/Ouvrir puis utiliser la fenêtre « Assistant d'importation du texte » pour choisir le séparateur utilisé ou Données/Récupérer des données externes/fichier texte.

##	Ecrire une table de données dans un fichier csv

Un fichier csv est un simple fichier txt, on écrire la table des pays dans un fichier csv de la même façon que dans un fichier texte en séparant les données par une virgule (par exemple) et les lignes par `\n` :

``` py
f = open("pays.csv", "w")              # si pays.csv n'existe pas, il est créé
f.write('Pays,Capitale,Population (ml)\n')
f.write('France,Paris,68\n')
f.write('Allemagne,Berlin,82\n')
f.write('Italie,Rome,60\n')
f.close()
```

##	Lire une table de données depuis un fichier csv

On peut lire les données depuis un fichier csv (ou un autre type de fichier tabulé) et enregistrer les données dans un tableau de tableaux en le lisant ligne par ligne :


=== "f = open()"
    ``` py
    f = open("pays.csv", "r")
    pays = []
    for li in f:
        pays.append(li.split(','))
    f.close()

    ```

=== "with open as f:"
    ``` py
    with open("pays.csv", "r") as f:
        pays = []
        for li in f:
            pays.append(li.split(','))
     ```

ou même par compréhension :

=== "f = open()"
    ``` py
    f = open("pays.csv", "r")
    pays = [li.split(',') for li in f]
    f.close()
    ```

=== "with open as f:"
    ``` py
    with open("pays.csv", "r") as f:
        pays = [li.split(',') for li in f]
     ```

On obtient le tableau de tableaux suivant:

``` py
>>> pays
[['Pays', 'Capitale', 'Population (ml)\n'],
 ['France', 'Paris', '68\n'],
 ['Allemagne', 'Berlin', '82\n'],
 ['Italie', 'Rome', '60\n']]
```

On peut utiliser `li[ :-1]` pour supprimer les retours à la ligne « `\n` »[^2.2]::

[^2.2]: Ou encore en utilisant la méthode `splitlines()` on peut écrire `>>> pays = [li.split(',') for li in f.read().splitlines()]`.

=== "f = open()"
    ``` py
    f = open("pays.csv", "r")
    pays = [li[:-1].split(',') for li in f]
    f.close()
    ```

=== "with open as f:"
    ``` py
    with open("pays.csv", "r") as f:
        pays = [li[:-1].split(',') for li in f]
     ```


On obtient alors le tableau suivant :

``` py
>>> pays
[['Pays', 'Capitale', 'Population (ml)'],
 ['France', 'Paris', '68'],
 ['Allemagne', 'Berlin', '82'],
 ['Italie', 'Rome', '60']]
```

Et si on veut supprimer la première ligne si elle contient les titres de colonnes, il suffit d'ajouter `f.readline()` après l'ouverture du fichier : 

``` py
f = open("pays.csv", "r")
f.readline()
pays = [li[:-1].split(',') for li in f]
f.close()	with open("pays.csv", "r") as f:
    f.readline()
    pays = [li[:-1].split(',') for li in f]
```


!!! question "Exercice corrigé" 
    Importer dans un tableau de tableaux les données du fichier des codes postaux depuis [https://www.data.gouv.fr/fr/datasets/base-officielle-des-codes-postaux/](https://www.data.gouv.fr/fr/datasets/base-officielle-des-codes-postaux/).

??? Success "Réponse"

    Une fois les données sauvegardées dans le ficher "laposte_hexasmal.csv" dans le répertoire "documents", on peut les visualiser par exemple dans le blocnote, dans Excel ou sur le site internet directement. On remarque que :
    
    -	la première ligne du fichier contient les six descripteurs de données (Code_commune_INSEE,  Nom_commune, …)
    -	les séparateurs sont des points-virgules

    ``` py
    f = open("laposte_hexasmal.csv", "r)   # on ouvre le fichier en lecture 
    f.readline()      # on lit la 1ere ligne de descripteur séparément
    codes = []
    for li in f: 
        codes.append(li[:-1].split(';'))

    # ou alors par comprehension:
    codes2 = [li[:-1].split(';') for li in f]   

    f.close()           # ne pas oublier de fermer le fichier
    >>> codes
    [['90093',
    'SERMAMAGNY',
    '90300',
    'SERMAMAGNY',
    '',
    '47.687801557,6.8309146345\n'],
    …
    ```

De la même façon qu'on a importer des données en table dans un tableau de tableaux, on peut très bien les importer dans un tableau de p-uplets (pour avoir des données de types différents)[^2.3] ou un tableau de dictionnaires (pour utiliser les descripteurs)[^2.4].

[^2.3]:
    Par exemple avec le code suivant :
    ```py
    f = open("pays.csv", "r")
    descripteurs = f.readline().split( ',')         # ligne de descripteurs traitée séparément

    pays = []
    for li in f:
        tab = li[:-1].split(',')
        puplet = (tab[0], tab[1], int(tab[2]))     # la population est convertie en int
        pays.append(puplet)
    f.close()
    ```


[^2.4]: 
    Par exemple avec le code suivant :
    ```py
    f = open("/pays.csv", "r")
    descripteurs = f.readline()[:-1].split( ',')

    pays = []
    for li in f:
        dico = {descripteurs[0] : li.split(',')[0] ,
                descripteurs[1] : li.split(',')[1],
                descripteurs[2] : int(li.split(',')[2][:-1])  
            }
        pays.append(dico)
    f.close()
    ```

##	Lire et écrire dans un fichier csv avec le module csv

Le module Python `csv` permet de lire et écrire facilement des données en table dans un fichier csv.

On commence par créer un objet permettant l'écriture dans le fichier avec la fonction `writer()` du module `csv`. `writerows()` [^2.5]   permet ensuite d'écrire un tableau de tableaux directement dans un fichier csv :

[^2.5]: Ne pas confondre avec `writerow()` qui permet d'écrire ligne par ligne.

``` py
import csv

pays= [ ['Pays', 'Capitale', 'Population (ml)'],
        ['France', 'Paris', 68],
        ['Allemagne', 'Berlin', 82],
        ['Italie', 'Rome', 60]]

with open('pays.csv', 'w', newline='') as f:
    ecriture = csv.writer(f, delimiter=';')
    ecriture.writerows(pays)
```

Noter qu'à l'ouverture du fichier avec `open()`, il faut indiquer le paramètre `newline=''` sinon des sauts de lignes supplémentaires seront ajoutés entre les lignes.

De la même façon en lecture, il faut créer un objet de lecture avec la fonction`reader()`.

``` py
import csv

with open('pays.csv', 'r', newline='') as f:
    lecture = csv.reader(f, delimiter=';')
```
`lecture` est un objet qui ne peut pas être affiché directement : 

``` py
>>> lecture
<_csv.reader object at 0x00000224603A0BE0>
```

Mais on peut le parcourir, on dit que c'est un objet « itérable » : 

``` py
    for ligne in lecture:
        print(ligne)
```
ou le convertir en tableau avec `list()` :

``` py
import csv

with open('pays.csv', 'r', newline='') as f:
    donnees = list(csv.reader(f, delimiter=';'))
```
On obtient un tableau de tableaux :

``` py
>>> donnees
[['Pays', 'Capitale', 'Population (millions)'],
 ['France', 'Paris', '68'],
 ['Allemagne', 'Berlin', '82'],
 ['Italie', 'Rome', '60']]
```

:warning: À noter que toutes les valeurs sont au format `str`, y compris les nombres, il faudra en tenir compte dans l'utilisation de ces données par la suite programme.

Le tableau de tableaux, n'est pas toujours idéal, en particulier la première ligne de descripteurs n'est pas séparée du reste des données.  La méthode `DictReader` permet de garder les descripteurs en créant un tableau de dictionnaires. 


``` py
import csv

with open('pays.csv', 'r', newline='') as f:
    donnees = list(csv.DictReader(f, delimiter=','))
```

On obtient ici un tableau de dictionnaires :

``` py
>>> donnees
[{'Pays': 'France', 'Capitale': 'Paris', 'Population (millions)': '68'}, {'Pays': 'Allemagne', 'Capitale': 'Berlin', 'Population (millions)': '82'}, {'Pays': 'Italie', 'Capitale': 'Rome', 'Population (millions)': '60'}]
```

On trouvera de nombreuses fonctionnalités dans le module `csv`[^2.6]:. 

[^2.6]: Voir : [https://docs.python.org/fr/3/library/csv.html](https://docs.python.org/fr/3/library/csv.html)


!!! question "Exercice corrigé" 
    Importer dans un tableau de dictionnaires les données du fichier des 197 pays et capitales [https://www.data.gouv.fr/fr/datasets/base-officielle-des-codes-postaux/](https://www.data.gouv.fr/fr/datasets/base-officielle-des-codes-postaux/).

??? Success "Réponse"


    ``` py
    import csv

    with open("laposte_hexasmal.csv", 'r', newline='') as f:
        codes = list(csv.DictReader(f, delimiter=';'))
    >>> codes
    [{'Code_commune_INSEE': '90093',
    'Code_postal': '90300',
    'Libelle_acheminement': 'SERMAMAGNY',
    'Ligne_5': '',
    'Nom_commune': 'SERMAMAGNY',
    'coordonnees_gps': '47.687801557,6.8309146345'},
    {'Code_commune_INSEE': '91093',
    'Code_postal': '91470',
    'Libelle_acheminement': 'BOULLAY LES TROUX',
    …
    ```
