# Browserify as a Single-Executable App (SEApp)
## _Browserify in a single, neat pack_

[Browserify](https://github.com/browserify/browserify) is an invaluable tool to pack codes to create SEApp, besides it typical uses of course =)

Here, we pack all its ✨Magic ✨ into a **SEApp**, you don't have to lug round a whole nested folder of countless dependencies and files.

## How To

Making [SEApps](https://nodejs.org/docs/latest/api/single-executable-applications.html) can be a bliss with [makeSea](https://github.com/sdneon/makeSea) if your app is small. However, if your app is complex and uses countless dependencies, it can be a nightmare, even with the help of browserify.

This is an exploration of bundling the mammoth browserify into a SEApp.

1. Pack browserify using itself =) - to say, browerify.packed.js.
2. Test it out and figure out what does Not work.
```
> node browerify.packed.js

...errors erupt...
```
3. Resolve those issues.
4. Repeat... until the packed content works.

### Things to Overcome

1. browserify's commandline entry point is in `bin/cmd.js' - so wrap it up in a function and export it, if we wish to reuse it programmatically.
   * If not, it can be left as is. And it will still be triggered when the SEApp runs.
2. `require.resolve` calls - there're many of these in 2 areas (acorn-node/build.js & browserify/lib/builtins.js). They crash the SEApp.
   * A solution that works is to just return '.' for all of them - don't know if it breaks anything else under the hood.
```js
if (typeof require.resolve !== 'function') require.resolve = () => '.'; //prepend this faker
```
3. `browser-pack/index.js` looks for an external `_prelude.js` - which fails to be found in a packed environment.
   * Solution: Copy and paste the contents of `_prelude.js` into the codes instead.

## Back To How To

And surprisingly, that's all it takes, phew~

5. Minify browserify.packed.js using babel-minify to further shrink it. To say, browerify.js.
6. Well, there's really nothing else needed in this case for a browserify SEApp. Thus, we can use the minified file directly with [makeSea](https://github.com/sdneon/makeSea) to generate the browserify.exe =) 
```
> node makeSea.js browserify.js

...
tada~ browserify.exe is produced.
```

## Usage

All browserify's options as per normal. E.g.:
```
browserify.exe list_of_requires.js --node -o list_of_requires.packed.js
```