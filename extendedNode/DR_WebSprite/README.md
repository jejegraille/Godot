# DR_WebSprite 
Développé pour faciliter l'affichage d'images depuis une url HTTP ou HTTPS

## Usage :
- Créez un node DR_WebSprite
- Ajoutez l'url de l'image en parametre
- Ajoutez les limites de la taille du sprite si necessaire
- Ajoutez une texture placeholder si necessaire

signal onLoaded se déclanche quand l'image internet est affiché

Afin d'accéllérer l'affichage des sprites les fois suivantes mais également d'éviter de retélecharger des données inutiles, les imageTexture généré sont mit en cache.
