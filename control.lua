-- Warhammer 40K: Imperium Arsenal Control Script
-- Handles runtime events and special mechanics

-- Initialize mod when player joins
script.on_event(defines.events.on_player_created, function(event)
    local player = game.get_player(event.player_index)
    if player then
        -- Give starting equipment
        player.insert({name = "rusted-stub-gun", count = 1})
        player.insert({name = "improvised-shovel", count = 1})
        
        -- Welcome message
        player.print("Welcome, servant of the Emperor! You have been equipped with basic salvage.")
        player.print("Seek out STC fragments to unlock the sacred knowledge of Imperial weaponry.")
        player.print("For the Emperor! Death to the heretics!")
    end
end)

-- Handle requisition token creation with flavor text
script.on_event(defines.events.on_player_crafted_item, function(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    
    local item_name = event.item_stack.name
    
    -- Add flavor messages for requisition crafting
    if string.find(item_name, "imperial-requisition") then
        local messages = {
            "Your contribution to the war effort has been noted by the Administratum.",
            "The Commissariat acknowledges your service to the Emperor.",
            "Your weapons shipment strengthens the Imperial Guard.",
            "The Departmento Munitorum records your loyalty.",
            "Another step towards purging the galaxy of xenos filth."
        }
        
        local random_message = messages[math.random(1, #messages)]
        player.print(random_message, {color = {r = 0.8, g = 0.8, b = 0.0}})
    end
    
    -- Special messages for high-tier weapons
    if item_name == "conversion-beamer" or 
       item_name == "master-crafted-volkite-culverin" or 
       item_name == "grav-gun" then
        player.print("You have crafted a relic of the Dark Age of Technology. The Omnissiah is pleased.", 
                    {color = {r = 1.0, g = 0.0, b = 0.0}})
    end
end)

-- Track total requisition tokens produced (for potential achievements)
script.on_event(defines.events.on_player_crafted_item, function(event)
    local player = game.get_player(event.player_index)
    if not player then return end
    
    if event.item_stack.name == "imperial-requisition-token" then
        if not global.requisition_totals then
            global.requisition_totals = {}
        end
        
        local player_name = player.name
        if not global.requisition_totals[player_name] then
            global.requisition_totals[player_name] = 0
        end
        
        global.requisition_totals[player_name] = global.requisition_totals[player_name] + event.item_stack.count
        
        -- Milestone messages
        local total = global.requisition_totals[player_name]
        if total == 100 then
            player.print("You have earned 100 Requisition Tokens! The Emperor recognizes your dedication.", 
                        {color = {r = 1.0, g = 0.8, b = 0.0}})
        elseif total == 1000 then
            player.print("1000 Requisition Tokens! You are a true servant of the Imperium!", 
                        {color = {r = 1.0, g = 0.8, b = 0.0}})
        elseif total == 10000 then
            player.print("10,000 Requisition Tokens! The Administratum grants you the title of 'Loyal Servant'!", 
                        {color = {r = 1.0, g = 0.8, b = 0.0}})
        end
    end
end)

-- Console command to check requisition status
-- COMMENTED OUT to avoid conflicts with scenario
-- commands.add_command("imperial-status", "Check your Imperial service record", function(command)
--     local player = game.get_player(command.player_index)
--     if not player then return end
--     
--     local player_name = player.name
--     local total = 0
--     
--     if global.requisition_totals and global.requisition_totals[player_name] then
--         total = global.requisition_totals[player_name]
--     end
--     
--     player.print("=== IMPERIAL SERVICE RECORD ===", {color = {r = 1.0, g = 0.8, b = 0.0}})
--     player.print("Servant: " .. player_name)
--     player.print("Total Requisition Tokens Produced: " .. total)
--     player.print("Status: " .. (total >= 10000 and "Loyal Servant" or 
--                                 total >= 1000 and "Dedicated Servant" or 
--                                 total >= 100 and "Acknowledged Servant" or 
--                                 "Initiate"))
--     player.print("The Emperor Protects!")
-- end)