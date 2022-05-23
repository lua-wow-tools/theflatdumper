local _, G = ...

local toexport = {
  BuildInfo = { _G.GetBuildInfo() },
  Data = G.flatdump(_G),
}

local frame = _G.CreateFrame('Frame')
frame:RegisterEvent('PLAYER_LOGOUT')
frame:SetScript('OnEvent', function()
  toexport.ConsoleCommands = _G.C_Console.GetAllCommands()
  toexport.CVarDefaults = (function()
    local t = {}
    for _, command in ipairs(toexport.ConsoleCommands) do
      local name = command.command
      t[name] = _G.C_CVar.GetCVarDefault(name)
    end
    return t
  end)()
  _G.TheFlatDumper = _G.LibStub('LibDeflate'):CompressDeflate(G.pprint(toexport))
end)
