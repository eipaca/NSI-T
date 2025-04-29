# Rechercher dans une table

##	Recherches simples

### Dans un tableau de de tableaux ou tableau de p-uplets

Un tableau de tableau ou tableau de p-uplets est itérable avec l'instruction `for … in …` et on peut chercher un élément avec le mot clé `in`. Une recherche est donc très simple.

Reprenons notre tableau de p-uplets de pays et cherchons dans quel pays se trouve 'Rome' :

``` py
pays = [('France', 'Paris', 68), 
        ('Allemagne', 'Berlin', 82),
        ('Italie', 'Rome', 60)]
for ligne in pays:
    if 'Rome' in ligne:
        print('Rome est en ', ligne[0])
```

Pour comprendre ce qu'il se passe, ici `ligne` itère sur chaque ligne de `pays` prenant tour à tour les valeurs des p-uplets  :

``` py
('France', 'Paris', 68)
('Allemagne', 'Berlin', 82)
('Italie', 'Rome', 60)
```

Et pour chaque p-uplet, l'instruction conditionnelle `if 'Rome' in ligne` vérifie si `'Rome'` est présent ou pas. 

###	Dans un tableau de dictionnaires

Un tableau de dictionnaires est aussi itérable avec l'instruction `for … in …` mais par défaut le mot clé `in` vérifie l'existence d'un élément **dans les clés du dictionnaire, pas dans les valeurs**. Il faut donc préciser que l'on recherche l'élément recherché parmi les valeurs du dictionnaire avec la méthode `.values()`. 

Cherchons dans quel pays se trouve 'Rome'.

``` py
pays = [{'Capitale': 'Paris', 'Pays': 'France', 'Population (ml)': 68},
        {'Capitale': 'Berlin', 'Pays': 'Allemagne', 'Population (ml)': 82},
        {'Capitale': 'Rome', 'Pays': 'Italie', 'Population (ml)': 60}]
for ligne in pays:
    if 'Rome' in ligne.values():
        print('Rome est en ', ligne['Pays'])
```

ou alors on peut préciser la clé dans laquelle on veut faire la recherche, par exemple ici on peut chercher 'Rome' dans les valeurs associées à la clé `'Capitale'` :

``` py
for ligne in pays:
    if ligne['Capitale']  == 'Rome':
        print('Rome est en ', ligne['Pays'])
```



!!! question "Exercice corrigé" 
    En pratique: En utilisant le tableaux de dictionnaires des codes postaux précédent, écrire une fonction qui renvoie :
    1. le code postal d'une ville	
    2. un tableau des villes ayant un code postal donné

??? Success "Réponse"


    ``` py
    def chercher_code(codes_postaux, ville ):
        for ligne in codes_postaux: 
            if ligne['Nom_commune'] == ville:
                return ligne['Code_postal'] 


    def chercher_villes(codes_postaux, code ): 
        villes = [] 
        for ligne in codes_postaux:
            if ligne['Code_postal'] == code:
                villes.append(ligne['Nom_commune'])
        return villes 
        
    ```



##	Recherches conditionnelles

Pour un tableau de tableaux,  de p-uplets ou de dictionnaires, le mot clé `in` ne suffit plus pour tester la présence d'un élément avec des conditions. Il faut tester les conditions sur chacun des tableaux, p-uplets ou dictionnaires.

Reprenons notre tableau de p-uplets de pays et cherchons les pays qui ont plus de 65 millions d'habitants :

``` py
pays = [('France', 'Paris', 68),
        ('Allemagne', 'Berlin', 82),
        ('Italie', 'Rome', 60)]
for ligne in pays:
    if ligne[2] > 65: 
        print(ligne[0], 'a plus de 65 millions d'habitants')
```

!!! question "Exercice corrigé" 
    En utilisant le tableaux de dictionnaires des codes postaux précédent , écrire une fonction qui renvoie :

    1. le tableau de toutes les villes d'un département	
    2. Toutes les villes qui commencent par ‘MAN'

??? Success "Réponse"

    ``` py
    def chercher_departement(table_code, dep ):
        villes = []
        for li in table_code:
            if li['Code_postal'] >= dep * 1000 and li['Code_postal'] < (dep+1) * 1000:
                villes.append( li['Nom_commune'] )
        return villes
    >>> chercher_departement(c,13)
    ['MARTIGUES',
    ….
    'ST ANDIOL',
    'SAUSSET LES PINS',
    'MARSEILLE 09']

    def chercher_MAN(table_code):
    villes = []
    for li in table_code:
        if li['Nom_commune'][0:3] == 'MAN':
            villes.append( li['Nom_commune'] )
    return villes
        
    ```


## 	Tests de cohérence et recherche de doublons

Jusqu'ici on a fait l'hypothèse que tous les champs du fichier sont remplis et corrects sans vérifier leur cohérence. Ce n'est pas toujours le cas et un fichier mal renseigné, ou avec des valeurs vides peut ensuite générer des problèmes. 
Pour l'éviter, on peut faire des tests de cohérence, par exemple vérifier que tous les noms de villes sont renseignés et qu'aucun n'est laissé vide (comme les coordonnées GPS)

``` py
def coherence_villes(table_code):
    for li in table_code:
        if li['Nom_commune'] == '':
            return False
    return True

>>> coherence_villes(importer())
True
```

On peut aussi rechercher des doublons dans la table. Par exemple , on a fait l'hypothèse au paragrpahe 3.1 qu'une ville n'apparait qu'une fois (et donc n'a qu'un code postal), mais on ne l'a pas testé.
La table n'est pas triée, il faut donc tester toutes les possibilités de doublons :

``` py
def chercher_doublons(table_code):
    for i in range(len(table_code)-1):
        for j in range(i+1, len(table_code)) :
            if table_code[j]['Nom_commune']  == table_code[i]['Nom_commune']:
                print(table_code[i]['Nom_commune'], 'apparait à la ligne', i, 'et', j)
```

On s'aperçoit qu'il y a énormément de doublons dans cette table. Par exemple CHAMONIX MONT-BLANC apparait plusieurs fois (avec le même code postal) ou CHALAIS apparait plusieurs fois dans des département différents.
