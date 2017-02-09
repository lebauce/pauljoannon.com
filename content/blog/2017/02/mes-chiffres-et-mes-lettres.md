---
title: Mes chiffres et mes lettres
subtitle: Le chiffrement expliqué à tous
date: 2017-02-09
tags: données personnelles
description: Si j'en crois Wikipedia, le chiffrement est «un procédé [...] grâce auquel on souhaite rendre la compréhension d'un document impossible à toute personne qui n'a pas la clé de (dé)chiffrement».
---

![](/content/blog/2017/02/thisisdog.jpg)

J'ai déjà parlé une ou deux fois de [données personnelles](/blog/tags/données%20personnelles.html) sur ce blog et ça fait quelques temps que je veux parler de chiffrement. Le problème c'est qu'autant je peux trouver énormément de papiers&nbsp;/&nbsp;billets sur ce genre de sujet sur Internet, autant ils sont très souvent assez obscurs pour le commun des mortels. Pourtant, c'est un sujet que tout le monde devrait pouvoir appréhender. Du coup je vais essayer de m'y coller, en restant simple mais sans partir dans des analogies nulles.

<!--more-->

## C'est pas juste un truc pour le dark net&nbsp;?
Si j'en crois [Wikipedia](https://fr.wikipedia.org/wiki/Chiffrement), le chiffrement est

> Un procédé [...] grâce auquel on souhaite rendre la compréhension d'un document impossible à toute personne qui n'a pas la clé de (dé)chiffrement». En dédramatisant un peu, voilà la définition qu'on peut en tirer : «le chiffrement est une façon de rendre un document lisible seulement par les personnes voulues.  

C'est bien beau, mais concrètement&nbsp;? Bah concrètement, le chiffrement c'est ce qui fait (ou du moins devrait faire) la base de tout échange d'information sur Internet. C'est, par exemple, grâce à des systèmes de chiffrement que je peux payer un truc avec ma carte bancaire en toute sécurité sur le net. C'est, encore une fois, grâce à des systèmes de chiffrement que je peux me connecter à ma boîte mail sans que ma passphrase ne soit visible de tous.


## De toute façon, je n'ai rien à cacher&nbsp;!
Les systèmes de chiffrement sont donc utiles pour pas mal de choses, mais j'entends encore de temps en temps une de ces phrases nulle à chier.  

> Pourquoi chiffrer mes conversations de tous les jours ? De toute façon ça n'intéresse personne, pourquoi on m'écouterait ? Et puis je n'ai rien à cacher&nbsp;!

Là je m'adresse à toi, qui m'as un jour sorti un truc de ce genre&nbsp;: je ne vais même pas parler du fait que n'avoir rien à foutre de sa vie privée est idiot. Non, je vais plutôt t'expliquer un point vachement plus pragmatique. Et pour ça je suis désolé, il va falloir un léger effort mental.  

Imagine un peu la masse de données qui circulent tous les jours, chiffrées ou non, un peu partout sur les réseaux informatiques. Pour réduire un peu cette représentation, imagine donc la masse de données que tu fais circuler directement ou indirectement&nbsp;: messages, pages web, identifiants, etc. Quel est le meilleur moyen dans cette énorme masse de trouver les données les plus intéressantes&nbsp;? Bingo, ce sont les données chiffrées&nbsp;! Eh ouais&nbsp;!  
En ne chiffrant que les données les plus sensibles, celles-ci sont, de fait, marquées comme intéressantes par rapport au reste.  

Tout chiffrer permet de retrouver une masse d'information homogène. Parce que tout le combat est là&nbsp;: la cryptographie ce n'est pas une défense absolue qui empêchera quiconque d'accéder au données protégées. C'est simplement la recherche de moyens pour rendre le plus compliqué possible l'accès non autorisé à des informations. Foncièrement, tout ce que les systèmes de chiffrement permettent, c'est de gagner du temps.


## Rentrons dans le vif du sujet
Le moment d'être un peu technique est arrivé. Pas d'inquiétude, je m'en tiendrai au nécessaire.  

Le principe de la cryptographie est très simple&nbsp;: je prends un document, par exemple la phrase *«allo ui c chien»*, et je le traduis en un document illisible (*«nyyb hv p puvra»*) avant de le transmettre à quelqu'un qui saura le traduire en sens inverse. Ici, pour l'exemple, j'utilise un algorithme de chiffrement extrêmement simple ([ROT13](https://fr.wikipedia.org/wiki/ROT13), pour ROTation 13) qui traduit chaque lettre en la décalant de treize places dans l'alphabet&nbsp;: *«a»* devient *«n»*, *«b»* devient *«o»* etc. Il est évident que ce système de chiffrement est beaucoup trop simpliste pour être utilisé dans le but de protéger des informations.

Son premier problème&nbsp;: n'importe qui sachant que mon document a été chiffré grâce à cet algorithme peut le déchiffrer. Pour remédier à ça, il faut introduire le principe de clef.  
Une clef est une information qui n'a aucun rapport avec le document que je veux chiffrer, mais sans laquelle il devient impossible d'effectuer la traduction. Si je reprends mon exemple, je pourrais choisir de décaler les lettres dans mon document d'une place (ROT1&nbsp;: *«bmmp vj d dijfo»*), deux places (ROT2&nbsp;: *«cnnq wk e ejkgp»*) etc. Ce nombre, que je choisis arbitrairement, devient ma clef de chiffrement.  

Deuxième problème&nbsp;: le système est symétrique, n'importe qui connaissant la clef peut à la fois chiffrer et déchiffrer le document. C'est problématique dans un certain nombre de situations et, histoire de ne pas digresser, j'expliquerai pourquoi un peu plus bas. Pour remédier à ça, il faut introduire le principe de clef publique et de clef privée&nbsp;: bienvenue dans le monde de la cryptographie asymétrique.  
Sur le papier, c'est encore une fois très simple (bien qu'un peu plus alambiqué). J'ai cette fois-ci deux clefs&nbsp;: si je chiffre mon document avec l'une, je pourrai le déchiffrer avec l'autre. Ce genre de chiffrement repose sur des fonctions mathématiques dites à sens unique. Je ne m'attarderai pas là-dessus maintenant mais si ça intéresse des gens, dites-le moi et je pourrais y consacrer un billet une autre fois (les liens pour me contacter sont sur la gauche, comme d'habitude).  

Me voilà donc avec deux clefs. L'une est publique et servira à m'envoyer des documents chiffrés. L'autre m'est privée, et me permettra de déchiffrer lesdits documents.

Une conversation chiffrée entre deux personnes implique donc quatre clefs en tout&nbsp;: deux publiques et deux privées. Du même coup, un troisième problème est réglé&nbsp;: comment être certain que le document a été chiffré par la personne le prétendant&nbsp;? Je continue, toujours sur le même exemple (attention, ce qui suit est encore une fois assez simplifié).  
Mon chien veut m'envoyer un message d'une importance capitale&nbsp;: *«allo ui c chien»*.  
Il va d'abord utiliser ma **clef publique** afin de **chiffrer** ce message et le rendre illisible à toute personne ne possédant pas ma **clef privée** (donc à toute autre personne que moi).  
Il va ensuite utiliser sa **clef privée** sur le message **chiffré** afin de le **signer**.  
En recevant ce message illisible, je me sers donc de la **clef publique** de mon chien pour le **déchiffrer** une première fois. Seuls les documents **chiffrés** avec la **clef privée** de mon chien peuvent être **déchiffrés** grâce à celle-ci, je suis donc sûr de l'expéditeur de ce message.  
Enfin, je peux **déchiffrer** totalement le message avec ma **clef privée** et en découvrir le contenu&nbsp;: *«allo ui c chien»*.

Ce processus permet donc&nbsp;:

 * aux deux côtés de la conversation d'être sûrs et certains qu'ils sont les seuls à avoir accès à son contenu.
 * aux deux côtés de la conversation d'être sûrs et certains que l'autre côté est bien qui il prétend être.


Le système repose sur un réseau de confiance, et dépend donc de plusieurs conditions très importantes&nbsp;:

* Une clef privée doit être protégée pour garantir qu'une seule et unique personne ne l'utilise.
* Toutes les clefs publiques doivent avoir été vérifiées au préalable par tous les intervenants.

## Comme promis
Un peu plus haut, j'ai promis de revenir sur le genre de situations où il est primordial qu'une personne chiffrant un document ne puisse pas déchiffrer avec la même clef.
Imaginons que je veuille envoyer des données au site de ma banque, il est assez nécessaire que ces informations soient chiffrées. Ma banque me fournit donc une clef, dans le but que je chiffre mes informations avant de les lui envoyer. Il est assez facile d'imaginer les implications qu'aurait le fait de pouvoir déchiffrer ces données avec la même clef : n'importe qui pourrait accéder aux informations de n'importe qui. Dans la pratique, la banque utilise donc un système de chiffrement asymétrique et fournit une clef publique à ses clients.


## C'était pas trop long&nbsp;?
Tant mieux&nbsp;! Et j'espère que c'était surtout un minimum clair. Dans le cas contraire, il y a tous les liens pour me contacter sur la gauche du blog donc il n'y a pas d'hésitation à avoir, je me ferai un plaisir de creuser un peu plus telle ou telle question.  
Allez, bisous&nbsp;!
