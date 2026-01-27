function screen_arena_init()
    make_map()    
    -- zoom variables
    zoom=1
    cam_x=0
    cam_y=0
    dest_cam_x=0
    dest_cam_y=0
end

function screen_arena_update()
    if btn(❎) then
        zoom=min(zoom+0.1,4)
    end
    
    if btn(🅾️) then
        zoom=max(zoom-0.1,1)
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
    
    -- draw scaled
    for x=1,map_width do
        for y=1,map_height do
            local tile=map[x][y]
            if tile.enabled then
                local x=tile.x*8*zoom
                local y=tile.y*8*zoom
                local size=8*zoom
                rect(x,y,x+size,y+size,tile.selected and 8 or 7 )
                print(tile.x..","..tile.y,x+2,y+2,7)
            end            
        end
    end
    local tile=map[map_selected_x][map_selected_y]
    local x=tile.x*8*zoom
    local y=tile.y*8*zoom
    local size=8*zoom
    rect(x,y,x+size,y+size,tile.selected and 8 or 7 )
    print(tile.x..","..tile.y,x+2,y+2,7)

    
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