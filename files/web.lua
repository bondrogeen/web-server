if not _start then local a,b=net.createServer(net.TCP,10),{}a:listen(80,function(c)local d;c:on("receive",function(c,e)local f=dofile("web_request.lua")(e)if f then d=f.file;b[d]=nil;b[d]=coroutine.create(dofile("web_file.lua"))coroutine.resume(b[d],c,f)end;print(node.heap())end)c:on("sent",function(c)if b[d]then local g=coroutine.status(b[d])if g=="suspended"then local h=coroutine.resume(b[d])if not h then c:close()b[d]=nil;collectgarbage()end elseif g=="dead"then c:close()b[d]=nil;collectgarbage()end end end)end)end;_start=true
