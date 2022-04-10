local skynet = require "skynet"
local socket = require "skynet.socket"



local arg = table.pack(...)
assert(arg.n == 2)
local clientfd = tonumber(arg[1]) -- 创建service时传入的参数是字符串,需要类型转换
local addr = arg[2]


local function process_socket_events()
    socket.start(clientfd)
    while true do
        local buf = socket.readline(clientfd)
        if not buf then
            skynet.error("断开连接 : " .. addr)
            return
        end

        skynet.error("recv : " .. buf)
        socket.write(clientfd,buf)
    end
end


skynet.start(function ()
    skynet.fork(process_socket_events) -- 开启一个协程
end)