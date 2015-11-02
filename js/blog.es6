window.addEventListener('load', () => {
    // Tags non breaking spaces
    (() => {
        let links = document.getElementsByClassName('left__categories')[0].getElementsByTagName('a');

        for (let i = 0; i < links.length; ++i) {
            links[i].innerHTML = links[i].innerHTML.replace(/\s+/g, '&nbsp;');
        }
    })();
});
