
local gpio_to_pin = {  -- get number pin
  GPIO5 = 1,
  GPIO4 = 2,
  GPIO0 = 3,
  GPIO2 = 4,
  GPIO14 = 5,
  GPIO12 = 6,
  GPIO13 = 7,
  GPIO15 = 8,
  GPIO3 = 9,
  GPIO1 = 10,
  GPIO9 = 11,
  GPIO10 = 12
}

local function readGPIO(tab)  -- read GPIO

  local pin, response = gpio_to_pin[tab["read"]], {}
  if pin then
--    gpio.mode(pin, gpio.INPUT)
    response[tab["read"]] = gpio.read(pin)
    return response
  end
  return false
end

local function writeGPIO(tab)  -- write GPIO

  local pin, value, response = gpio_to_pin[tab["write"]], tonumber(tab["value"]), {}
  if (pin and (value == 1 or value == 0)) then
    gpio.mode(pin, gpio.OUTPUT)
    gpio.write(pin, value)
    response[tab["write"]] = gpio.read(pin)
    return response
  end
  return response
end

return function (args)   -- args - table with arguments
  local response = false
  if args.read then response = readGPIO(args) end
  if args.write then response = writeGPIO(args) end
 return response  -- The table will be converted to a JSON object.
end
