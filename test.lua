local skynet = require "skynet"
local socket = require "skynet.socket"


-- 演示RPC的调用
local function accept(clientfd, addr)
    skynet.error(string.format("client : %d, addr : %s", clientfd, addr))
	skynet.newservice("myAgent", clientfd, addr)
end

skynet.start(function()
	local listenfd = socket.listen("0.0.0.0", 8888)
	socket.start(listenfd, accept)
end
)