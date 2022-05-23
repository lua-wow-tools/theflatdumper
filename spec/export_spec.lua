describe('export', function()
  it('works', function()
    local globalenv = {
      C_Console = {
        GetAllCommands = function()
          return 'commands'
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
      ConsoleCommands = 'commands',
      Data = 'flatdump',
    }
    assert.same(expected, globalenv.TheFlatDumper)
  end)
end)
