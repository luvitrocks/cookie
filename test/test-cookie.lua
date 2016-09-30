local test = require('lua-tape').test
local Cookie = require('../lib/Cookie')

local cookie = Cookie:new()

test('shoud have valid tostring value', function (t)
  local r = tostring(cookie)

  t:equals(r, '<Cookie>', 'is <Cookie> in value')
  t:done()
end)

test('shoud parse cookie', function (t)
  local r = cookie:parse('foo=bar; equation=E%3Dmc%5E2')

  t:equals(r.foo, 'bar', 'has first cookie value')
  t:equals(r.equation, 'E=mc^2', 'has second cookie value')
  t:done()
end)

test('shoud serialize cookie', function (t)
  local setCookie = cookie:serialize('foo', 'bar', {
    domain = '.example.com',
    secure = true
  })

  t:equals(type(setCookie), 'string', 'is string')
  t:equals(setCookie, 'foo=bar; Domain=.example.com; Secure', 'has proper value')
  t:done()
end)

test('shoud sign and unsign cookie', function (t)
  local secret = 'tobiiscool'
  local signed = cookie:sign('hello', secret)

  t:equals(type(signed), 'string', 'is string')
  t:equals(signed, 'hello.0c60d4906948902ccfcfe0b4074eb814d8077448e8c7b721f2d3811ac959e502', 'has proper value')

  local unsigned = cookie:unsign(signed, secret)

  t:equals(type(unsigned), 'string', 'is string')
  t:equals(unsigned, 'hello', 'has proper value')

  t:done()
end)

