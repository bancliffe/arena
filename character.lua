function make_character()
    local c={}
    c.x=1
    c.y=4
    c.sx=8
    c.sy=0
    c.portrait_sx=40
    c.portrait_sy=0 
    c.name="gnorlash"
    c.rank=0
    c.initiative_modifier=0
    c.dedication=150
    c.patron=nil
    c.favor=0
    c.favor_of_the_crowd=false
    c.determination=0
    c.momentum=0
    c.health_max=flr(rnd(6))+1+15
    c.health_current=c.health_max
    c.bloodied=false
    c.aether_max=flr(rnd(6))+1+10
    c.aether_current=c.aether_max
    c.stamina=10
    c.speed=2
    c.magic_resistance=40
    c.exhaustion=0
    c.shock=0
    c.skills={}
    c.skills["acrobatics"]=10
    c.skills["athletics"]=10
    c.skills["dodge"]=10
    c.skills["endurance"]=0
    c.skills["medicine"]=0
    c.skills["resolve"]=10
    c.skills["stealth"]=0
    c.skills["armor_piercing"]=0
    c.skills["axes"]=0
    c.skills["bows_and_crossbows"]=0
    c.skills["daggers_and_knives"]=0
    c.skills["firearms"]=0
    c.skills["bludgeoning"]=0
    c.skills["slingshots"]=0
    c.skills["spears_and_polearms"]=0
    c.skills["swords"]=0
    c.skills["throwing_weapons"]=0
    c.skills["unarmed_combat_and_fist_weapons"]=0
    c.skills["whips_and_chains"]=0
    c.gear={
        {slot="main_hand",contents=nil},
        {slot="off_hand",contents=nil},
        {slot="belt",contents=nil},
        {slot="armor",contents=nil},
        {slot="helmet",contents=nil},
        {slot="gloves",contents=nil},
        {slot="boots",contents=nil},
        {slot="amulet",contents=nil},
        {slot="ring1",contents=nil},
        {slot="ring2",contents=nil}
    }
    return c
end

function make_enemy()
    local e={}
    e.x=1
    e.y=1
    e.sx=16
    e.sy=0
    e.portrait_sx=48
    e.portrait_sy=0
    e.name="skeletal horror"
    e.role="melee"
    e.type="undead"
    e.size=1
    e.speed=2
    e.initiative_modifier=10
    e.hit_location="head"
    e.hit_type="humanoid"
    e.armor=nil
    e.health=8
    e.combat_skill=40
    e.awareness=40
    e.endurance=40
    e.athletics=40
    e.magic_resistance=30
    e.traits={"frightening"}
    e.actions={
        {roll_check=3,name="cursed slash",type="physical",range=1,targets=1,target_type="creature", damage="D8", effect=""},
        {roll_check=5,name="ethereal grasp",type="magical",range=1,targets=1,target_type="creature", damage="D6",effect=""},
        {roll_check=6,name="haunting wail",type="magical",range="close burst 1",targets=1,target_type="creature", damage="D0",effect="daze"}
    }
    return e
end

function load_weapons()
    weapon_string="melee,bardiche,slashing,spears_and_polearms,2,0,two-handed|melee,bastard sword,slashing,swords,1,5,versatile;parrying|melee,cestus,bludgeoning,unarmed_combat_and_fist_weapons,1,20,simple"
    weapons={}
    local weapon_entries=split(weapon_string,"|")
    for weapon_entry in all(weapon_entries) do
        local w={}
        local weapon_fields=split(weapon_entry,",")
        w.type=weapon_fields[1]
        w.name=weapon_fields[2]
        w.damage_type=weapon_fields[3]
        w.skill=weapon_fields[4]
        w.range=tonum(weapon_fields[5])
        w.speed=tonum(weapon_fields[6])
        w.traits=split(weapon_fields[7],";")
        add(weapons,w)
    end
    return weapons
end