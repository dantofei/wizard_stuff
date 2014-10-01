--author:MrKopa
--version:30-09-14/DD-MM-YY
--name : wizard_stuff

-------------------------------------------------------------
--nodes register
minetest.register_node("wizard_stuff:redunium_ore",{
  tiles = {'redunium_ore.png'},
  description = "Redunium Ore",
  is_ground_content = true,
  groups = {cracky=3,stone=1},
  drop = "wizard_stuff:redunium_shard",
  legacy_mineral = true,
  })

minetest.register_node("wizard_stuff:greenium_ore",{
  tiles = {'greenium_ore.png'},
  description = "Greenium Ore",
  is_ground_content = true,
  groups = {cracky=3,stone=1},
  drop = "wizard_stuff:greenium_shard",
  legacy_mineral = true,
  })

minetest.register_node("wizard_stuff:bluminium_ore",{
  tiles = {'bluminium_ore.png'},
  description = "Bluminium Ore",
  is_ground_content = true,
  groups = {cracky=3,stone=1},
  drop = "wizard_stuff:bluminium_shard",
  legacy_mineral = true,
  })

minetest.register_node("wizard_stuff:yellonium_ore",{
  tiles = {'yellonium_ore.png'},
  description = "Yellonium Ore",
  is_ground_content = true,
  groups = {cracky=3,stone=1},
  drop = "wizard_stuff:yellonium_shard",
  legacy_mineral = true,
  })

-------------------------------------------------------------
--ore register
minetest.register_ore({
  ore_type = "scatter",
  ore      = "wizard_stuff:bluminium_ore",
  wherein  = "default:stone",
  clust_scarcity = 4*8*4,
  clust_num_ores = 2,
  clust_size = 2,
  height_min = -31000,
  height_max = -100,
  })

minetest.register_ore({
  ore_type = "scatter",
  ore      = "wizard_stuff:redunium_ore",
  wherein  = "default:stone",
  clust_scarcity = 4*8*4,
  clust_num_ores = 2,
  clust_size = 2,
  height_min = -31000,
  height_max = -300,
  })

minetest.register_ore({
  ore_type = "scatter",
  ore      = "wizard_stuff:greenium_ore",
  wherein  = "default:stone",
  clust_scarcity = 4*8*4,
  clust_num_ores = 2,
  clust_size = 2,
  height_min = -31000,
  height_max = -600,
  })

minetest.register_ore({
  ore_type = "scatter",
  ore      = "wizard_stuff:yellonium_ore",
  wherein  = "default:stone",
  clust_scarcity = 4*8*4,
  clust_num_ores = 2,
  clust_size = 2,
  height_min = -31000,
  height_max = -1200,
  })

-------------------------------------------------------------
--register items

minetest.register_craftitem("wizard_stuff:bluminium_shard",{
  description = "Bluminium shard",
  inventory_image = "bluminium_shard.png",
  })

minetest.register_craftitem("wizard_stuff:redunium_shard",{
  description = "Redunium shard",
  inventory_image = "redunium_shard.png",
  })

minetest.register_craftitem("wizard_stuff:greenium_shard",{
  description = "Greenium shard",
  inventory_image = "greenium_shard.png",
  })

minetest.register_craftitem("wizard_stuff:yellonium_shard",{
  description = "Yellonium shard",
  inventory_image = "yellonium_shard.png",
  })

minetest.register_craftitem("wizard_stuff:shard_star",{
  description = "Shard Star",
  inventory_image = "shard_star.png",
  })

-------------------------------------------------------------
--register tools

minetest.register_tool("wizard_stuff:star_staff",{
  description = "Magical Star Staff",
  inventory_image = "star_staff.png",
  tool_capabilities = {
    full_punch_interval = 0.9,
    max_drop_level=3,
    groupcaps={
      cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=10, maxlevel=3},
    },
    damage_groups = {fleshy=50},
  },

on_use = function(itemstack,user, pointed_thing)
            if pointed_thing.under then
              local p = pointed_thing.under
              local wear = 3
               
                 minetest.chat_send_player(user:get_player_name(),"The position is "..p.y)

                    for zi = p.z-1, p.z+1 do
                      for yi = p.y-1, p.y+1 do
                        for xi = p.x-1, p.x+1 do
                         local thisNode = minetest.env:get_node({x=xi,y=yi,z=zi})
                         local inv = user:get_inventory()
                          
                          if inv:room_for_item("main",{name = thisNode.name}) and thisNode.name ~= "ignore" and thisNode.name ~= "default:water_source" 
                                                                                                       and thisNode.name ~= "default:water_flowing" then

                                if thisNode.name ~= "air" then
                                      inv:add_item("main",{name=thisNode.name})
                                      minetest.chat_send_player(user:get_player_name(),"You got a "..thisNode.name)
                                end
                                wear = wear+3
                              itemstack:add_wear(wear)
                              minetest.env:dig_node({x=xi,y=yi,z=zi})

                             else
                               minetest.chat_send_player(user:get_player_name(),"Inventory full!")
                          end
                        end
                      end
                    end
            end
             return itemstack
          end,
 })


-------------------------------------------------------------
--crafting recipes
minetest.register_craft({
            output = 'wizard_stuff:shard_star 1',
            recipe = {
               {'','wizard_stuff:bluminium_shard' ,''},
               { 'wizard_stuff:redunium_shard','default:gold_block','wizard_stuff:greenium_shard'},
               {'','wizard_stuff:yellonium_shard',''},
            }
            }) 

minetest.register_craft({
            output = 'wizard_stuff:star_staff 1',
            recipe = {
               {'default:gold_ingot','wizard_stuff:shard_star' ,'default:gold_ingot'},
               { 'default:gold_block','default:tree','default:gold_block'},
               {'','default:stick',''},
            }
            })