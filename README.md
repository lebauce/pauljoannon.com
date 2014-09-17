# pauljoannon.com

Just my personal website built with **[Hakyll](http://jaspervdj.be/hakyll/index.html)**.  
It's just a bunch of `.md` files compiled to `.html` and fancied with **[AngularJs](https://angularjs.org/)**.  
Feel free to ask me any question that's on your mind or re-use anything in this repository.

--

> \ is not dead

You can build the website using **[Cabal](http://www.haskell.org/cabal/)**:
```sh
$> cabal run -- build
```
Or **ghc**:
```sh
$> ghc --make site.hs
$> ./site build
```

--

Also, it uses **[Bower](http://bower.io/)** to manage front-end dependencies:
```sh
$> bower install
```
(You should actually do that before building the website)