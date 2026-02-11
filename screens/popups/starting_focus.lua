function popup_starting_focus_update()
    choices={"health_max", "aether_max"}
    if btnp(⬆️) then
        chosen_stat=mid(1,chosen_stat-1,#choices)
    end
    if btnp(⬇️) then
        chosen_stat=mid(1,chosen_stat+1,#choices)
    end
    if btnp(❎) then
        local stat=choices[chosen_stat]
        player_character[choices[chosen_stat]]+=5
        
        -- close popup
        _update=popup_starting_weapon_update
        _draw=popup_starting_weapon_draw
    end
    if btnp(🅾️) then
        -- go back a step and reset character
        player_character = make_character()
        _update=popup_starting_bonus_update
        _draw=popup_starting_bonus_draw
    end
end

function popup_starting_focus_draw()
    cls(0)
    rectfill(1,1,126,9,1)
    printc("character focus",64,3,7)
    printc("choose a starting focus",64,16,7)
    printc("improve health +5",64,58,chosen_stat==1 and 7 or 5)
    printc("improve aether +5",64,64,chosen_stat==2 and 7 or 5) 
end