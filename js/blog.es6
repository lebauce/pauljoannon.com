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

    // Menu D3
    (() => {
        let container = document.querySelector('.left__categories__list');

        if (container != null) {
            container.innerHTML = container.innerHTML.replace(/,/g, '');
            container = d3.select(container);
            const links = container.selectAll('a');

            const getN = s => parseInt(s.match(/\((\d+)\)$/)[1])

            let totalN = 0;
            links.each(function() { totalN += getN(this.textContent); });

            const scale = d3.scale.linear().domain([0, totalN]);

            const update = () => {
                scale.range([0, container[0][0].getBoundingClientRect().width]);
                links.each(function() {
                    d3.select(this).attr('class', 'category').style({
                        width: String(scale(getN(this.textContent))) + 'px'
                    });
                });
            };
            container.style({ 'display' : 'block' , 'width' : '100%' });
            update();
            window.addEventListener('resize', update);
        }
    })();

    // Tags non breaking spaces
    (() => {
        let links = document.getElementsByClassName('left__categories')[0].getElementsByTagName('a');

        for (let i = 0; i < links.length; ++i) {
            links[i].innerHTML = links[i].innerHTML.replace(/\s+/g, '&nbsp;');
        }
    })();
});
