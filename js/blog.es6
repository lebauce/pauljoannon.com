/**
* @Author: Paul Joannon <paulloz>
* @Date:   2016-02-12T22:34:24+01:00
* @Email:  hello@pauljoannon.com
* @Last modified by:   paulloz
* @Last modified time: 2016-02-13T00:06:13+01:00
*/

window.addEventListener('load', () => {
    const debounce = function(f, t) {
        let timer;
        return () => {
            clearTimeout(timer);
            timer = setTimeout(f, t);
        };
    };

    const formatDate = function() {
        const months = ['janvier', 'février', 'mars', 'avril', 'mai', 'juin', 'juillet', 'août',
                        'septembre', 'octobre', 'novembre', 'décembre'];
        return (year, month, day) => {
            let a = [months[month - 1], year];
            if (day != null) {
                a = [day].concat(a);
            }
            return a.join(' ');
        };
    }();

    // Tags non breaking spaces
    (() => {
        let links = document.getElementsByClassName('left__categories')[0].getElementsByTagName('a');

        for (let i = 0; i < links.length; ++i) {
            links[i].innerHTML = links[i].innerHTML.replace(/\s+/g, '&nbsp;');
        }
    })();

    // Dates
    (() => {
        let dates = document.getElementsByClassName('date');

        for (let i = 0; i < dates.length; ++i) {
            let date = dates[i].textContent.trim().split('-');
            dates[i].textContent = formatDate(date[0], date[1], date[2]);
        }
    })();

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

    // Menu categories
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
            window.addEventListener('resize', debounce(update, 50));
        }
    })();

    // Menu Archives
    (() => {
        let container = document.querySelector('.left__archives__list');

        if (container != null) {
            container = d3.select(container);

            const rawLinks = container.selectAll('a'),
                  links = {};

            let maxN = 0;

            rawLinks.each(function() {
                const matches = this.innerHTML.match(/^(\d{4})-(\d{2}) \((\d+)\)$/),
                      year = matches[1],
                      month = matches[2],
                      n = parseInt(matches[3]);

                if (links[year] == null) {
                    links[year] = [];
                    for (let i = 1; i < 13; ++i) {
                        links[year].push({
                            year: year,
                            month: (i < 10 ? '0' : '') + String(i),
                            n: 0,
                            href: undefined
                        });
                    }
                }

                links[year][parseInt(month) - 1].n = n;
                links[year][parseInt(month) - 1].href = this.getAttribute('href');

                maxN = Math.max(maxN, n);
            });

            container[0][0].innerHTML = '';

            const monthLabels = ['j', 'f', 'm', 'a', 'm', 'j', 'j', 'a', 's', 'o', 'n', 'd'],
                  scale = d3.scale.linear().domain([0, maxN]).range([0.05, 0.90]);

            const update = () => {
                const years = container.selectAll('.year').data(Object.keys(links).reverse());
                let entered = years.enter(),
                    exited = years.exit();

                exited.remove();
                entered
                    .append('span').attr('class', 'year')
                    .append('span').attr('class', 'year__label').html(d => `${d}<br>`);

                const months = years.selectAll('.month').data(d => links[d]);
                entered = months.enter();
                exited = months.exit();

                exited.remove();
                entered.append('a').attr({
                    class: 'month',
                    href: d => d.href,
                    title: d => `${formatDate(d.year, d.month)} (${d.n})`
                }).style('background-color', function(d) {
                    let c = d3.rgb(d3.select(this).style('background-color'));
                    return `rgba(${c.r}, ${c.g}, ${c.b}, ${scale(d.n)})`;
                }).text(d => monthLabels[parseInt(d.month) - 1]);

                months.style('height', function() {
                    return `${this.getBoundingClientRect().width}px`;
                });
            };

            update();
            window.addEventListener('resize', debounce(update, 50));
        }
    })();
});
