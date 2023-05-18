@ECHO OFF
mkdir packed-browserify
ECHO Packing browserify...
CALL browserify.cmd browpackBrowserify.js --node -o .\packed-browserify\browserify.packed.js
ECHO Now, go patch browserify.packed.js. Click ENTER to continue when done.
PAUSE
ECHO Minifying browserify...
CALL babel-minify packed-browserify\browserify.packed.js -o packed-browserify\browserify.packed.min.js
ECHO Done.
PAUSE