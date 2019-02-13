/**
* @Author: Paul Joannon <paulloz>
* @Date:   2016-02-12T22:34:20+01:00
* @Email:  hello@pauljoannon.com
* @Last modified by:   paulloz
* @Last modified time: 2016-02-12T22:34:22+01:00
*/

window.addEventListener('load', () => {
    // Tweet link
    (() => {
        let title = document.getElementsByTagName('h2')[0].textContent,
            link = document.getElementsByClassName('tweet')[0];

        link.addEventListener('click', () => {
            const tweet = `${title} v/ @pauljoannon ${window.location.href}`;
            console.debug(tweet);
            window.open(`https://twitter.com/intent/tweet?original_referer=&text=${tweet}`, '', 'width=575,height=400,menubar=no,toolbar=no');
        });
    })();
});

