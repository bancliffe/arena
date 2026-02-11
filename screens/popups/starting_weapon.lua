
function popup_starting_weapon_update()
    if btnp(❎) then
        _update=screen_arena_update
        _draw=screen_arena_draw
    end
    
    if btnp(🅾️) then
        _update=popup_starting_focus_update
        _draw=popup_starting_focus_draw
    end
end

function popup_starting_weapon_draw()
    cls(0)
    rectfill(1,1,126,9,1)
    printc("character equipment",64,3,7)
    printc("choose a starting weapon",64,16,7)
end