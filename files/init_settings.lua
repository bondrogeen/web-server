local function def(v)
local s
if file.open("setting.json", "r") and v==1 then
local ok, j = pcall(sjson.decode,file.read('\n'))
s = ok and j or {}
s.token=crypto.toBase64(node.random(100000))
file.close()
else
s={
wifi_id = "ESP-"..string.format("%x",node.chipid()*256):sub(0,6):upper(),
wifi_pass = "",
wifi_mode = "AP",
auth="ON",
auth_login="admin",
auth_pass="0000"
}
s.token=crypto.toBase64(node.random(100000))
end
 return s
end

return function(t)
local r=def(t)
return r
end
