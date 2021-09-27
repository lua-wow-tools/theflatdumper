describe('flatdump', function()

  local flatdump do
    local addonenv = {}
    loadfile('src/flatdump.lua')('moo', addonenv)
    flatdump = addonenv.flatdump
  end

  it('works on empty input', function()
    local input = {}
    local expected = {
      [1] = {},
    }
    assert.same(expected, flatdump(input))
  end)

  it('works on simple types', function()
    local input = {
      [true] = false,
      [42] = 99,
      ['key'] = 'value',
    }
    local expected = {
      [1] = {
        btrue = 'bfalse',
        n42 = 'n99',
        skey = 'svalue',
      },
    }
    assert.same(expected, flatdump(input))
  end)

  it('handles table recursion', function()
    local input = {
      inner = {},
    }
    input.rec = input
    input.inner.bigrec = input
    input.inner.littlerec = input.inner
    local expected = {
      [1] = {
        sinner = 't2',
        srec = 't1',
      },
      [2] = {
        sbigrec = 't1',
        slittlerec = 't2',
      },
    }
    assert.same(expected, flatdump(input))
  end)
end)
