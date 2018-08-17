---
title: Ludum Dare #42, un rapide post mortem
subtitle: Encore et toujours 72h pour créer un jeu vidéo
date: 2018-08-17
tags: gamedev, post-mortem
description: Qu'est-ce que je peux tirer de cette Ludum Dare #42&nbsp;?
---

La version originale de ce post mortem est disponible sur le site de la [Ludum Dare](https://ldjam.com/events/ludum-dare/42/trackblasters/ludum-dare-42-a-quick-post-mortem).  
Original version is available on the [Ludum Dare](https://ldjam.com/events/ludum-dare/42/trackblasters/ludum-dare-42-a-quick-post-mortem) website.

### Et le thème est…

Samedi, 00:00.  
Pendant que [ldjam.com](https://ldjam.com) est hors ligne parce que beaucoup trop de monde veut connaître le thème, je vais sur [Twitter](https://twitter.com/pauljoannon) et lis: *«Running out of space»* (*«Être à cours de place»*). Seul chez moi, je suis sur Discord avec mes coéquipiers [Kokonaught](https://twitter.com/Kokonaught) et [Noojsan](https://twitter.com/Noojsan).

Rapidement, on a une idée qui nous plaît: l'histoire d'un body-builder vivant dans un minuscule appartement dont la vie devient de plus en plus difficile alors qu'il devient de plus en plus gros. Au niveau du gameplay ce serait un jeu avec des mini-jeux très rapides, un peu comme un WarioWare.  
Histoire de garder d'autres options ouvertes on continue à discuter d'autres idées, l'une d'elles est à propos de personnages vivant sur des îles flottant dans le ciel qui sont obligés de jeter des affaires par dessus bord pour éviter de couler.  

![](/content/blog/2018/08/post-mortem-trackblasters/bodybuilder.gif)

Après un moment à discuter on a décidé de partir sur cette seconde idée. La première, reposant trop sur le nombre de mini-jeux pour être marrante, semblait moins accessible pendant une jam.  

Il est maintenant 02:00 et je vais me coucher histoire de me commencer à travailler de bonne heure.

### Le doute

Je me lève vers 07:00 et commence à mettre en place les fondations de notre jeu&nbsp;: une carte isométrique dont les tuiles disparaissent, un personnage qui peut se déplacer et soulever et lancer des trucs.  
Peu de temps après mon déjeuner, mes coéquipiers sont de nouveau avec moi (on est dans deux zones horaires différentes donc nos rythmes sont decalés). Une fois qu'on est de nouveau ensemble il se passe quelques chose de terrible&nbsp;: **le doute** entre en jeu. Peu importe combien de temps on réfléchit, on n'arrive pas à trouver un moyen de faire quelques chose de marrant et d'agréable à jouer avec cette idée…  

<!--more-->

Donc on est de retour au point de départ (merci de ne pas passer par la case départ et de ne pas toucher 20 000 francs). C'est le milieu de mon samedi après-midi et on a pas vraiment démarré. Tout va bien.    

On a droit à quelques heures de déprime et de découragement.

### Une révélation

Samedi, 16:00.  
Une nouvelle idée de jeu apparaît&nbsp;! Disons qu'on fait un jeu de courses en 2D, une sorte d'hommage à *Micro Machines*, où la place disponible sur la piste diminue pendant la course. Ce ne serait pas cool&nbsp;? Ça ne pourrait pas donner quelques chose de marrant et agréable à jouer&nbsp;? Si&nbsp;?  

Alors faisons ça&nbsp;!  

![](/content/blog/2018/08/post-mortem-trackblasters/first-sprite.gif)  

Commencer n'est pas très compliqué. Je programme rapidement les mouvements des voitures, rien de très élaboré. Tous les développeurs utilisant [Godot Engine](https://godotengine.org) savent déjà ce que je vais utiliser comme placeholder.

Pendant ce temps, mes camarades font leur magie et créent les premiers assets.  
Pour la blague, on se dit que la musique devrait être de la bonne vieille techno makina. Tous ceux qui ont joué au jeu savent comment tout ça va se terminer.

![](/content/blog/2018/08/post-mortem-trackblasters/first-thing-moving.gif)

On a décidé que la piste était détruite constamment par des bombs que les voitures jettent automatiquement derrière elles quand elles roulent. Pendant la soirée on met en place le système d'autotiling qui gère les trous que font ces bombes dans le sol.  
Quand je vais me coucher, les mécaniques de base et les contrôles sont en place. Il reste deux jours.  

### Le dimanche sera tranquille

Quand je me lève après une bonne nuit de sommeil, je suis accueilli sur Discord par une maquette assez cool de ce à quoi le jeu ressemblera. J'en fais un rapide [billet](https://ldjam.com/events/ludum-dare/42/$101479/good-morning-from-the-desert-lands) avant de me remettre au travail.  

Notre dimanche n'est pas vraiment intéressant. Je met en place quelques trucs en plus&nbsp;: faire en sorte que les voitures tombent dans les trous, préparer un peu les contrôles et la caméra multijoueurs, etc.  
Les éléments graphiques et la musique avancent rapidement. Noojsan fait des tests en ajoutant des instruments berbères à la musique pour lui donner une petite *ambiance désert*, et on fait une liste des effets sonores dont on va avoir besoin.  
Je prends aussi un peu de temps pour expliquer comment les animations marchent dans notre moteur, grâce à plein de captures d'écran de ce style&nbsp;:  

![](/content/blog/2018/08/post-mortem-trackblasters/animation-explanation.jpg)

Pendant cette soirée on a aussi décidé qu'il était temps de trouver un nom. Contrairement à d'habitude, on s'est mit d'accord assez rapidement. Voilà la transcription complète de cette discussion&nbsp;:

> Kokonaught: Vous avez des idées de nom sinon&nbsp;?  
> paulloz: Bah, pour l'instant ça s'appelle **Micro Bombs**  
> paulloz: mais c'est ps fou  
> Kokonaught: Je sais pas, il faudrait le mot *blast*  
> Kokonaught: Genre  
> paulloz: **TRACKBLASTERS**  
> Kokonaught: ouais  
> Kokonaught: vendu

Avec ça expédié, je peux travailler sur d'autres trucs comme faire un menu de pause et quelques transitions entre les écrans. Ces transitions sont faites avec un simple shader qui lis un dégradé allant du noir vers le blanc dans un fichier PNG. C'est super facile et rapide et peut donner beaucoup de personnalité à un jeu.  

![](/content/blog/2018/08/post-mortem-trackblasters/pause-and-fall.gif)

C'est la fin du deuxième jour. Avant d'aller dormir j'explique à Kokonaught comment fonctionne les tilemaps dans le moteur. Histoire qu'il crée quelques pistes si il a le temps. Encore une fois, mes explications sont assistées de pas mal de captures d'écran de qualité.

### Aube du dernier jour

Mon dernier jour de LDJam commence avec un gros paquet de fichiers OGG&nbsp;: tous les fichiers audio sont là et il est temps de les intégrer dans le jeu.  

![](/content/blog/2018/08/post-mortem-trackblasters/music-commit.jpg)

Il me reste deux gros trucs à faire&nbsp;: connecter les courses entre elles avec un écran de fin de course entre chaque, et faire un menu de sélection de course. Après ça, ce sera une affaire de polish et, si possible, d'ajouter quelques petits trucs.  

L'écran de fin de course est plutôt simple&nbsp;: on utilise le même écran que le menu pause et on en change le contenu.  

Le menu de sélection est complètement différent mais pas vraiment compliqué. J'ai besoin d'un petit shader pour que le motif de fond défile éternellement, d'une grille contenant toutes les courses et de connecter quelques inputs pour basculer vers la bonne scène. Terminé&nbsp;!  

Qu'est-ce que je n'ai pas encore fait&nbsp;? Ouais&nbsp;! Un écran titre. C'est super simple, je peux attendre jusqu'à ce que les assets soient terminés.  
Il faut qu'on affiche un chronomètre pendant la course.  Aussi, ce serait bien d'ajouter un *Tut Tut Tuuuuuut* au début des courses comme dans tous les autres jeux de course existants&nbsp;! Je vais faire ces deux trucs.

*Note&nbsp;: c'est probablement à cet instant qu'on aurait dû penser à ajouter une ligne visible pour marquer la fin des tours de piste.*

Attend&nbsp;!  
Il faut mettre une ombre sous la voiture&nbsp;!  
Et la musique est trop forte par rapport aux effets sonores, met la à -6dB&nbsp;!  
On a des éléments à ajouter sur les pistes&nbsp;!  
L'écran titre est fait, il faut mettre les visuels dans le jeu&nbsp;!  

C'est la dernière ligne droite et je jongle maintenant avec deux artistes qui veulent peaufiner leur travail autant que possible.  
Je peux le faire. On peut le faire&nbsp;!  
Pendant ce temps on ajoute des éléments sur les pistes pour qu'elles soient un peu moins ennuyeuses, bien sûr.  

### C'est terminé

**M I N U I T&nbsp;!**  
On est passé à travers les deux dernières heures comme si c'était des minutes, mon cœur bat à environ 300bpm mais c'est terminé. Et je pense qu'on a fait un truc pas mal. Au moins, je suis content de ce qu'on a fait. Et c'est loin d'être toujours le cas.  

![](/content/blog/2018/08/post-mortem-trackblasters/final-screenshot.jpg)

On met en ligne la version finale sur [itch.io](https://mysweetwhomp.itch.io/trackblasters), faisant des captures d'écran et écrivant une description du jeu pendant que le site [ldjam.com](https://ldjam.com) implose et s'apprête à se transformer en cendres.  

Première chose que je remarque une fois que **Trackblaster** est en ligne et que le stress final s'estompe&nbsp;: comme d'habitude je n'ai pas envie de dormir tout de suite, mais au moins il n'est pas encore 03:00. Merci pour ce nouvel horaire, j'espère que ça restera comme ça.  
Qu'est-ce que je peux tirer de cette Ludum Dare&nbsp;? Ce n'est pas forcément une bonne idée de commencer à développer après que plus d'une demi journée ne se soit écoulée. D'un autre côté je suis heureux qu'on ne se soit pas accroché à une idée qui ne nous plaisait pas vraiment juste à cause d'un problème de temps. Et quelle que soit la durée de la jam, on peut toujours prévoir un jeu pour qu'il soit faisable dans le temps imparti.  
Je suis content de ce qu'on a fait, ce n'est vraiment pas quelques chose que je dis après toutes les jam. Et je vais probablement travailler dessus et sortie une vraie version dans un futur proche.  
