---
title: Chiffrage, au désespoir (de nos vieux ennemies)
subtitle: Données personnelles, vie privée et sécurité &#35;2
date: 2016-04-15
tags: données personnelles
---

Mon smartphone contient une bonne partie de ma vie&nbsp;: mon agenda, mon répertoire, mes mails, pas mal de photos, un accès à mes comptes [Twitter](https://twitter.com/pauljoannon), [Snapchat](https://snapchat.com/add/paullozz), [Steam](https://steamcommunity.com/id/paulloz), [Soundcloud](https://soundcloud.com/paulloz-1), [Flickr](https://flickr.com/photos/paulloz), [GitHub](https://github.com/Paulloz), et j'en oublie sûrement. Aux États-Unis, il est même possible de payer physiquement avec son téléphone grâce à [Android Pay](https://www.android.com/pay/) ou [Apple Pay](http://www.apple.com/apple-pay/), et ces solutions [devraient arriver](http://www.frandroid.com/marques/apple/342484_apple-pay-devrait-arriver-dici-quelques-mois-en-france) en France sous peu.  
Bref, autant de raisons de vouloir sécuriser au maximum son smartphone. En plus, c'est hyper simple.

<!--more-->

### Bertrand Renard, si tu m'écoutes

Premier réflexe, chiffrer son smartphone. Comme ça en cas de perte, impossible d'extraire les données qu'il contient sans le dévérouiller avec la bonne passphrase.  

![](/content/blog/2016/04/chiffrage-au-desespoir/chiffrer-android.jpg)
![](/content/blog/2016/04/chiffrage-au-desespoir/chiffrer-ios.jpg)
![](/content/blog/2016/04/chiffrage-au-desespoir/chiffrer-wp.jpg)

Sur un téléphone Android, il faut se rendre dans le menu de configuration *«Sécurité»* et appuyer sur le bouton *«Chiffrer&nbsp;le&nbsp;téléphone»*.  
Sur iOs c'est tout aussi simple, voir encore plus transparent. Le chiffrement est activé d'office à partir du moment où le téléphone est vérouillé par un code. Direction donc le menu de configuration *«Touch ID et code»* (ou *«Vérouillage par code»*) pour définir un code. La phrase *«La protection des données est activée»* devrait ensuite apparaître tout en bas de ce menu.  
Et sur Windows Phone (depuis WP10) il y a dans le menu de configuration *«Système»* un sous-menu *«Chiffrement du périphérique»* qui servira de guide.

### Des photos de nuages mais pas de nuages de photos

Second réflexe, désactiver la synchronisation automatique des photos vers le [«cloud»](http://download.fsfe.org/advocacy/promomaterial/NoCloud/NoCloud-sticker/thereisnocloud-sticker-74mm.en.pdf).  
Ça évitera que des [photos ne se retrouve n'importe où](https://fr.wikipedia.org/w/index.php?title=The_Fappening) à cause de je ne sais quelle faille sur les serveurs d'Apple, Google ou Microsoft. En fait, ces serveurs je considère déjà un peu ça comme «n'importe où»...

![](/content/blog/2016/04/chiffrage-au-desespoir/cloud-android.jpg)
![](/content/blog/2016/04/chiffrage-au-desespoir/cloud-ios.jpg)
![](/content/blog/2016/04/chiffrage-au-desespoir/cloud-wp.jpg)

Sur Android, direction le menu de configuration de l'application *«Photos»* pour y désactiver l'option *«Sauvegarder&nbsp;et&nbsp;synchroniser»*.  
Sur iOs c'est dans le menu de configuration *«iCloud»* que tout se passe.  
Sur Windows Phone, il faut aller dans les paramètre de l'application *«Photos»* et désactiver *«OneDrive»* sous la mention *«Chargement automatique»*.  

En sauvegardant de temps en temps les photos sur un autre disque dur, tout devrait bien se passer.

### Dé-localisation en masse

Un petit tour par [l'historique des positions de Google Maps](https://maps.google.com/locationhistory/) et tout le monde s'écrit *«Mais c'est super flippant&nbsp;!»*. Du coup, troisième réflexe&nbsp;: désactiver les services de localisation.

![](/content/blog/2016/04/chiffrage-au-desespoir/localisation-android.jpg)
![](/content/blog/2016/04/chiffrage-au-desespoir/localisation-ios.jpg)
![](/content/blog/2016/04/chiffrage-au-desespoir/localisation-wp.jpg)

C'est encore une fois super simple, il y a toujours un menu de configuration dont le nom ressemble à *«Localisation»* où un bouton désactive tout d'un seul coup.  

### Encore un jeu de mots sur le fait de chiffrer des lettres

Enfin, un smartphone ça sert avant tout à communiquer. Mais communiquer en clair c'est un truc de narvalo, surtout que c'est de plus en plus simple de chiffrer (c'est à dire rendre illisible à toute autre personne que l'expéditeur et le destinataire) messages et appels.

J'ai d'abord voulu aller voir du côté de [SMSSecure](https://smssecure.org/). Étant donné que l'application n'est utilisable que sous Android, l'intérêt est limité (impossible de déchiffrer mes messages depuis un smartphone iOs ou Windows Phone).  
Jusqu'à [début avril (2016)](https://blog.whatsapp.com/10000618/Le-chiffrement-de-bout-en-bout), [Whatsapp](https://www.whatsapp.com/) souffrait du même problème et ne proposait du chiffrement bout en bout qu'aux périphériques Android. Qui plus est, Whatsapp est tout sauf open source.  
[Telegram](https://telegram.org/) est aussi une option, cette fois disponible sur toutes les plateformes. Pourtant, pas mal de monde emmet des doutes (par exemple [ici](http://www.dailydot.com/politics/telegram-isis-encryption-cryptography/), [là](https://unhandledexpression.com/2013/12/17/telegram-stand-back-we-know-maths/), [ici](http://www.alexrad.me/discourse/a-264-attack-on-telegram-and-why-a-super-villain-doesnt-need-it-to-read-your-telegram-chats.html) ou encore [là](http://security.stackexchange.com/questions/49782/is-telegram-secure/)) quant à la sécurité réelle qu'elle apporte.  

Actuellement, [Signal](https://whispersystems.org/) semble être la meilleure solution.  
Une fois installée, l'application permet de communiquer (en texte et en voix) de façon chiffrée avec les autres personnes l'utilisant. Il est aussi possible de la configurer pour qu'elle remplace l'application de SMS par défaut. Comme ça, sont regroupés au même endroits les contacts valables (qui communiquent sainement) et les autres (qui parlent en clair, bâââh, caca, caca&nbsp;!).  
Bon, je suis désolé, aucun [support de Windows Phone](http://support.whispersystems.org/hc/en-us/articles/213133427-Are-there-plans-for-a-Windows-Phone-version-BlackBerry-version-Ubuntu-Phone-version-) n'est pour l'instant prévu.  

Pour plus d'information, la page [Secure Messaging Scorecard](https://www.eff.org/secure-messaging-scorecard) de l'EFF est très bien (mais en anglais).

### En bonus&nbsp;: j'ai enfin le droit de tirer sur le messager

Un petit conseil que j'expliquerai plus en détails prochainement...

![](/content/blog/2016/04/chiffrage-au-desespoir/uninstall-messenger.jpg)

<style type="text/css">img{max-width:32%;}</style>
