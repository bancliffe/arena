function make_character()
    local c={}
    c.x=1
    c.y=4
    c.sx=8
    c.sy=0
    c.name="Gnorlash"
    c.rank=0
    c.initiative_modifier=0
    c.dedication=150
    c.patron=nil
    c.favor=0
    c.favor_of_the_crowd=false
    c.determination=0
    c.momentum=0
    c.health_max=rnd(6)+1+15
    c.health_current=c.health_max
    c.bloodied=false
    c.aether_max=rnd(6)+1+10
    c.aether_current=c.aether_max
    c.stamina=10
    c.speed=2
    c.magic_resistance=40
    c.exhaustion=0
    c.shock=0
    c.skills={
        {skill="acrobatics",value=10},
        {skill="athletics",value=10},
        {skill="dodge",value=10},
        {skill="endurance",value=0},
        {skill="medicine",value=0},
        {skill="resolve",value=10},
        {skill="stealth",value=0},
        {skill="armor_piercing",value=0},
        {skill="axes",value=0},
        {skill="bows_and_crossbows",value=0},
        {skill="daggers_and_knives",value=0},
        {skill="firearms",value=0},
        {skill="bludgeoning",value=0},
        {skill="slingshots",value=0},
        {skill="spears_and_polearms",value=0},
        {skill="swords",value=0},
        {skill="throwing_weapons",value=0},
        {skill="unarmed_combat",value=0},
        {skill="whips_and_chains",value=0}
    }    
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