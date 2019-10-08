# DR_SetTimeOut
Developpé afin de pouvoir temporiser certain evenement d'un programme

## Usage
S'utilise en ligne de code uniquement
- Créer un object DR_setTimeOut
```
DR_SetTimeOut.new(timeSeconde : float, node : Node, functionName : String);
```

# Parametre
- timeSeconde : le delai en seconde avant lancement de l'evenement
- node : le node qui possede la fonction a déclancher
- la fonction à déclancher

L'objet DR_SetTimeout est autamatiquement détruit après déclanchement de l'evenement.
DR_SetTimeout est automatiquement ajouté en child du node en parametre, ce qui implique
que si ce node est détruit alors DR_SetTimeout ne se déclanchera pas. 
