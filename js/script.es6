window.onload = function() {
    (() => {
        let mustaches = document.getElementsByTagName('object'),
            color = '#f4f4f4';

        for (let i = 0; i < mustaches.length; ++i) {
            let svg = mustaches[i].getSVGDocument(),
                lines = svg.getElementsByTagName('line'),
                paths = svg.getElementsByTagName('path');
            for (let j = 0; j < lines.length; ++j) {
                lines[j].setAttribute('stroke', color);
            }
            for (let j = 0; j < paths.length; ++j) {
                paths[j].setAttribute('stroke', color);
            }
        }
    })();

    (() => {
        let em = 1,
            leftClientRect = document.getElementsByClassName('left')[0].getBoundingClientRect(),
            title = document.getElementsByTagName('h1')[0];
        while (em < 7) {
            title.style['font-size'] = String(em) + 'em';
            em += 0.1;
            if (title.getBoundingClientRect().width >= leftClientRect.width - 32) {
                em -= 0.1;
                title.style['font-size'] = String(em) + 'em';
                break;
            }
        }
    })();

    (() => {
        let links = document.getElementsByTagName('a');

        for (let i = 0; i < links.length; ++i) {
            links[i].setAttribute('target', '_blank');
        }
    })();
};
