function screen_arena_init()
    make_map()    
    -- setup players and enemies
    players={}
    enemies={}
    setup_match()    
    -- zoom variables
    zoom=1
    dest_zoom=2
    cam_x=0
    cam_y=0
    dest_cam_x=0
    dest_cam_y=0
end

function screen_arena_update()
    if btnp(❎) then
        dest_zoom=min(dest_zoom+1,4)
    end
    
    if btnp(🅾️) then
        dest_zoom=max(dest_zoom-1,1)
    end

    map[map_selected_x][map_selected_y].selected=false
    if btnp(⬅️) then
        if map_selected_x>1 and map[map_selected_x-1][map_selected_y].enabled then
            map_selected_x=map_selected_x-1
        end
    end
    if btnp(➡️) then
        if map_selected_x<map_width and map[map_selected_x+1][map_selected_y].enabled then   
            map_selected_x=map_selected_x+1        
        end
    end
    if btnp(⬆️) then
        if map_selected_y>1 and map[map_selected_x][map_selected_y-1].enabled then
            map_selected_y=map_selected_y-1
        end
    end
    if btnp(⬇️) then
        if map_selected_y<map_height and map[map_selected_x][map_selected_y+1].enabled then
            map_selected_y=map_selected_y+1
        end
    end
    map_selected_x=mid(1,map_selected_x,map_width)
    map_selected_y=mid(1,map_selected_y,map_height)
    map[map_selected_x][map_selected_y].selected=true

    -- smooth zooming
    zoom+=(dest_zoom-zoom)*0.2
    -- center camera on selected tile
    local tile_center_x=(map_selected_x*8)*zoom-4*zoom
    local tile_center_y=(map_selected_y*8)*zoom-4*zoom
    dest_cam_x=tile_center_x-64+8*zoom
    dest_cam_y=tile_center_y-64+8*zoom
    
    -- smooth camera movement
    cam_x+=(dest_cam_x-cam_x)*0.2
    cam_y+=(dest_cam_y-cam_y)*0.2
end

function screen_arena_draw()
    cls()
    
    -- set camera and clip
    camera(cam_x,cam_y)
    clip(0,0,128,128)

    draw_map()
    draw_units()

    -- reset camera and clip
    camera()
    clip()
end

function make_map()
    map_width=14
    map_height=9
    map_selected_x=1
    map_selected_y=4
    map={}
    for x=1,map_width do
        local row={}
        for y=1, map_height do
            local tile={}
            tile.x=x
            tile.y=y
            tile.selected=false
            tile.enabled=true
            add(row,tile)
        end
        add(map,row)
    end
    map[map_selected_x][map_selected_y].selected=true

    map[1][1].enabled=false
    map[1][2].enabled=false
    map[1][3].enabled=false
    map[1][7].enabled=false
    map[1][8].enabled=false
    map[1][9].enabled=false
    map[2][1].enabled=false
    map[2][2].enabled=false
    map[2][8].enabled=false
    map[2][9].enabled=false
    map[3][1].enabled=false
    map[3][9].enabled=false
    map[4][1].enabled=false
    map[4][9].enabled=false

    map[14][1].enabled=false
    map[14][2].enabled=false
    map[14][3].enabled=false
    map[14][7].enabled=false
    map[14][8].enabled=false
    map[14][9].enabled=false
    map[13][1].enabled=false
    map[13][2].enabled=false
    map[13][8].enabled=false
    map[13][9].enabled=false
    map[12][1].enabled=false
    map[12][9].enabled=false
    map[11][1].enabled=false
    map[11][9].enabled=false
end

function draw_map()
    for x=1,map_width do
        for y=1,map_height do
            local tile=map[x][y]
            if tile.enabled then
                local x=tile.x*8*zoom
                local y=tile.y*8*zoom
                local size=8*zoom
                rect(x,y,x+size,y+size,tile.selected and 8 or 7 )
            end            
        end
    end
    local tile=map[map_selected_x][map_selected_y]
    local x=tile.x*8*zoom
    local y=tile.y*8*zoom
    local size=8*zoom
    rect(x,y,x+size,y+size,tile.selected and 8 or 7 )
end

function draw_units()
    palt(0,false)
    palt(14,true)
    for c in all(players) do
        sspr(c.sx,c.sy,8,8,(c.x)*8*zoom,(c.y)*8*zoom,8*zoom,8*zoom, false, false)
    end

    for e in all(enemies) do
        sspr(e.sx,e.sy,8,8,(e.x)*8*zoom,(e.y)*8*zoom,8*zoom,8*zoom, false, false)
    end
    palt()
end

function setup_match()
    -- setup the intro match
    local c = make_character()
    log("Player character created: "..c.name)
    add(players,c)
    enemies={}
    for i=1,2 do
        local e=make_enemy()
        e.name=e.name.." "..i
        e.x=14
        e.y=3+i
        log("Enemy created: "..e.name)
        add(enemies,e)
    end
    log("Match setup complete. Players: "..#players..", Enemies: "..#enemies)
end