local _, G = ...

local buildinfo = { _G.GetBuildInfo() }
local data = G.flatdump(_G)

do
  local frame = _G.CreateFrame('Frame')
  frame:RegisterEvent('PLAYER_LOGOUT')
  frame:SetScript('OnEvent', function()
    _G.TheFlatDumperBuildInfo = buildinfo
    _G.TheFlatDumperData = data
  end)
end
