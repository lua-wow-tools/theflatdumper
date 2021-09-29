local _, G = ...

local buildinfo = { _G.GetBuildInfo() }
local data = G.flatdump(_G)

do
  local f = _G.CreateFrame('Frame', nil, _G.UIParent, 'DialogBoxFrame')
  f:SetPoint('CENTER')
  f:SetSize(600, 500)
  f:SetBackdrop({
    bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background',
    edgeFile = 'Interface\\PVPFrame\\UI-Character-PVP-Highlight',
    edgeSize = 16,
    insets = { left = 8, right = 6, top = 8, bottom = 8 },
  })
  f:SetBackdropBorderColor(0, .44, .87, .5)

  local sf = _G.CreateFrame('ScrollFrame', nil, f, 'UIPanelScrollFrameTemplate')
  sf:SetPoint('LEFT', 16, 0)
  sf:SetPoint('RIGHT', -32, 0)
  sf:SetPoint('TOP', 0, -16)
  sf:SetPoint('BOTTOM', f, 'BOTTOM', 0, 50)

  local eb = _G.CreateFrame('EditBox', nil, sf)
  eb:SetSize(sf:GetSize())
  eb:SetMultiLine(true)
  eb:SetAutoFocus(false)
  eb:SetFontObject('ChatFontNormal')
  sf:SetScrollChild(eb)

  eb:SetText(G.pprint(buildinfo))
  eb:HighlightText()
  f:Show()
end

do
  local frame = _G.CreateFrame('Frame')
  frame:RegisterEvent('PLAYER_LOGOUT')
  frame:SetScript('OnEvent', function()
    _G.TheFlatDumperBuildInfo = buildinfo
    _G.TheFlatDumperData = data
  end)
end
