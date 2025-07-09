-- Warhammer 40K: Imperium Outpost Scenario
-- Enhanced with proper 40K styling and atmosphere

-- Load the Imperial Shop module
local imperial_shop = require("imperial-shop")

-- Store scenario state
global = global or {}
global.scenario = global.scenario or {}
global.scenario.objective_complete = global.scenario.objective_complete or {}
global.scenario.messages_shown = global.scenario.messages_shown or {}
global.scenario.imperium_rank = global.scenario.imperium_rank or "Initiate"
global.scenario.timeline_day = global.scenario.timeline_day or 1
global.scenario.autogun_count = global.scenario.autogun_count or 0
global.scenario.token_count = global.scenario.token_count or 0

-- Initialize script globals
script.on_init(function()
    global.scenario = global.scenario or {}
    global.scenario.objective_complete = global.scenario.objective_complete or {}
    global.scenario.messages_shown = global.scenario.messages_shown or {}
    global.scenario.imperium_rank = global.scenario.imperium_rank or "Initiate"
    global.scenario.timeline_day = global.scenario.timeline_day or 1
    global.scenario.autogun_count = global.scenario.autogun_count or 0
    global.scenario.token_count = global.scenario.token_count or 0
    
    log("Imperium Outpost initialized")
end)

-- Player created event
script.on_event(defines.events.on_player_created, function(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    
    -- Set dark evening/night time
    game.surfaces[1].always_day = false
    game.surfaces[1].daytime = 0.85  -- Evening/dusk time
    
    -- Set map settings for a grimmer atmosphere
    game.map_settings.pollution.enabled = true
    game.map_settings.pollution.diffusion_ratio = 0.1
    game.map_settings.pollution.ageing = 0.5
    
    -- Increase enemy response to pollution
    game.map_settings.enemy_evolution.pollution_factor = game.map_settings.enemy_evolution.pollution_factor * 1.5
    
    -- Create Imperial Shop north of player
    local shop_position = {x = player.position.x, y = player.position.y - 8}
    local shop = imperial_shop.create_imperial_shop(player.surface, shop_position)
    
    -- Set starting equipment
    player.clear_items_inside()
    player.insert({name = "rusted-stub-gun", count = 1})
    player.insert({name = "improvised-shovel", count = 1})
    player.insert({name = "iron-plate", count = 20})
    player.insert({name = "copper-plate", count = 20})
    player.insert({name = "wood", count = 20})
    player.insert({name = "burner-mining-drill", count = 5})
    player.insert({name = "stone-furnace", count = 5})
    
    -- Show introduction dialog with ASCII styling
    game.show_message_dialog{
        text = [[
==================================
          IMPERIAL ASSIGNMENT
==================================

In the grim darkness of the far future, there is only war...

Servant of the Emperor, you have been assigned to establish a manufacturing outpost on this forsaken frontier world. Initial auspex scans indicate plentiful resources, but the machine spirits also whisper of xenos taint.

Your standing orders from the Departmento Munitorum are as follows:

+ Establish a manufacturing base in the Emperor's name
+ Produce weapons for His Holy Imperial Guard 
+ Defend against the inevitable xenos incursions

Remember that failure is heresy. Success brings glory to the Imperium.

==================================
        THE EMPEROR PROTECTS
==================================
]],
        caption = "IMPERIAL ASSIGNMENT"
    }
    
    -- Rich text formatting for chat messages
    game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
    game.print("[color=yellow]+ IMPERIAL ASSIGNMENT +[/color]")
    game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
    game.print("In the grim darkness of the far future, there is only war...")
    game.print("The Emperor protects the vigilant.")
    game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
    
    -- Set first objective
    game.print("[color=green]>>> IMPERIAL OBJECTIVE: Research STC Fragments technology[/color]")
    
    -- Welcome message with 40K style
    game.print("")
    game.print("Welcome, servant of the Emperor! You have been equipped with basic salvage.")
    game.print("Seek out STC fragments to unlock the sacred knowledge of Imperial weaponry.")
    game.print("[color=orange]For the Emperor! Death to the heretics![/color]")
    
    -- Inform about the shop
    game.print("[color=yellow]IMPERIAL NOTICE: The Departmento Munitorum has established an exchange post to the north of your position.[/color]")
    
    -- Inform about chat commands
    game.print("[color=yellow]IMPERIAL INFORMATION: Type !status or !prayer in chat to access Imperial services[/color]")
    
    -- Schedule first event
    schedule_next_event()
end)

-- Monitor technology research
script.on_event(defines.events.on_research_finished, function(event)
    local research = event.research
    
    -- STC Fragments completed
    if research.name == "stc-fragments" and not global.scenario.objective_complete.stc_fragments then
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        game.print("[color=green]+ OBJECTIVE COMPLETE +[/color]")
        game.print("[color=green]STC Fragments technology researched[/color]")
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        
        game.print("[color=green]>>> IMPERIAL OBJECTIVE: Produce 10 Autoguns for the Imperial Guard[/color]")
        
        game.print("[color=red]>>> ADEPTUS MECHANICUS TRANSMISSION <<<[/color]")
        game.print("[color=red]The sacred knowledge of the Omnissiah flows through your cogitators[/color]")
        
        global.scenario.objective_complete.stc_fragments = true
        
        -- Spawn resources nearby
        spawn_bonus_resources()
        
        -- Schedule a small attack when first tech is completed
        schedule_small_attack()
    end
    
    -- Tech Priest Arsenal completed
    if research.name == "tech-priest-arsenal" and not global.scenario.objective_complete.tech_priest then
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        game.print("[color=green]+ OBJECTIVE COMPLETE +[/color]")
        game.print("[color=green]Advanced weaponry research completed[/color]")
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        
        game.print("[color=red]>>> ADEPTUS MECHANICUS: The Adeptus Mechanicus recognizes your technological progress[/color]")
        global.scenario.imperium_rank = "Tech-Adept"
        update_player_ranks()
    end
    
    -- Omnissian Sanctum completed
    if research.name == "omnissian-sanctum" and not global.scenario.objective_complete.omnissian then
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        game.print("[color=green]+ OBJECTIVE COMPLETE +[/color]")
        game.print("[color=green]Omnissian Sanctum technology mastered[/color]")
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        
        game.print("[color=red]>>> ADEPTUS MECHANICUS: The Fabricator-General has noted your exceptional service[/color]")
        global.scenario.imperium_rank = "Magos"
        update_player_ranks()
        global.scenario.objective_complete.omnissian = true
        
        -- Spawn major attack when highest tech is reached
        schedule_major_attack()
    end
end)

-- Track production of items
script.on_event(defines.events.on_picked_up_item, function(event)
    check_production_goals(event.item_stack)
end)

script.on_event(defines.events.on_player_crafted_item, function(event)
    check_production_goals(event.item_stack)
end)

-- Check if production goals are met
function check_production_goals(item_stack)
    if not item_stack then return end
    
    -- Check autogun production
    if item_stack.name == "autogun" then
        global.scenario.autogun_count = (global.scenario.autogun_count or 0) + item_stack.count
        
        if global.scenario.autogun_count >= 10 and not global.scenario.objective_complete.autogun_production then
            game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
            game.print("[color=green]+ OBJECTIVE COMPLETE +[/color]")
            game.print("[color=green]10 Autoguns produced[/color]")
            game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
            
            game.print("[color=green]>>> IMPERIAL OBJECTIVE: Research Adept Armaments technology[/color]")
            
            game.print("[color=blue]### DATUM: Imperial Guard regiment supplied with basic firearms[/color]")
            
            global.scenario.objective_complete.autogun_production = true
            
            -- Schedule small attack when first weapons goal is met
            schedule_small_attack()
        end
    end
    
    -- Check requisition token production
    if item_stack.name == "imperial-requisition-token" then
        global.scenario.token_count = (global.scenario.token_count or 0) + item_stack.count
        
        if global.scenario.token_count >= 100 and not global.scenario.objective_complete.token_production then
            game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
            game.print("[color=green]+ OBJECTIVE COMPLETE +[/color]")
            game.print("[color=green]100 Imperial Requisition Tokens produced[/color]")
            game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
            
            game.print("[color=purple]!!! INQUISITION: Your service to the Imperium has been recognized[/color]")
            global.scenario.objective_complete.token_production = true
            global.scenario.imperium_rank = "Sergeant"
            update_player_ranks()
            
            -- Spawn medium attack when token goal is met
            schedule_medium_attack()
        end
    end
    
    -- Check for high-tier weapon production
    if (item_stack.name == "conversion-beamer" or 
        item_stack.name == "master-crafted-volkite-culverin" or
        item_stack.name == "grav-gun") and 
        not global.scenario.objective_complete.relic_weapon then
        
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        game.print("[color=green]+ OBJECTIVE COMPLETE +[/color]")
        game.print("[color=green]Relic weapon produced[/color]")
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        
        game.print("[color=red]>>> ADEPTUS MECHANICUS: The Omnissiah's blessing flows through this sacred technology[/color]")
        global.scenario.objective_complete.relic_weapon = true
        
        -- Grant bonus resources
        for _, player in pairs(game.players) do
            player.insert({name = "imperial-requisition-token", count = 50})
        end
    end
end

-- Schedule a small attack (after autogun production)
function schedule_small_attack()
    -- Schedule attack in 5 minutes
    game.print("[color=orange]*** WARNING: Auspex scans indicate xenos movement in the area[/color]")
    
    script.on_nth_tick(18000, function(event) -- 5 minutes (60 ticks * 60 seconds * 5 minutes)
        spawn_attack("small")
        script.on_nth_tick(18000, nil) -- Clear this callback
    end)
end

-- Schedule a medium attack (after token production)
function schedule_medium_attack()
    -- Schedule attack in 10 minutes
    game.print("[color=red]!!! ALERT: Astropathic warning received. Xenos warband approaching.[/color]")
    
    script.on_nth_tick(36000, function(event) -- 10 minutes
        spawn_attack("medium")
        script.on_nth_tick(36000, nil) -- Clear this callback
    end)
end

-- Schedule a major attack (after Omnissian tech)
function schedule_major_attack()
    -- Schedule attack in 15 minutes
    game.print("[color=red]!!! ALERT: The Omnissiah warns of a major xenos assault imminent![/color]")
    
    script.on_nth_tick(54000, function(event) -- 15 minutes
        spawn_attack("large")
        script.on_nth_tick(54000, nil) -- Clear this callback
    end)
end

-- Schedule next timeline event
function schedule_next_event()
    -- Every 30 minutes of game time, advance the scenario
    script.on_nth_tick(108000, function(event) -- 30 minutes
        advance_timeline()
        script.on_nth_tick(108000, nil) -- Clear this callback
        schedule_next_event() -- Schedule next event
    end)
end

-- Advance the scenario timeline
function advance_timeline()
    global.scenario.timeline_day = global.scenario.timeline_day + 1
    
    -- Different events based on day
    if global.scenario.timeline_day == 2 then
        game.print("[color=blue]### DATUM: DAY 2: Imperial Vox-Communication received[/color]")
        game.print("[color=lightgrey]The local Planetary Governor requests additional weapons shipment[/color]")
    elseif global.scenario.timeline_day == 3 then
        game.print("[color=blue]### DATUM: DAY 3: Astropathic message intercepted[/color]")
        game.print("[color=orange]*** WARNING: Reports indicate increasing xenos activity in neighboring systems[/color]")
        spawn_attack("small")
    elseif global.scenario.timeline_day == 4 then
        game.print("[color=green]--- NOTICE: DAY 4: Imperial reinforcements incoming[/color]")
        game.print("[color=blue]### DATUM: A supply drop has been authorized for your outpost[/color]")
        drop_supplies()
    elseif global.scenario.timeline_day >= 5 then
        -- After day 5, just cycle between attacks and supplies
        if global.scenario.timeline_day % 2 == 0 then
            game.print("[color=green]--- NOTICE: Imperial supply drop incoming[/color]")
            drop_supplies()
        else
            game.print("[color=orange]*** WARNING: Xenos activity detected![/color]")
            spawn_attack(global.scenario.timeline_day > 8 and "medium" or "small")
        end
    end
end

-- Spawn an attack on the player base
function spawn_attack(size)
    -- Get all players and their forces
    for _, player in pairs(game.players) do
        local surface = player.surface
        local position = player.position
        local distance = size == "small" and 100 or (size == "medium" and 150 or 200)
        
        -- Calculate attack direction (random)
        local angle = math.random() * 2 * math.pi
        local spawn_position = {
            x = position.x + distance * math.cos(angle),
            y = position.y + distance * math.sin(angle)
        }
        
        -- Determine enemy count based on attack size
        local enemy_count = size == "small" and 10 or (size == "medium" and 20 or 40)
        
        -- Spawn enemies
        for i = 1, enemy_count do
            local offset_angle = angle + (math.random() - 0.5) * math.pi / 2
            local offset_distance = distance + (math.random() - 0.5) * 20
            local enemy_position = {
                x = position.x + offset_distance * math.cos(offset_angle),
                y = position.y + offset_distance * math.sin(offset_angle)
            }
            
            -- Determine enemy type based on attack size
            local enemy_type = "small-biter"
            if size == "medium" then
                enemy_type = math.random() < 0.7 and "medium-biter" or "small-spitter"
            elseif size == "large" then
                local roll = math.random()
                if roll < 0.4 then
                    enemy_type = "big-biter"
                elseif roll < 0.7 then
                    enemy_type = "medium-spitter"
                else
                    enemy_type = "medium-biter"
                end
            end
            
            -- Create the enemy
            surface.create_entity{name = enemy_type, position = enemy_position}
        end
        
        -- Announce attack with 40K flavor
        local xenos_type = size == "small" and "Tyranid scout organisms" or 
                          (size == "medium" and "Tyranid warrior brood" or 
                          "Tyranid assault synapse creatures")
        
        game.print("[color=red]!!! ALERT: " .. xenos_type .. " attacking from " .. direction_name(angle) .. "![/color]")
        
        -- Add thematic alert sound
        game.play_sound{path = "utility/combat_robot_destroyed"}
    end
end

-- Convert angle to direction name
function direction_name(angle)
    local directions = {"north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest"}
    local index = math.floor(((angle + math.pi/8) % (2*math.pi)) / (math.pi/4)) + 1
    return directions[index]
end

-- Spawn bonus resources
function spawn_bonus_resources()
    for _, player in pairs(game.players) do
        local surface = player.surface
        local position = player.position
        local distance = 50
        
        -- Calculate resource position (random direction)
        local angle = math.random() * 2 * math.pi
        local spawn_position = {
            x = position.x + distance * math.cos(angle),
            y = position.y + distance * math.sin(angle)
        }
        
        -- Create ore patch
        surface.create_entity{
            name = "iron-ore", 
            position = spawn_position, 
            amount = 5000
        }
        
        -- Create a few more entities in the patch
        for i = 1, 50 do
            local offset_x = math.random(-10, 10)
            local offset_y = math.random(-10, 10)
            surface.create_entity{
                name = "iron-ore", 
                position = {spawn_position.x + offset_x, spawn_position.y + offset_y}, 
                amount = 5000
            }
        end
        
        game.print("[color=red]>>> ADEPTUS MECHANICUS: Auspex scan reveals resources at " .. direction_name(angle) .. "[/color]")
    end
end

-- Drop supplies from orbit
function drop_supplies()
    for _, player in pairs(game.players) do
        local surface = player.surface
        local position = player.position
        
        -- Calculate drop position (near player)
        local offset_x = math.random(-20, 20)
        local offset_y = math.random(-20, 20)
        local drop_position = {
            x = position.x + offset_x,
            y = position.y + offset_y
        }
        
        -- Create supply chest with dramatic effect
        game.play_sound{path = "utility/alert_destroyed", volume_modifier = 1.5}
        
        -- Try to create a crater
        for i = 1, 5 do
            local crater_x = drop_position.x + math.random(-3, 3)
            local crater_y = drop_position.y + math.random(-3, 3)
            surface.create_entity{
                name = "massive-explosion", 
                position = {crater_x, crater_y}
            }
        end
        
        -- Wait a moment before creating the chest
        script.on_nth_tick(10, function()
            -- Create supply chest
            local chest = surface.create_entity{
                name = "steel-chest", 
                position = drop_position, 
                force = "player"
            }
            
            -- Fill with supplies based on player's tech level
            if chest and chest.valid then
                -- Basic supplies
                chest.insert({name = "iron-plate", count = 50})
                chest.insert({name = "copper-plate", count = 50})
                
                -- Add weapons based on tech level
                if global.scenario.objective_complete.stc_fragments then
                    chest.insert({name = "autogun", count = 5})
                end
                
                if game.forces.player.technologies["adept-armaments"].researched then
                    chest.insert({name = "heavy-stubber", count = 2})
                    chest.insert({name = "improved-lasrifle", count = 3})
                end
                
                if game.forces.player.technologies["tech-priest-arsenal"].researched then
                    chest.insert({name = "arc-rifle", count = 1})
                    chest.insert({name = "plasma-caliver", count = 1})
                end
                
                -- Advanced supplies for late game
                if game.forces.player.technologies["forge-world-relics"].researched then
                    chest.insert({name = "processing-unit", count = 20})
                    chest.insert({name = "imperial-requisition-token", count = 20})
                end
            end
            
            -- Notify player
            game.print("[color=green]--- NOTICE: Munitorum supply drop has landed near your position[/color]")
            script.on_nth_tick(10, nil) -- Clear callback
        end)
    end
end

-- Update player ranks based on scenario progress
function update_player_ranks()
    for _, player in pairs(game.players) do
        game.print("[color=green]--- NOTICE: PROMOTION: You have been elevated to the rank of " .. global.scenario.imperium_rank .. "[/color]")
        
        -- Add a custom floating text for dramatic effect
        player.surface.create_entity{
            name = "flying-text",
            position = player.position,
            text = "RANK: " .. global.scenario.imperium_rank,
            color = {r=1, g=0.7, b=0.1}
        }
    end
end

-- Imperial status function
function show_imperial_status(player)
    if not player then return end
    
    local token_count = global.scenario.token_count or 0
    local autogun_count = global.scenario.autogun_count or 0
    local rank = global.scenario.imperium_rank or "Initiate"
    local day = global.scenario.timeline_day or 1
    
    -- Stylized service record
    game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
    game.print("[color=yellow]+ IMPERIAL SERVICE RECORD +[/color]")
    game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
    game.print("+ SERVANT: " .. player.name)
    game.print("[color=yellow]+ RANK: " .. rank .. "[/color]")
    game.print("+ DAYS IN SERVICE: " .. day)
    game.print("+ REQUISITION TOKENS: " .. token_count)
    game.print("+ WEAPONS PRODUCTION: " .. autogun_count)
    game.print("[color=red]+ STATUS: " .. (token_count >= 500 and "EXEMPLARY" or 
                                token_count >= 100 and "COMMENDABLE" or 
                                "ACCEPTABLE") .. "[/color]")
    game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
    game.print("[color=red]+ THE EMPEROR PROTECTS +[/color]")
    game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
end

-- Use chat commands instead of slash commands to avoid conflicts
script.on_event(defines.events.on_console_chat, function(event)
    if not event.player_index then return end
    local player = game.get_player(event.player_index)
    if not player then return end
    
    local message = event.message
    
    -- Check for status request in chat
    if message == "!status" or message == "!imperial-status" then
        show_imperial_status(player)
        return
    end
    
    -- Check for prayer request in chat
    if message == "!prayer" or message == "!imperial-prayer" then
        -- Imperial prayer function
        local prayers = {
            "The Emperor protects.",
            "Blessed is the mind too small for doubt.",
            "Fear denies faith.",
            "Faith is my shield.",
            "Hatred is my weapon.",
            "Success is commemorated; Failure merely remembered.",
            "Even a man who has nothing can still offer his life.",
            "Only in death does duty end.",
            "A mind without purpose will wander in dark places.",
            "Knowledge is power, guard it well."
        }
        
        local random_prayer = prayers[math.random(1, #prayers)]
        
        -- Display prayer dramatically
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        game.print("[color=yellow]+ IMPERIAL PRAYER +[/color]")
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        game.print("[color=red]" .. random_prayer .. "[/color]")
        game.print("[color=orange]++++++++++++++++++++++++++++++++++++++[/color]")
        
        -- Small morale boost for praying
        player.character_running_speed_modifier = player.character_running_speed_modifier + 0.1
        
        -- Reset after 60 seconds
        script.on_nth_tick(3600, function()
            if player and player.valid then
                player.character_running_speed_modifier = player.character_running_speed_modifier - 0.1
            end
            script.on_nth_tick(3600, nil) -- Clear callback
        end)
        
        return
    end
    
    -- Check for shop location request
    if message == "!shop" or message == "!market" then
        if global.imperial_shop and global.imperial_shop.valid then
            game.print("[color=yellow]IMPERIAL NOTICE: The Departmento Munitorum Exchange is located at position [gps=" .. 
                       math.floor(global.imperial_shop.position.x) .. "," .. 
                       math.floor(global.imperial_shop.position.y) .. "][/color]")
        else
            game.print("[color=red]ERROR: The Imperial Exchange could not be located. Please report this to the Adeptus Administratum.[/color]")
        end
        return
    end
end)

-- Log when script loads
log("Imperium Outpost scenario loaded with enhanced 40K atmosphere")