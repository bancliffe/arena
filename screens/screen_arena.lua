function screen_arena_init()
    make_map()    
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
    cls(1)
    fillp(0x8525)
    rectfill(0,0,128,128,0x0001)
    fillp()
    -- set camera and clip
    camera(cam_x,cam_y)
    clip(0,0,128,128)

    draw_map()
    
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
            tile.unit=nil
            tile.terrain=nil
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
    rrectfill(0*zoom,0*zoom,((map_width*8)+16)*zoom,((map_height*8)+16)*zoom,96,13)
    rrectfill(8*zoom,8*zoom,map_width*8*zoom,map_height*8*zoom,96,0) -- ground

    for x=1,map_width do
        for y=1,map_height do
            local tile=map[x][y]
            if tile.enabled then
                local x=tile.x*8*zoom
                local y=tile.y*8*zoom
                local size=7*zoom
                rect(x,y,x+size,y+size,tile.selected and 8 or 5 )
                if tile.unit then
                    palt(0,false)
                    palt(14,true)
                    sspr(tile.unit.sx,tile.unit.sy,8,8,(tile.unit.x)*8*zoom,(tile.unit.y)*8*zoom,8*zoom,8*zoom, false, false)
                    palt()
                end

                if tile.terrain then
                    if tile.terrain=="full_cover" then
                        sspr(24,0,8,8,(tile.x)*8*zoom,(tile.y)*8*zoom,8*zoom,8*zoom, false, false)
                    end
                end
            end            
        end
    end
    -- draw selection rectangle
    local x=map_selected_x*8*zoom
    local y=map_selected_y*8*zoom
    local size=7*zoom
    rect(x,y,x+size,y+size,8)
end

function setup_match()
    local c = make_character()
    map[c.x][c.y].unit=c
    for i=1,2 do
        local e=make_enemy()
        e.name=e.name.." "..i
        e.x=14
        e.y=3+i
        map[e.x][e.y].unit=e
    end
    -- setup random terrain
    for i=1,5 do
        local tx=flr(rnd(map_width-2))+2
        local ty=flr(rnd(map_height-2))+2
        if map[tx][ty].enabled then
            map[tx][ty].terrain="full_cover"
        else
            i-=1
        end
    end
end