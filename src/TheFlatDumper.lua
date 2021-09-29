local _, G = ...

local buildinfo = { _G.GetBuildInfo() }
local data = G.flatdump(_G)

do
  local f = _G.CreateFrame('Frame', nil, _G.UIParent, 'DialogBoxFrame')
  f:SetPoint('CENTER')
  f:SetSize(600, 100)
  f:SetBackdrop({
    bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background',
    edgeFile = 'Interface\\PVPFrame\\UI-Character-PVP-Highlight',
    edgeSize = 16,
    insets = { left = 8, right = 6, top = 8, bottom = 8 },
  })
  f:SetBackdropBorderColor(0, .44, .87, .5)

  local eb = _G.CreateFrame('EditBox', nil, f)
  eb:SetAllPoints()
  eb:SetFontObject('ChatFontNormal')
  eb:SetText(
    'TheFlatDumperBuildInfo = ' ..  G.pprint(buildinfo) .. '\n' ..
    'TheFlatDumperData = ' .. G.pprint(data) .. '\n')
  eb:HighlightText()
  eb:SetCursorPosition(0)
  f:Show()
end
