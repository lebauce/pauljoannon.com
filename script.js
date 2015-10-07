window.onload = function() {
    var i, j,
        mustaches = document.getElementsByTagName('object'),
        title = document.getElementsByTagName('h1')[0],
        leftClientRect = document.getElementsByClassName('left')[0].getBoundingClientRect(),
        colors = [
            '#f4f4f4'
        ];

    for (i = 0; i < mustaches.length; ++i) {
        var svg = mustaches[i].getSVGDocument(),
            lines = svg.getElementsByTagName('line'),
            paths = svg.getElementsByTagName('path');
        for (j = 0; j < lines.length + paths.length; ++j) {
            (j >= lines.length ? paths[j - lines.length] : lines[j])
                .setAttribute('stroke', colors[i]);
        }
    }

    var em = 1;
    while (em < 7) {
        title.style['font-size'] = String(em) + 'em';
        em += 0.1;
        console.debug(title.getBoundingClientRect().width, leftClientRect.width);
        if (title.getBoundingClientRect().width >= leftClientRect.width - 32) {
            em -= 0.1;
            title.style['font-size'] = String(em) + 'em';
            break;
        }
    }
};
