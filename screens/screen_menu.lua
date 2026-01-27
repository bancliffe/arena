function screen_menu_init()
end

function screen_menu_update()
 if btnp(5) then
        screen_arena_init()
        _update = screen_arena_update
        _draw = screen_arena_draw
    end
end

function screen_menu_draw()
 cls()
 printc("press ❎ to start", 64, 64,7)
end