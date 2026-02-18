function popup_starting_bonus_update()
    choices={"dodge", "athletics", "endurance", "resolve","medicine", "stealth"}   
    if btnp(⬆️) then
        choice=mid(1,choice-1,#choices)
    end
    if btnp(⬇️) then
        choice=mid(1,choice+1,#choices)
    end
    if btnp(❎) then
        local stat=choices[choice]
        player_character.skills[choices[choice]]+=10
        log("chosen starting bonus: "..stat.." +10")
        -- close popup
        _update=popup_starting_focus_update
        _draw=popup_starting_focus_draw
        choice=1
    end
    if btnp(🅾️) then
        -- close popup without choosing
        log("starting bonus popup closed without choosing")
        _update=screen_menu_update
        _draw=screen_menu_draw
    end
end

function popup_starting_bonus_draw()
    cls(0)
    rectfill(1,1,126,9,1)
    printc("character background",64,3,7)
    printc("choose a stat to receive a +10",64,16,7)    
    printc("starting bonus",64,22,7)
    for i=1,#choices do
        printc(choices[i],64,58+(i-1)*6,choice==i and 7 or 5)
    end
end