function _init()
    screen_menu_init()

    printh(get_local_time()..": Game started", "log.txt", true)

    _update = screen_menu_update
    _draw = screen_menu_draw
end