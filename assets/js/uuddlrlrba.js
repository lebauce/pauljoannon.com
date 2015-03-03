var randomColor = function() {
    var color = "rgb(";
    for (var i = 0; i < 3; ++i) {
        if (i > 0) {
            color += ", ";
        }
        color += String(Math.floor(Math.random() * 255));
    }
    color += ")";
    return color;
}

randomRotate = function() {
    return ((Math.random() < .5) ? '-' : '') + String(Math.random() * 25);
}

angular.module("pauljoannon").directive("uuddlrlrba", ['$timeout', '$window', function($timeout, $window) {
    return {
        restrict : 'A',
        scope : { },
        link: function($scope, $element) {
            var sequence = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65];
            var currentIdx = 0;
            var timer;

            var onSequenceFulfilled = function() {
                var fWords = ["such", "much", "very"];
                var sWords = ["website", "contacter", "classe", "beau",
                              "javascript", "paul joannon", "développeur",
                              "freelance", "pythonic", "haskell", "projets"];

                var newWord = function(isWow) {
                    var word;
                    if (isWow) {
                        word = "wow";
                    } else {
                        word = fWords[Math.floor(Math.random() * fWords.length)] + " " + sWords[Math.floor(Math.random() * sWords.length)];
                    }

                    var domElement = $("<div>");
                    domElement.attr("class", "doge__words").text(word)
                              .css("left", Math.floor(Math.random() * $window.innerWidth))
                              .css("top", Math.floor(Math.random() * $window.innerHeight))
                              .css("color", randomColor)
                              .css("transform", "rotate(" + randomRotate() + "deg)");

                    $element.append(domElement);

                    if (domElement.width() + parseInt(domElement.css('left')) > $window.innerWidth) {
                        domElement.css('left', parseInt(domElement.css('left')) - domElement.width());
                    }
                    if (domElement.height() + parseInt(domElement.css('top')) > $window.innerHeight) {
                        domElement.css('top', parseInt(domElement.css('top')) - domElement.height());
                    }

                    $timeout(function() {
                        newWord(Math.random() > .8);
                    }, 3000);
                };

                $element.append($("<div>").attr("class", "doge"));
                newWord(true);
            };

            var resetSequence = function() {
                currentIdx = 0;

                $timeout.cancel(timer);
                timer = undefined;
            };

            var onKeyPress = function(event) {
                $timeout.cancel(timer);
                timer = undefined;

                if (currentIdx < sequence.length) {
                    if (event.keyCode == sequence[currentIdx]) {
                        ++currentIdx;

                        if (currentIdx >= sequence.length) {
                            $timeout.cancel(timer);
                            onSequenceFulfilled();
                        }

                        timer = $timeout(resetSequence, 300);
                    } else {
                        resetSequence();
                    }
                }
            };

            $element.on("keyup", onKeyPress);
        }
    };
}]);