---
title: Fin de prod' abrupte pour «Enterre-moi, mon amour»
subtitle: Un post-mortem un brin égocentré
tags: gamedev, post-mortem
date: 2017-12-11
description: Fin octobre dernier sortait «Enterre-moi, mon amour», le jeu auquel j'ai dédié une grosse partie de cette dernière année. Je pense qu'il est plus que temps pour réfléchir et écrire un peu sur cette expérience, et plus précisément sur la fin de production qui a malheureusement été un peu abrupte pour moi.
---

Enfin, comme on me le faisait remarquer alors que j'écrivais ces premières lignes, un post-mortem n'est-il pas toujours un minimum égocentré&nbsp;?  

Quoi qu'il en soit, fin octobre dernier sortait *[Enterre-moi, mon amour](http://enterremoimonamour.fr/)*, le jeu auquel j'ai dédié une grosse partie de cette dernière année. Pour ceux qui seraient passé au travers, *[Enterre-moi, mon amour](http://enterremoimonamour.fr/)* est un jeu d'aventure sur smartphone. On y suit le périple vers l'Europe de Nour, une migrante syrienne, à travers sa discussion SMS avec son mari Majd, resté en Syrie.   

Je pense qu'il est plus que temps pour moi de réfléchir et écrire un peu sur cette expérience, et plus précisément sur la fin de production qui a malheureusement été un peu abrupte pour moi.

![](/content/blog/2017/12/fin-de-prod-abrupte/bmml.jpg)

<!--more-->

Je vais quand même commencer par le calendrier, dans les grandes lignes.  
Mes premiers échanges avec [Florent](https://twitter.com/ThePixelHunt) à propos de ce jeu datent de mars 2016, la production à proprement parler a démarré en octobre 2016 et le jeu est sorti fin octobre 2017. En ce qui me concerne la production de *[Enterre-moi, mon amour](http://enterremoimonamour.fr/)* a donc duré à la louche douze mois. C'est ce qui semblerait de l'extérieur mais en fait non, pour moi la production s'est plus ou moins terminée mi août 2017 avec un double passage à l'hôpital suivi d'une impossibilité de travailler sérieusement (qui plus est dans un semblant de crunch) avant la sortie du jeu.  

Autant je ne vois pas bien ce que je pourrais raconter d'intéressant sur le corps de la production qui, j'imagine, était somme toute assez banal&nbsp;: des hauts, des bas, des périodes de grand contentement par rapport à ce qu'on fait jour après jour entrecoupées de périodes de désespoir profond.

Autant je pense (et j'espère) que ma situation sur la fin du projet n'arrive pas dans toutes les productions vidéoludiques et mérite que je m'y repenche un peu.  
Je ne vais pas détailler maintenant les problèmes de santé qui ont mené à cette situation, ce n'est pas vraiment le sujet (et j'ai déjà fait un [gros thread](https://twitter.com/pauljoannon/status/897521498398871553) qui raconte tout ça), mais le déroulé et mon ressenti sont sans doute un minimum intéressants.  

Alors qu'une partie de l'équipe du jeu s'accorde une dernière possibilité de vacances, je fais un passage dans le service d'urgences d'un hôpital parisien. Passage qui sera suivi d'une première semaine (ou un peu moins) d'hospitalisation. Premières sueurs&nbsp;: une semaine en moins sur le calendrier c'est pas rien et ça va décaler pas mal de trucs mais bon on ne s'affole pas, ce n'est pas non plus injouable.  

Le stress du projet s'ajoute à la fatigue générale. D'autant plus quand à ma sortie on me dit de me reposer, sans travailler, au moins jusqu'au mois septembre. Entre trois semaines et un mois de moins sur une fin de projet de dix ou douze mois, ça commence à faire beaucoup.

![](https://media.giphy.com/media/VB5WwlZIt8eRy/giphy.gif)

Mais les emmerdes ne s'arrêtent pas là pour autant. Une semaine passe et rebelote&nbsp;: hôpital, fatigue, arrêt de travail à durée indéterminée... Bref, on est dans le noir total quant au fait que je puisse terminer mon travail sur le jeu et ça, ça pue grave.  
Du coup il faut trouver quelqu'un qui peut me remplacer. Une solution simple à imaginer mais compliquée à mettre en place&nbsp;: la fin de production (une des pires périodes, on ne va pas se mentir) à un nouveau développeur peut sembler effrayant pour nous, ça l'est tout autant (si ce n'est plus) pour le développeur en question.  
Par un incroyable alignement des astres, [Florent](https://twitter.com/ThePixelHunt) trouve [la personne parfaite](https://twitter.com/mrhelmut) qui accepte de plonger à l'aveugle pendant plusieurs semaines dans le développement d'un jeu inconnu.

Tant mieux, car je ne reviendrai pas travailler sur ce projet. Le moins que je puisse dire c'est que de vivre un projet comme ça (qui plus est entouré de gens ultra cool) pendant neuf ou dix mois et se voir forcer un abandon avant la fin c'est pas évident à gérer.  

Depuis mon lit je me bas un peu contre mon sentiment de culpabilité en continuant à réfléchir à certains problèmes techniques et en répondant aux quelques questions de dev qu'on veut bien me poser. Mais au delà du fait que je me sente coupable de devoir abandonner la prod, j'ai aussi ce sentiment (un peu déplacé) de me faire voler mon projet.  
Mais au moins le projet avance. Et quand les commentaires que j'ai laissé dans mon code ne suffisent pas, je fais mon possible pour aider comme je peux. Autant pour faire avancer le jeu que pour me sentir un minimum utile.  

![](/content/blog/2017/12/fin-de-prod-abrupte/majd.jpg)

On n'échappe bien sûr pas à quelques déboires. Je n'avais par exemple noté nul part que [mettre à jour notre moteur de jeu](https://github.com/MonoGame/MonoGame/blob/v3.6/CHANGELOG.md) n'était pas une bonne idée puisque j'utilisais une fonctionnalité désormais obsolète. Forcément, cet oubli a mené à l'application de ladite mise à jour et donc à une grosse frayeur au moment où le jeu était totalement cassé.  
Pourtant, au fil des jours et des semaines, le projet avance et mon sentiment de m'être fait spolier mon travail s'efface. J'arrive même à me dire qu'une paire d'yeux fraîche sur le jeu et son code est en fait une bonne chose (ce qui est sans aucun doute vrai).  

Ça aurait pu s'arrêter là, mais le truc c'est qu'après une dernier coup de stress (une sombre histoire de jeu qui ne démarrait pas sur bon nombre de téléphones Android) *[Enterre-moi, mon amour](http://enterremoimonamour.fr/)* est sorti. Et ce bon gros sentiment de me faire voler est revenu de plus belle.  
Sûrement parce que je ne suis pas à Paris pour parler du jeu. Que je ne suis pas présent ni sur [notre stand de la Paris Games Week](https://www.factornews.com/interview/pgw-2017-enterre-moi-mon-amour-page-1-43649.html), ni à Indiecade Europe lorsque l'on reçoit le [Prix des développeurs](http://www.afjv.com/news/8165_indiecade-europe-devoile-le-palmares-de-sa-deuxieme-edition.htm). À la place je vis la sortie de mon premier jeu vidéo commercial depuis chez moi, pendant que le reste de l'équipe s'échine à faire vivre le truc.  

Complètement absent du processus de sortie, j'ai encore un peu de mal à qualifier ce jeu de *mon jeu* ou même *notre jeu*. C'est bizarre, c'est peut-être même idiot...  
Tant pis, tout ça sera pour la prochaine fois.

<div class="separator"></div>

Si vous n'y avez pas encore jeté un œil, *[Enterre-moi, mon amour](http://enterremoimonamour.fr/)* est disponible sur [Google Play](https://play.google.com/store/apps/details?id=com.plug_in_digital.emma) et [iTunes](https://itunes.apple.com/fr/app/bury-me-my-love/id1281473147).
