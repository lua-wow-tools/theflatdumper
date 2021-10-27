local _, G = ...

local toexport = {
  BuildInfo = { _G.GetBuildInfo() },
  Data = G.flatdump(_G),
}

local frame = _G.CreateFrame('Frame')
frame:RegisterEvent('PLAYER_LOGOUT')
frame:SetScript('OnEvent', function()
  _G.TheFlatDumper = _G.LibStub('LibDeflate'):CompressDeflate(G.pprint(toexport))
end)
