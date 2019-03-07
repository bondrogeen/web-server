local setting_default = {
  ssid = "ESP-"..string.format("%x",node.chipid()*256):sub(0,6):upper(),
  pwd = "",
  auth = false,
  mode = 3,
  login = "admin",
  pass = "0000"
}

local function save(fileName, data)
  local status, result = pcall(sjson.encode, data)
  if result and file.open(fileName, "w") then
    file.write(result)
    file.close()
  end
end

local function init(n)
  local state, result
  if file.open(n, "r") then
    state, result = pcall(sjson.decode,file.read())
    file.close()
  end
  return state and result
end

local function def(value)
  local setting, default = value == 1 and init("setting.json")
  default = setting or setting_default
  if not settings then
    save("setting.json", default)
  end
  default.token = tostring(node.random(100000))
  return default
end

local function resave(t)
  local tab = init(t.Fname)
  if tab then
    for key, value in pairs(tab)do
      tab[key] = t[key] == nil and value or t[key]
    end
    save(t.Fname, tab)
    return true
  end
  return false
end

return function(t)
  local r
  if type(t) == "table" then
    if t.list then r = file.list() end
    if t.init then r = init(t.init) end
    if t.save then r = resave(t.save) end
    if t.def then r = def(t.def) end
  end
  return r
end
