---
title: La fable du SVG to PNG
date: 2015-12-03
tags: D3.js, javascript, programmation
description: De la génération de PNG en D3.js. C'est possible, ce n'est pas bien compliqué et surtout c'est ultra cool.
---

En septembre dernier, avec [Six Plus](http://www.liberation.fr/data-nouveaux-formats-six-plus,100538), on a publié un [petit truc pour pronostiquer la Coupe du Monde de Rugby](https://github.com/libe-sixplus/qui-sera-champion-du-monde-de-rugby).  
Eh bien là dedans, tout au fond, il y a une feature qui est passée totalement inaperçue&nbsp;: de la génération de PNG en [D3.js](http://d3js.org/). C'est possible, ce n'est pas bien compliqué et surtout c'est ultra cool.

<!--more-->

L'idée de base était la suivante&nbsp;: je sais comment télécharger le contenu d'un canvas dans un PNG et je sais injecter du SVG dans un canvas. Donc je sais télécharger un SVG en PNG.  
Il y a peut-être des moyens plus simples de faire tout ça, mais ma méthode est vachement marrante.  

Disons qu'on est bien contents et qu'on a un beau SVG chargé dans notre DOM. On va l'appeler `#kiki`.  
La première étape donc, c'est de récupérer tout le contenu de `#kiki` et de le reproduire dans un canvas. Pour faire ça, on va d'abord récupérer tout ce qui compose `#kiki`.  

```javascript
var kiki = document.getElementById('kiki'),
    dom = document.createElement('div').appendChild(kiki.cloneNode(true));
```

Ici, on a un nouvel élément propre (la variable `dom`) qui est une réplique de `#kiki`. Pour l'injecter dans notre canvas, il faut ajouter quelques conneries propres à un SVG.  

```javascript
dom.innerHTML = '<?xml version="1.0" standalone="no"?>\n' + dom.innerHTML;
dom.setAttribute('version', '1.1');
dom.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
dom.setAttribute('xmlns:xlink', 'http://www.w3.org/1999/xlink');
```

Maintenant on peut charger ce contenu dans un objet `Image` en encodant tout le contenu de `dom` en `base64`.

```javascript
var image = new Image();
image.src = 'data:image/svg+xml;base64,' +
            btoa(unescape(encodeURIComponent(dom.outerHTML)));
```

Et on charge le contenu de notre objet `Image` dans un canvas, sans oublier de faire correspondre la taille du canvas à la taille de notre image.

```javascript
image.onload = function() {
    var canvas = document.createElement('canvas'),
        context = canvas.getContext('2d');

    canvas.width = image.width;
    canvas.height = image.height;
    context.drawImage(image, 0, 0);
};
```

Il ne reste plus qu'à télécharger le contenu du canvas en PNG via un faux  clic sur une balise `<a>` qu'on injecte subrepticement dans la page.

```javascript
var a = document.createElement('a');

a.download = 'kiki.png';
a.href = canvas.toDataUrl('image/png');
document.body.appendChild(a);
a.click();
a.remove();
```

Hourra&nbsp;! On a fini et ça marche&nbsp;!  
Mais là vous me dites *«Dis-donc Paulloz, c'est bien gentil tes conneries mais généralement on a une feuille de style pour rendre sexy tout le bordel qu'on génère.»*. Eh bien, c'est plein de bon sens comme remarque&nbsp;!  

Bonus round&nbsp;: on récupère le contenu de `kiki.css`.  
On peut accéder aux feuilles de style chargées sur la page via `document.styleSheets`.  

```javascript
var rawStyle = '';
for (var i = 0; i < document.styleSheets.length; ++i) {
    if (document.styleSheets[i].href == null) { continue; }
    var href = document.styleSheets[i].href.split('/');
    if ('kiki.css'.indexOf(href[href.length - 1]) === 0) {
        for (var j = 0; j < document.styleSheets[i].cssRules.length; +++j) {
            rawStyle += document.styleSheets[i].cssRules[j].cssText + '\n';
        }
    }
}
```

Voilà&nbsp;! Notre variable `rawStyle` contient toutes les règles écrites dans `kiki.css`. Il faut injecter tout ça dans notre variable `dom` créée plus haut, dans une balise `<style>`, dans une balise `<defs>`.

```javascript
var defs = document.createElement('defs'),
    style = document.createElement('style');

    style.setAttribute('type', 'text/css');
    style.innerHTML = '<![CDATA[\n' + rawStyle + ']]>';
    defs.appendChild(style);
    dom.insertBefore(defs, dom.firstChild);
```

Vous êtes contents&nbsp;? Allez, comme je suis super sympa je vous lâche le code d'un bloc, un peu commenté.  
Amusez-vous&nbsp;!

```javascript
var kiki = document.getElementById('kiki'), // root tag of our generated content
    dom = document.createElement('div').appendChild(kiki.cloneNode(true)),
    defs = document.createElement('defs'),
    style = document.createElement('style'),
    rawStyle = '',
    image = new Image();

// retrieve CSS from stylesheet
for (var i = 0; i < document.styleSheets.length; ++i) {
    if (document.styleSheets[i].href == null) { continue; }
    var href = document.styleSheets[i].href.split('/');
    if ('kiki.css'.indexOf(href[href.length - 1]) === 0) {
        for (var j = 0; j < document.styleSheets[i].cssRules.length; +++j) {
            // maybe filter rules here (keep only the ones starting with `svg`)?
            rawStyle += document.styleSheets[i].cssRules[j].cssText + '\n';
        }
    }
}
// inject CSS in our SVG DOM
style.setAttribute('type', 'text/css');
style.innerHTML = '<![CDATA[\n' + rawStyle + ']]>';
defs.appendChild(style);
dom.insertBefore(defs, dom.firstChild);

// insert every mandatory SVG bullshit
dom.innerHTML = '<?xml version="1.0" standalone="no"?>\n' + dom.innerHTML;
dom.setAttribute('version', '1.1');
dom.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
dom.setAttribute('xmlns:xlink', 'http://www.w3.org/1999/xlink');

// create the Image object and encode our svg content as a base64 src
image.src = 'data:image/svg+xml;base64,' +
            btoa(unescape(encodeURIComponent(dom.outerHTML)));
// load this image in a canvas
image.onload = function() {
    var canvas = document.createElement('canvas'),
        context = canvas.getContext('2d'),
        a = document.createElement('a');

    canvas.width = image.width; // don't forget width
    canvas.height = image.height; // nor height
    context.drawImage(image, 0, 0);

    // download
    a.download = 'kiki.png';
    a.href = canvas.toDataUrl('image/png');
    document.body.appendChild(a);
    a.click();
    a.remove();
};
```
