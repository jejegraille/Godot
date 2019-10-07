# DR_WebSprit 
Développé pour faciliter l'affichage d'images depuis une url http ou https

## Usage :
- Créez un node DR_WebSprite
- Ajoutez l'url de l'image en parametre
- Ajoutez les limites de la taille du sprite si necessaire
- Ajoutez une texture placeholder si necessaire

signal onLoaded se déclanche quand l'image internet est affiché

Afin d'accélléré l'affichage des sprites les fois suivante mais également d'éviter de retélecharger des données inutiles, les imageTexture
généré sont mit en cache.
