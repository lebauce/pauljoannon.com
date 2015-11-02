window.addEventListener('load', () => {
    // Tweet link
    (() => {
        let title = document.getElementsByTagName('h2')[0].textContent,
            link = document.getElementsByClassName('tweet')[0];

        link.addEventListener('click', () => {
            const tweet = `${title} v/ @pauljoannon ${window.location.href}`;
            console.debug(tweet);
            window.open(
                `https://twitter.com/intent/tweet?original_referer=&text=${tweet}`,
                '',
                'width=575,height=400,menubar=no,toolbar=no'
            );
        });
    })();
});
