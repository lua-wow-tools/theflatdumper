describe('pprint', function()

  local pprint do
    local fenv = {
      assert = assert,
      format = string.format,
      ipairs = ipairs,
      next = next,
      pairs = pairs,
      sort = table.sort,
      strrep = string.rep,
      table = { concat = table.concat },
      tinsert = table.insert,
      type = type,
    }
    fenv._G = fenv
    local addonenv = {}
    setfenv(loadfile('src/pprint.lua'), fenv)('moo', addonenv)
    pprint = addonenv.pprint
  end

  local tests = {
    {
      name = 'empty input',
      input = {},
      output = '{\n}\n',
    },{
      name = 'flat array',
      input = {42, 'foo', 99, 'bar'},
      output = '{\n\t42,\n\t"foo",\n\t99,\n\t"bar",\n}\n',
    },{
      name = 'flat string key dict',
      input = { a = 42, b = 'foo' },
      output = '{\n\t["a"] = 42,\n\t["b"] = "foo",\n}\n',
    },{
      name = 'nested table',
      input = { a = { b = 'c' } },
      output = '{\n\t["a"] = {\n\t\t["b"] = "c",\n\t},\n}\n',
    }
  }

  for _, t in ipairs(tests) do
    it('works on ' .. t.name, function()
      assert.same(t.output, pprint(t.input))
    end)
  end

end)
