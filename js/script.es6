window.addEventListener('load', () => {
    // Title size
    (() => {
        let resizeTitle = () => {
            let em = 1,
                leftClientRect = document.getElementsByClassName('left')[0].getBoundingClientRect(),
                title = document.getElementsByTagName('h1')[0];
            while (em < 10) {
                title.style['font-size'] = String(em) + 'em';
                em += 0.1;
                if (title.getBoundingClientRect().width >= leftClientRect.width - 40) {
                    em -= 0.1;
                    title.style['font-size'] = String(em) + 'em';
                    break;
                }
            }
        }
        window.onresize = resizeTitle;
        resizeTitle();
    })();

    // Links target
    (() => {
        let links = document.getElementsByTagName('a');

        for (let i = 0; i < links.length; ++i) {
            let href = links[i].getAttribute('href');
            if (links[i].parentElement.tagName !== 'P' || ['.', '/'].indexOf(href[0]) >= 0) {
                continue;
            }
            links[i].setAttribute('target', '_blank');
        }
    })();

    // Dates
    (() => {
        let dates = document.getElementsByClassName('date'),
            months = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août',
                      'septembre', 'octobre', 'novembre', 'décembre'];

        for (let i = 0; i < dates.length; ++i) {
            let date = dates[i].textContent.trim().split('-');
            dates[i].textContent = [date[2], months[date[1] - 1], date[0]].join(' ');
        }
    })();

    // ???
    (() => {
        const sequence = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65];

        let timeout,
            idx = 0;

        let cancel = resetIdx => {
            clearTimeout(timeout);
            timeout = null;

            if (resetIdx) {
                idx = 0;
            }
        };

        window.addEventListener('keyup', ev => {
            if (timeout != null) {
                cancel();
            }

            if (ev.keyCode === sequence[idx]) {
                ++idx;
                if (idx < sequence.length) {
                    timeout = setTimeout(() => {
                        cancel(true);
                    }, 500);
                } else {
                }
            } else {
                cancel(true);
            }
        });
    })();
});
