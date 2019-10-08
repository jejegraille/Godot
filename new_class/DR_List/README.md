# DR_List 
Developpé afin de créer et manipuler une structure de donné en listes chainés


## Usage
- Créez une liste
```
var list = DR_List.new();
```
- Ajoutez du contenus à la liste
```
list.addToList(content);

------------or------------------

var elem = DR_ListElem.new(content);
list.addToList(elem);
```
- Naviguez dans la liste:
```
var tmp = list.start;
while tmp != null:
  var content = tmp.content as ClassName # for autocompletion;
  #DoSomething
  tmp = tmp.next;
```
- Supprimer un element de la liste:
```
var tmp = list.start;
while tmp != null:
  var content = tmp.content as ClassName # for autocompletion;
  #Détect remove condition
  list.removeFromList(tmp);
  tmp = tmp.next;
  
------------or------------------
 
 list.removeFromList(content);
```
- Obtenir l'element ou le contenus à l'index i:
```
var elem = list.getListElemAt(0);
var content = list.getContentAt(0);
```
- Inverser la position de deux elements:
```
list.invertElem(elmA, elmB);
```
- Savoir si la liste est bouclé:
```
list.isLooped();
```

## Propriétés
- list.start : Le premier élement de la list
- list.last : Le dernier élement de la list (get seulement)
