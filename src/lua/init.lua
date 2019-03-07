gpio.mode(2, gpio.INPUT, gpio.PULLUP)  -- (GPIO4) 0 - reset to default settings
print(gpio.read(2))
_s = dofile("init_settings.lua")({def = gpio.read(2)})   -- _s - global variable settings
node.setcpufreq(node.CPU160MHZ)
dofile("init_wifi.lua")(_s)    -- Wi-Fi setup
local mytimer = tmr.create()
mytimer:register(5000, tmr.ALARM_SINGLE, function(t)
  print("Start")


    -- Your code


  t:unregister()
end)
mytimer:start()
