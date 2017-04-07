---
title: Entrez dans la fédération
subtitle: Ou pourquoi le réseau social Mastodon est intéressant
date: 2017-04-07
tags: données personnelles
description: Quelques points pour mieux comprendre le projet de réseau social Mastodon
---

Depuis quelques jours, vous avez peut-être entendu parler d'un nouveau réseau social du nom de [Mastodon](https://twitter.com/pauljoannon/status/850024246755635200).  
Pour certains c'est un ripoff de [Twitter](https://twitter.com) sans avenir. Pour moi et beaucoup d'autres, c'est un vent de fraicheur et l'incarnation d'un principe important d'Internet&nbsp;: la décentralisation de l'information.  
Bref, voici quelques points pour mieux comprendre le projet **Mastodon**.

<!--more-->

### Ça veut dire quoi «décentralisé»&nbsp;?
Mastodon se différencie d'autres réseaux sociaux avant tout sur un point très important&nbsp;: c'est un réseau décentralisé. Son utilisation n'est pas concentrée autour d'un noyau unique, mais d'un certain nombre d'instances qui s'interconnectent.  
Très pragmatiquement, ça signifie qu'il est très difficile de bloquer totalement l'accès au réseau et que personne ne possède en un point unique la totalité des informations qui transitent sur le réseau.

### Des instances tu dis&nbsp;?
Le réseau (ou **Fediverse**) est donc composé de [différentes **instances**](https://instances.mastodon.xyz/). Pour faire  très simple, si le réseau dans son ensemble était un mur, chaque instance en serait une brique. Chaque brique, connectée aux autres renforce et agrandit la structure globale.  
Il faut donc faire un choix d'entrée de jeu&nbsp;: sur quelle instance s'inscrire&nbsp;? Mais pas d'inquiétude, comme je le disais juste avant, elles font toutes partie de la structure globale qu'est le Fediverse&nbsp;: les utilisateurs de chaque instance peuvent voir et interagir avec les utilisateurs de toutes les autres<sup>1</sup>. Pas besoin, donc, de s'agglutiner sur la même instance que ses potes pour pouvoir leur parler.  

Qu'est-ce qui devrait guider mon choix du coup&nbsp;? Le point majeur à mon avis est de savoir qui administre les instances. Si le Fediverse semble un réseau plus *«libre»* de par sa nature, une instance en elle même n'est pas bien différente des autres réseaux sociaux. Sur leur instances les administrateurs ont accès à vos informations personnelles, peuvent bloquer / bannir des comptes, arrêter de se fédérer avec telle ou telle instance, etc.  
Je ne peux donc qu'inciter comme d'habitude à faire un tour sur les pages d'informations, et de conditions d'utilisation avant de s'inscrire et d'utiliser un service.  

Une fois mon choix fait, mon identité prend donc une forme ressemblant à une adresse mail&nbsp;: [paulloz@mamot.fr](https://mamot.fr/@paulloz). On retrouve mon nom d'utilisateur avant le `@` et l'adresse de l'instance après.

### Mais donc ça, ça et ça c'est pas bien&nbsp;!
Alors oui, ça veut dire que n'importe qui peut débarquer, créer un profil paulloz@uneinstan.ce et se faire passer pour moi. Tout comme n'importe qui pourrait ouvrir une adresse mail en utilisant mon nom. Il faut donc bien sûr être vigilant et vérifier les profils (par ses connexions avec d'autres profils, ou en contactant la personne concernée par un autre moyen) avant de leur faire confiance.  
Cette *«faiblesse»* va forcer peut-être forcer à réfléchir à concept de [**réseau de confiance**](https://fr.wikipedia.org/wiki/Toile_de_confiance).  

Je parlais aussi plus haut du fait que les administrateurs de mon instance ont accès à mes informations personnelles (et messages privés). Oui, tout comme les administrateurs de Twitter ont accès au même types de données sur leur plateforme, ou tout comme les administrateurs d'un service mail ont accès au même genre de données sur leur plateforme. Ce n'est donc pas un problème inhérent à Mastodon&nbsp;: quel que soit le service utilisé, il faut être conscient des données qu'on y partage et de qui y a accès.

### Et donc qui est responsable de tout ça&nbsp;?
D'un point de vue technique, Mastodon est un projet [open source](https://github.com/tootsuite/mastodon) lancé par [Eugen](https://mastodon.social/@Gargron). Son développement et l'hébergement de l'instance d'origine ([mastodon.social](https://mastodon.social)) sont financés via son [Patreon](https://www.patreon.com/user?u=619786).  
En dehors de ça, chaque instance est administrée de façon autonome.

### Qu'est-ce qui change de Twitter&nbsp;?
Je ne vais pas faire un énorme tuto sur l'utilisation de Mastodon mais j'ai quand même envie de parler de deux gros points qui diffèrent de Twitter.  

Tout d'abord, il est possible de changer la visibilité de chaque message.  

![](/content/blog/2017/04/entrez-dans-la-federation/confidentialite.jpg)

À chaque fois que je poste un message ce bouton me permet de choisir si sera visible par tous ou seulement mes abonnés, et si il sera ou non visible dans les fils publics.  

Ce qui m'amène enfin à parler des fils publics.

![](/content/blog/2017/04/entrez-dans-la-federation/fils-publics.jpg)

Il est possible d'afficher dans un colonne soit le fil public local qui contient uniquement les messages postés sur l'instance, soit le fil public global (ou fédéré) qui regroupe tous les messages postés (ou que ce soit sur le réseau) dont l'instance a connaissance<sup>2</sup>.


### Du coup c'est bien ou pas&nbsp;?

À vous de juger, en gardant à l'esprit d'une part que le réseau n'en est encore à ses balbutiements, d'autre part que tout semble possible à un projet porté par la communauté.


<div class="separator"></div>
<sup>1</sup> À condition que leurs instances respectives soient fédérées.  
<sup>2</sup> Un message venant d'une instance différente n'est visible dans le fil public global que si au moins une personne de l'instance locale suit son auteur.
