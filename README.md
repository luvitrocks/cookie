# Cookie

> Basic HTTP cookie parser and serializer for HTTP servers in [Luvit.io](https://luvit.io).

## Install

```bash
lit install voronianski/cookie
```

## API

```lua
local Cookie = require('cookie')
local cookie = Cookie:new()
```

### cookie:parse(str, options)

Parse HTTP `Cookie` header string and returning a table of all cookie name-value pairs. The `str` argument is the string representing a `Cookie` header value and `options` is an optional table containing additional parsing options.

```lua
local cookies = cookie:parse('foo=bar; equation=E%3Dmc%5E2');
-- { foo = 'bar', equation = 'E=mc^2' }
```

## Running Tests

```bash
lit install
luvit ./test
```

## License

```
WWWWWW||WWWWWW
 W W W||W W W
      ||
    ( OO )__________
     /  |           \
    /o o|    MIT     \
    \___/||_||__||_|| *
         || ||  || ||
        _||_|| _||_||
       (__|__|(__|__|
```

MIT Licensed

Copyright (c) 2014-2016 Dmitri Voronianski dmitri.voronianski@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


