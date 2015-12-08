window.addEventListener('load', () => {
    // Menu toggle
    (() => {
        let menu = document.getElementsByClassName('left--below-title')[0],
            cl = menu.getAttribute('class'),
            shown = false,
            button = document.getElementsByClassName('left__toggle')[0],
            buttonInner = button.getElementsByClassName('fa-stack-1x')[0];

        button.addEventListener('click', () => {
            shown = !shown;

            menu.setAttribute('class', cl + (shown ? ' shown' : ''));

            if (shown) {
                buttonInner.setAttribute('class', buttonInner.getAttribute('class').replace('info', 'close'));
                document.body.setAttribute('class', 'no-scroll');
            } else {
                buttonInner.setAttribute('class', buttonInner.getAttribute('class').replace('close', 'info'));
                document.body.setAttribute('class', '');
            }
        });
    })();

    // Tags non breaking spaces
    (() => {
        let links = document.getElementsByClassName('left__categories')[0].getElementsByTagName('a');

        for (let i = 0; i < links.length; ++i) {
            links[i].innerHTML = links[i].innerHTML.replace(/\s+/g, '&nbsp;');
        }
    })();
});
