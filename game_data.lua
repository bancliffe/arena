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
    c.skills["fist"]=0
    c.skills["whips_and_chains"]=0
    c.equipment={
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
    log("loaded weapons from string")
    weapon_string="melee,bardiche,slashing,spears_and_polearms,2,0,two-handed,0,8|melee,bastard sword,slashing,swords,1,5,versatile;parrying,8,8|melee,billhook,slashing,spears_and_polearms,2,0,two-handed,16,8|melee,cestus,bludgeoning,fist,1,20,simple,24,8|melee,claw,slashing,fist,1,20,parrying,32,8|melee,club,bludgeoning,bludgeoning_weapons,1,5,simple,40,8|melee,dagger,piercing,daggers_and_knives,1,20,thrown,48,8|melee,flail,bludgeoning,bludgeoning_weapons,1,5,none,56,8|melee,footman's maul,bludgeoning,spear_and_polearms,2,-10,two-handed,64,8|melee,glaive,slashing,spears_and_polearms,2,0,two-handed,72,8|melee,greataxe,slashing,axes,1,-10,two-handed,80,8"
    weapons={}
    weapon_types={{skill="spears_and_polearms",name="spears & polearms"},{skill="swords",name="swords"},{skill="fist",name="fist"},{skill="daggers_and_knives",name="daggers & knives"},{skill="bludgeoning",name="bludgeoning"},{skill="axes",name="axes"},{skill="whip_and_chains",name="whip & chains"},{skill="armor_piercing",name="armor piercing"},{skill="firearms",name="firearms"},{skill="slingshots",name="slingshots"},{skill="throwing",name="throwing"},{skill="bows_and_crossbows",name="bows & crossbows"}}
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
        w.icon_sx=tonum(weapon_fields[8])
        w.icon_sy=tonum(weapon_fields[9])
        add(weapons,w)        
    end
    return weapons
end

function load_armor()
    log("loading armor from string")
    armor_string="harness,0,0,maneuverability:+10|heavy cloth,1,d4,maneuverability:+5|soft leather,1,d6,maneuverability:+5|studded leather,2,d8,maneuverability:+0|chainmail,3,d10,maneuverability:-5|plate,4,d12,maneuverability:+0|hide scale,1,d8,maneuverability:-5|mail,1,d10,maneuverability:-10|brigandine,2,d10,maneuverability:-15;max_stamina:-2|plate,3,d12,maneuverability:-20;max_stamina:-4"
    armor={}
    local armor_entries=split(armor_string,"|")
    for armor_entry in all(armor_entries) do
        local a={}
        local armor_fields=split(armor_entry,",")
        a.name=armor_fields[1]
        a.protection=armor_fields[2]
        a.integrity=armor_fields[3]
        local traits=split(armor_fields[4],";")
        a.stat_changes=traits
        add(armor,a)        
    end
    return armor
end