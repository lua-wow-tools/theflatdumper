local _, G = ...

local buildinfo = { _G.GetBuildInfo() }
local data = G.flatdump(_G)

local frame = _G.CreateFrame('Frame')
frame:RegisterEvent('PLAYER_LOGOUT')
frame:SetScript('OnEvent', function()
  _G.TheFlatDumper = G.pprint({
    BuildInfo = buildinfo,
    Data = G.pprint(data),
  })
end)
