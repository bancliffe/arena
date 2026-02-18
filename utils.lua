function printc(text,x, y, col)
 local text_width = #text * 4
 print(text, x-text_width/2, y, col)
end

function log(string)
    printh(get_local_time()..": "..string, "log.txt", false)
end

function get_local_time()
    local year = stat(90)
    local month = stat(91)
    local day = stat(92)    
    local hour = stat(93)
    local minute = stat(94)
    local second = stat(95)
    return year.."-"..month.."-"..day.." "..hour..":"..minute..":"..second
end