# Cookie

[![Build Status](https://travis-ci.org/luvitrocks/luvit-cookie.svg?branch=master)](https://travis-ci.org/luvitrocks/luvit-cookie)

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

#### Options

`cookie:parse` accepts these properties in the options table.

##### decode

Specifies a function that will be used to decode a cookie's value. Since the value of a cookie has a limited character set (and must be a simple string), this function can be used to decode a previously-encoded cookie value into a Lua string or table.

The default function is the built-in [`querystring.urldecode`](https://luvit.io/api/querystring.html#querystring_querystring_urldecode_str), which will decode any URL-encoded sequences into their byte representations.

### cookie:serialize(name, value, options)

Serialize a cookie name-value pair into a `Set-Cookie` header string. The `name` argument is the name for the cookie, the `value` argument is the value to set the cookie to, and the `options` argument is an optional table containing additional serialization options.

```lua
local setCookie = cookie:serialize('foo', 'bar');
-- foo=bar
```

#### Options

`cookie:serialize` accepts these properties in the options table.

##### domain

Specifies the value for the [`Domain` `Set-Cookie` attribute][rfc-6266-5.2.3]. By default, no domain is set, and most clients will consider the cookie to apply to only the current domain.

##### encode

Specifies a function that will be used to encode a cookie's value. Since value of a cookie has a limited character set (and must be a simple string), this function can be used to encode a value into a string suited for a cookie's value.

The default function is the built-in [`querystring.urlencode`](https://luvit.io/api/querystring.html#querystring_querystring_urlencode_str), which will encode a Lua string into UTF-8 byte sequences and then URL-encode any that fall outside of the cookie range.

##### expires

Specifies the `os.date` to be the value for the [`Expires` `Set-Cookie` attribute][rfc-6266-5.2.1]. By default, no expiration is set, and most clients will consider this a "non-persistent cookie" and will delete it on a condition like exiting a web browser application.

**note** the [cookie storage model specification][rfc-6266-5.3] states that if both `expires` and `magAge` are set, then `maxAge` takes precedence, but it is possible not all clients by obey this, so if both are set, they should point to the same date and time.

##### httpOnly

Specifies the `boolean` value for the [`HttpOnly` `Set-Cookie` attribute][rfc-6266-5.2.6]. When truthy, the `HttpOnly` attribute is set, otherwise it is not. By default, the `HttpOnly` attribute is not set.

**note** be careful when setting this to `true`, as compliant clients will not allow client-side JavaScript to see the cookie in `document.cookie`.

##### maxAge

Specifies the `number` (in seconds) to be the value for the [`Max-Age` `Set-Cookie` attribute][rfc-6266-5.2.2].
The given number will be converted to an integer by rounding down. By default, no maximum age is set.

**note** the [cookie storage model specification][rfc-6266-5.3] states that if both `expires` and `magAge` are set, then `maxAge` takes precedence, but it is possible not all clients by obey this, so if both are set, they should point to the same date and time.

##### path

Specifies the value for the [`Path` `Set-Cookie` attribute][rfc-6266-5.2.4]. By default, the path is considered the ["default path"][rfc-6266-5.1.4]. By default, no maximum age is set, and most clients will consider this a "non-persistent cookie" and will delete it on a condition like exiting a web browser application.

##### secure

Specifies the `boolean` value for the [`Secure` `Set-Cookie` attribute][rfc-6266-5.2.5]. When truthy, the `Secure` attribute is set, otherwise it is not. By default, the `Secure` attribute is not set.

**note** be careful when setting this to `true`, as compliant clients will not send the cookie back to the server in the future if the browser does not have an HTTPS connection.

### cookie:sign(value, secret)

Sign the given `value` with `secret`.

```lua
local signed = cookie:sign('hello', 'tobiiscool')
-- 'hello.0c60d4906948902ccfcfe0b4074eb814d8077448e8c7b721f2d3811ac959e502'
```

### cookie:unsign(value, secret)

Unsign and decode the given `value` with `secret`. It returns `false` if the signature is invalid.

```lua
local signed = cookie:sign('hello', 'tobiiscool')

cookie:unsign(signed, 'tobiiscool')
-- 'hello'

cookie:unsign(signed, 'luna')
-- false
```

### cookie:parseJSONCookie(value)

Parse a cookie value as a JSON cookie. This will return the parsed JSON value if it was a JSON cookie.

### cookie:parseJSONCookies(table)

Given a table, this will iterate over the keys and call `parseJSONCookie` on each value. This will return the same table passed in.

```lua
local cookie = cookie:parseJSONCookie('j:{"foo":"bar"}')
-- { foo = 'bar' }
```

### cookie:parseSignedCookie(value, secret)

Parse a cookie value as a signed cookie. This will return the parsed unsigned value if it was a signed cookie and the signature was valid.

### cookie:parseSignedCookies(table, secret)

Given a table, this will iterate over the keys and check if any value is a signed cookie. If it is a signed cookie and the signature is valid, the key will be deleted from the table and added to the new table that is returned.


```lua
local cookie = cookie:parseSignedCookie('s:hello.0c60d4906948902ccfcfe0b4074eb814d8077448e8c7b721f2d3811ac959e502')
-- hello
```

## Tests

```bash
lit install
luvit ./test
```

## References

- [RFC 6266: HTTP State Management Mechanism][rfc-6266]
- [Same-site Cookies][draft-west-first-party-cookies-07]

[draft-west-first-party-cookies-07]: https://tools.ietf.org/html/draft-west-first-party-cookies-07
[rfc-6266]: https://tools.ietf.org/html/rfc6266
[rfc-6266-5.1.4]: https://tools.ietf.org/html/rfc6266#section-5.1.4
[rfc-6266-5.2.1]: https://tools.ietf.org/html/rfc6266#section-5.2.1
[rfc-6266-5.2.2]: https://tools.ietf.org/html/rfc6266#section-5.2.2
[rfc-6266-5.2.3]: https://tools.ietf.org/html/rfc6266#section-5.2.3
[rfc-6266-5.2.4]: https://tools.ietf.org/html/rfc6266#section-5.2.4
[rfc-6266-5.3]: https://tools.ietf.org/html/rfc6266#section-5.3

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


