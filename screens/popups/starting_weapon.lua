function init_starting_weapon_popup()
    choice=1
    choice_weapon_type=1
end

function popup_starting_weapon_update()
    if btnp(❎) then
        log("chosen weapon: "..weapons_in_type[choice].name)
        player_character.equipment.main_hand=weapons_in_type[choice]
        _update=screen_arena_update
        _draw=screen_arena_draw
    end
    
    if btnp(🅾️) then
        _update=popup_starting_focus_update
        _draw=popup_starting_focus_draw
    end

    if btnp(⬆️) then
        choice=mid(1,choice-1,#weapons_in_type)
    end
    if btnp(⬇️) then
        choice=mid(1,choice+1,#weapons_in_type)
    end
    if btnp(⬅️) then
        choice_weapon_type=mid(1,choice_weapon_type-1,#weapon_types)
        choice=1
    end
    if btnp(➡️) then
        choice_weapon_type=mid(1,choice_weapon_type+1,#weapon_types)
        choice=1
    end
end

function popup_starting_weapon_draw()
    cls(0)
    rectfill(1,1,126,9,1)
    printc("character equipment",64,3,7)
    printc("choose a starting weapon",64,16,7)
    printc("\f5⬅️ \fa"..weapon_types[choice_weapon_type].name.."\f5 ➡️",64+8,26,7)
    weapons_in_type={}
    for weapon in all(weapons) do
        if weapon.skill==weapon_types[choice_weapon_type].skill then
            add(weapons_in_type,weapon)
        end
    end
    for i=1,#weapons_in_type do
        if i==choice then
            print("\#4"..weapons_in_type[i].name,2,36+(i-1)*6,7)
        else
            print(weapons_in_type[i].name,2,36+(i-1)*6,5)
        end
    end
    draw_weapon_preview()
end

function draw_weapon_preview()
    rrectfill(64,36,62,90,8,1)
    if #weapons_in_type==0 then return end
    palt(14,true)
    palt(0,false)
    sspr(weapons_in_type[choice].icon_sx,weapons_in_type[choice].icon_sy,8,8,86,42,16,16,false,false)
    palt()
    print("range:\t"..weapons_in_type[choice].range,66,64,7)
    print("speed:\t"..weapons_in_type[choice].speed,66,71,7)
    print("dmg:",66,78,7)
    print("\t"..weapons_in_type[choice].damage_type,66,85,7)    
    print("traits:",66,92,7)
    for i=1,#weapons_in_type[choice].traits do
        print("\t"..weapons_in_type[choice].traits[i],66,93+(i*6),7)
    end
end