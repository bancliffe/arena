function popup_starting_focus_update()
    choices={"health_max", "aether_max"}
    if btnp(⬆️) then
        choice=mid(1,choice-1,#choices)
    end
    if btnp(⬇️) then
        choice=mid(1,choice+1,#choices)
    end
    if btnp(❎) then
        local stat=choices[choice]
        player_character[choices[choice]]+=5
        log("chosen focus: "..stat.." increased by 5")
        -- close popup
        init_starting_weapon_popup()
        _update=popup_starting_weapon_update
        _draw=popup_starting_weapon_draw
    end
    if btnp(🅾️) then
        -- go back a step and reset character
        log("starting focus popup closed without choosing")
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
    printc("improve health +5",64,58,choice==1 and 7 or 5)
    printc("improve aether +5",64,64,choice==2 and 7 or 5) 
end