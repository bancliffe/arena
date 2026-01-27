function printc(text,x, y, col)
 local text_width = #text * 4
 print(text, x-text_width/2, y, col)
end