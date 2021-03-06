# web-server

Web server for NodeMCU firmware for ESP8266.
Rather, this is the basic template for your projects with a web interface.

[Rus](https://codedevice.ru/archives/604)

## !!! The project develops in a different direction. Details [DoT](https://github.com/bondrogeen/DoT)


## Features

* GET, POST requests
* Parser forms (application / x-www-form-urlencoded and application / json)
* Ability to download additional. files (js, css, ico, txt, jpg).
* Minimum code size in memory, in standby mode.
* Ability to include LUA code in the HTML page. ( \<?lua return(node.chipid()) ?>)
* Run LUA scripts and send them parameters using POST and GET requests.
* Minimal authentication.
* Ability to download compressed files (.gz).

## Structure

### Initialization:
* init.lua - initialization of settings.
* init_settings.lua - getting settings, as well as keeping the default settings.  (GPIO4 to LOW - reset settings)
* init_wifi.lua - connection to the wifi network.

### The server consists of four main scripts:
* web.lua - is the web server itself.
* web_request.lua - analysis of responses from the client.
* web_file.lua - transfer files, run scripts and load html pages with lua code.
* web_control.lua - authentication, saving parameters, obtaining a list of access points.

### Files:
* favicon.ico - icon.
* index.html - home page.
* settings.html - settings page.
* login.html - page authentication.
* settings.js.gz - js script (compressed) for processing and sending forms.
* style.css.gz - style file (compressed).

## Installation

1. The modules you need (file, gpio, net, node, sjson, tmr, uart, wifi). [Building the firmware](https://nodemcu-build.com/)
2. Download all [files](https://github.com/bondrogeen/web-server/tree/master/files) to the module.
3. Connect to the access point **ESP-XXXXXX** and go to the address **192.168.4.1**.
			
![Logo](https://raw.githubusercontent.com/bondrogeen/web-server/master/doc/image/web_server_login.jpg)
			
4. Enter the login (admin) and password (0000).
			
![Logo](https://raw.githubusercontent.com/bondrogeen/web-server/master/doc/image/web_server_index_page.jpg)
			
5. Go to **Settings**.
			
![Logo](https://raw.githubusercontent.com/bondrogeen/web-server/master/doc/image/web_server_settings_page.jpg)

6. Connect to your wi-fi network

## How to work with lua scripts

Example file "my_script.lua"
   
```lua
   
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
   
``` 



Parameters from forms (if any) will be passed to the table ** args **.

http://192.168.1.49/my_script.lua?read=GPIO5 

http://192.168.1.49/my_script.lua?write=GPIO13&value=0


![Logo](https://raw.githubusercontent.com/bondrogeen/web-server/master/doc/image/web_server_my_script.jpg)


## Contributing
Contributions are welcome.

The package is made up of 2 main folders:

- /src (Source files)
- /files (Compiled and compressed files)

To setup and run a local copy:
1. Clone this repo with `git clone https://github.com/bondrogeen/web-server`
2. Run `npm install` in root folder

After installing the dependencies, you can start working with the sources.

3. Run `gilp build` (Compile and compress files)

When you're done working on your changes, submit a PR with the details and include a 
screenshot if you've changed anything visually.


## Restrictions.
The server processes the files in different ways, so for files with the extension .html the reading from the file is progressive, this is done to simplify the processing of the built-in Lua code, there is no limitation on the file size. With files with the .lua extension, the size of the sent data is no more than 4KB.
All other files are transferred byte by byte (1024 bytes at a time), there are also no restrictions on the file size. The server can not receive data more than 1.4KB (data + header). While there was no such need.)))

## Changelog

## 0.2.0 (2019-03-06)
* (bondrogeen) Bug fixes, code optimization. add **src** folder

### 0.1.2 (2018-06-18)
* (bondrogeen) Minor fix.
### 0.1.1 (2018-04-09)
* (bondrogeen) Fixed the problem with the digital password wi-fi.
### 0.1.0 (2018-03-26)
* (bondrogeen) Significantly changed the markup classes (before .xs-12 now .s12 ). Changed the appearance. 
### 0.0.7 (2018-03-22)
* (bondrogeen) Added update of web server files
* (bondrogeen) Fixed bug web_file.lua
### 0.0.6 (2018-03-12)
* (bondrogeen) Fix authentication
### 0.0.5 (2018-03-04)
* (bondrogeen) Added a test firmware, added NodeMCU Flasher
### 0.0.4 (2018-03-03)
* (nedoskiv) Fix memory leak.
* (bondrogeen) Changed the appearance, minor fixes css.
### 0.0.3 (2018-01-25)
* (bondrogeen) Rename web_server.lua to web.lua
### 0.0.2 (2018-01-13)
* (bondrogeen) Changed executeCode()
### 0.0.1 (2017-12-08)
* (bondrogeen) init.