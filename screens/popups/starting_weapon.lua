
function popup_starting_weapon_update()
    if btnp(❎) then
        log("chosen weapon: "..weapons[chosen_stat].name)
        player_character.equipment.main_hand=weapons[chosen_stat]
        _update=screen_arena_update
        _draw=screen_arena_draw
    end
    
    if btnp(🅾️) then
        _update=popup_starting_focus_update
        _draw=popup_starting_focus_draw
    end

    if btnp(⬆️) then
        chosen_stat=mid(1,chosen_stat-1,#weapons)
    end
    if btnp(⬇️) then
        chosen_stat=mid(1,chosen_stat+1,#weapons)
    end
end

function popup_starting_weapon_draw()
    cls(0)
    rectfill(1,1,126,9,1)
    printc("character equipment",64,3,7)
    printc("choose a starting weapon",64,16,7)
    for i=1,#weapons do
        if i==chosen_stat then
            print("\#4"..weapons[i].name,2,58+(i-1)*6,7)
        else
            print(weapons[i].name,2,58+(i-1)*6,5)
        end
    end
end