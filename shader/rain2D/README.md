## PREVIEW
![preview](https://github.com/jejegraille/Godot/blob/master/shader/rain2D/rain.gif)
![preview](https://github.com/jejegraille/Godot/blob/master/shader/rain2D/snow.gif)
![preview](https://github.com/jejegraille/Godot/blob/master/shader/rain2D/blood.gif)

## SETUP

- créez un sprite avec une texture quelquonque.
- Etirez le sprite sur toute la surface de l'ecrant.
- Ajoutez le sprite en child d'un canvasLayer.
- Ajoutez le shader au sprite
- Synchronisez la position de votre camera au parametre "position" du shader

## PARAMETRES

```
vector2 position: à synchroniser sur la position de la camera pour que l'effet se déplace

Color dropColor:  Couleur des goutes de pluie
Color dropTrailColor : Couleur de la trainé des goutes

float direction : Direction principale des goutes de pluis -1 vers la gauche, 1 vers la droite
float fallSpeed : Vitesse de chute
float dropHeigth : Longueur des gouttes
float dropWidth : Epaisseur des gouttes
float intensity : intensité de la pluie/ Quantité de gouttes
```

