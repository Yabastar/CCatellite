-- REGISTERED CC:S BROADCAST SYSTEM. DO NOT INTERFERE, REBOOT SYSTEM IMMEDIATELY

local random = math.random
math.randomseed(os.time()^5)
rednet.open(peripheral.find("modem"))
rednet.host("SatelliteCC", os.getComputerID())

local function mainLoop()
    while true do
        local id,msg = rednet.receive("SatelliteCC")
        local uuidData = msg:sub(37)
        local cache = fs.open(".cache", "r+")
        local done = false
        local accept = true
        repeat
            local line = cache.readLine()
            if line == nil then
                done = true
            else
                if line == uuidData then
                    accept = false
                end
                
            end
        until done == true
        if accept == true then
            cache.write(uuidData.."\n")
            cache.close()
            rednet.broadcast(msg, "SatelliteCC")
        end
    end
end

local satelid = os.getComputerID()

local function wipeCache()
    while true do
        print(".cache wipe in 30s id"..satelid)
        sleep(10)
        term.clear()
        term.setCursorPos(1,1)
        print(".cache wipe in 20s id"..satelid)
        sleep(10)
        term.clear()
        term.setCursorPos(1,1)
        print(".cache wipe in 10s id"..satelid)
        sleep(10)
        term.clear()
        term.setCursorPos(1,1)
        
        local wipeCache = fs.open(".cache", "w")
        wipeCache.close()
    end
end

local function runParallel()
    parallel.waitForAny(mainLoop, wipeCache)
end
local _,ret = pcall(runParallel())
term.clear()
term.setCursorPos(1,1)
print("If you are seeing this message, something went wrong. Please reboot the system.")
print(ret)
while true do
      redstone.setOutput("back", not redstone.getOutput("back"))
      sleep(0.5)
end
