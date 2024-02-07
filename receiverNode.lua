-- CC:S Registered ReceiverNode

print("Enter your main computer's ID ")
local homeComputer = io.read()
term.clear()
term.setCursorPos(1,1)
print("Enter your CC:S Broadcast ID ")
local broadcastID = io.read()

peripheral.find("modem", rednet.open)
rednet.host("SatelliteCC", tostring(os.getComputerID()))

while true do
    id,msg = rednet.receive()
    if id == tonumber(broadcastID) then
        local data = msg:sub(1,36)
        rednet.send(homeComputer,data,("RN"..os.getComputerID()))
    end
end
