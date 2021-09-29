local _, G = ...

local format, sort, strrep, tinsert = _G.format, _G.sort, _G.strrep, _G.tinsert

local function isarray(t)
  local i = 0
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil then
      return false
    end
  end
  return true
end

function G.pprint(t)
  local strs = {}
  local function append(s)
    tinsert(strs, s)
  end
  local level = 1
  local function indent()
    tinsert(strs, strrep('\t', level))
  end
  local pptkvs
  local function pptv(v)
    local ty = type(v)
    if ty == 'number' then
      append(format('%d,\n', v))
    elseif ty == 'string' then
      append(format('%q,\n', v))
    elseif ty == 'table' then
      if next(v) == nil then
        append('{},\n')
      else
        append('{\n')
        level = level + 1
        pptkvs(v)
        level = level - 1
        indent()
        append('},\n')
      end
    else
      error('invalid table value type ' .. ty)
    end
  end
  function pptkvs(tt)
    if isarray(tt) then
      for _, v in ipairs(tt) do
        indent()
        pptv(v)
      end
    else
      local keys = {}
      for k in pairs(tt) do
        assert(type(k) == 'string')
        tinsert(keys, k)
      end
      sort(keys)
      for _, k in ipairs(keys) do
        indent()
        append(format('[%q] = ', k))
        pptv(tt[k])
      end
    end
  end
  tinsert(strs, '{\n')
  pptkvs(t)
  tinsert(strs, '}\n')
  return table.concat(strs, '')
end
