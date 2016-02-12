/**
* @Author: Paul Joannon <paulloz>
* @Date:   2016-02-12T22:34:25+01:00
* @Email:  hello@pauljoannon.com
* @Last modified by:   paulloz
* @Last modified time: 2016-02-12T22:34:26+01:00
*/

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
