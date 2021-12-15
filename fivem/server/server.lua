AddEventHandler('onResourceStart', function(resource)
  if resource == GetCurrentResourceName() then
    Wait(50)
    print("roninwashere")
    print("[Server] To Install type /install scriptname")
    print("[Server] To Uninstall type /uninstall scriptname")
    print("[Server] To Update type /update scriptname")
  end
end)
 
local website = Config.Site["address"]

local ipaddress

local path = GetResourcePath(GetCurrentResourceName())

function fix_url(s,C)
  for c in C:gmatch(".") do
      s=s:gsub(c.."+",c)
  end
  return s
end

local sa = fix_url(path, "//")

path = sa .. "/files"

local script = nil

local removesc = nil

RegisterCommand("/install", function(source, args)
  script = args[1]
  commandload()
end)

RegisterCommand("/update", function(source, args)
  script = args[1]
  update(script)
end)

RegisterCommand("/uninstall", function(source, args)
  removesc = args[1]
  remove(removesc)
end)


function commandload()
  federalgay = 0
  install(script)
  for i=1, 10 do
    federalgay = federalgay + 10
    print("[Server] Loading ½" .. federalgay)
  end
  Wait(150)
  print("[Server] Downloaded " .. script .. ".rar")
end

function install(script)
  PerformHttpRequest(website .. '/files/' .. script .. '.rar', function (errorCode, resultDataa, resultHeaders)
    if errorCode == 200 then
      f = io.open(path .. "/" .. script .. ".rar","wb")
      f:write(resultDataa)
      f:close()
    else
      print("[Server] Error Downloading " .. script .. ".rar")
    end
  end, 'GET', '')
end

function remove(script)
  f = io.open(path .. "/" .. script .. ".rar","r")
  if f == nil then 
    print("[Server] " .. script .. ".rar Not Found")
  else
    f:close()
    os.remove(path .. "/" .. script .. ".rar")
    print("[Server] " .. script .. ".rar Removed")
  end
end

function update(script)
  install(script)
end
