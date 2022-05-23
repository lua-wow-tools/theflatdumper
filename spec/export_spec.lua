describe('export', function()
  it('works', function()
    local globalenv = {
      C_Console = {
        GetAllCommands = function()
          return {
            { command = 'foo' },
            { command = 'bar' },
            { command = 'baz' },
          }
        end,
      },
      C_CVar = {
        GetCVarDefault = function(arg)
          return 'default_' .. arg
        end,
      },
      CreateFrame = function()
        return {
          RegisterEvent = function() end,
          SetScript = function(_, _, script)
            script()
          end,
        }
      end,
      GetBuildInfo = function()
        return 1, 2, 3, 4
      end,
      ipairs = ipairs,
      LibStub = function()
        return {
          CompressDeflate = function(_, arg)
            return arg
          end,
        }
      end,
    }
    globalenv._G = globalenv
    local addonenv = {
      flatdump = function()
        return 'flatdump'
      end,
      pprint = function(arg)
        return arg
      end,
    }
    setfenv(loadfile('src/export.lua'), globalenv)('moo', addonenv)
    local expected = {
      BuildInfo = { 1, 2, 3, 4 },
      ConsoleCommands = {
        { command = 'foo' },
        { command = 'bar' },
        { command = 'baz' },
      },
      CVarDefaults = {
        bar = 'default_bar',
        baz = 'default_baz',
        foo = 'default_foo',
      },
      Data = 'flatdump',
    }
    assert.same(expected, globalenv.TheFlatDumper)
  end)
end)
