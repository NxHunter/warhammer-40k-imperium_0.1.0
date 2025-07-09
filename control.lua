-- Warhammer 40K: Imperium Arsenal Control Script
-- Handles runtime events and special mechanics
-- Add this to the beginning of scenarios/imperium-outpost/control.lua
-- after requiring imperial-shop but before other code

-- Ensure the shop module was loaded correctly
if not imperial_shop then
    error("Failed to load the Imperial Shop module. Check for syntax errors in imperial-shop.lua")
end

-- Ensure global tables are initialized
global = global or {}
global.scenario = global.scenario or {}
global.imperial_shop = global.imperial_shop or nil

-- Defensive function for creating the imperial shop
local function ensure_imperial_shop_exists(surface, position)
    if not global.imperial_shop or not global.imperial_shop.valid then
        local shop = imperial_shop.create_imperial_shop(surface, position)
        if not shop then
            log("ERROR: Failed to create Imperial Shop. Check for missing entities or resources.")
            return false
        end
        global.imperial_shop = shop
        return true
    end
    return true
end

-- Safer shop creation that won't crash if something goes wrong
local function create_shop_safely(surface, position)
    -- Check if surface is valid
    if not surface or not surface.valid then
        log("ERROR: Invalid surface when trying to create shop")
        return nil
    end
    
    -- Check if position is valid
    if not position or not position.x or not position.y then
        log("ERROR: Invalid position when trying to create shop")
        return nil
    end
    
    -- Ensure concrete is available before trying to place it
    if not game.tile_prototypes["concrete"] then
        log("WARNING: Concrete tile not available, using stone-path instead")
        for x = -3, 3 do
            for y = -3, 3 do
                local tile_pos = {position.x + x, position.y + y}
                surface.set_tiles({{name = "stone-path", position = tile_pos}})
            end
        end
    else
        for x = -3, 3 do
            for y = -3, 3 do
                local tile_pos = {position.x + x, position.y + y}
                surface.set_tiles({{name = "concrete", position = tile_pos}})
            end
        end
    end
    
    -- Check if market entity exists
    if not game.entity_prototypes["market"] then
        log("ERROR: Market entity not available")
        return nil
    }
    
    -- Create shop entity with error checking
    local shop = surface.create_entity{
        name = "market", 
        position = position,
        force = "player"
    }
    
    if not shop then
        log("ERROR: Failed to create market entity")
        return nil
    end
    
    -- Set shop name if possible
    if shop.valid then
        shop.backer_name = "Imperial Munitorum Exchange"
    end
    
    return shop
end

-- Add a dependency validation function to check early for issues
function validate_mod_dependencies()
    log("Checking mod dependencies...")
    
    -- Check that we have our base items
    local missing_items = {}
    local required_items = {
        "rusted-stub-gun",
        "improvised-shovel",
        "coin" -- Add this after implementing the coin item
    }
    
    for _, item_name in pairs(required_items) do
        if not game.item_prototypes[item_name] then
            table.insert(missing_items, item_name)
        end
    end
    
    if #missing_items > 0 then
        log("WARNING: Missing required items: " .. table.concat(missing_items, ", "))
    end
    
    -- Check for required technologies
    local missing_techs = {}
    local required_techs = {
        "stc-fragments",
        "adept-armaments",
        "tech-priest-arsenal",
        "forge-world-relics",
        "omnissian-sanctum"
    }
    
    for _, tech_name in pairs(required_techs) do
        if not game.technology_prototypes[tech_name] then
            table.insert(missing_techs, tech_name)
        end
    end
    
    if #missing_techs > 0 then
        log("WARNING: Missing required technologies: " .. table.concat(missing_techs, ", "))
    end
    
    -- Report validation results
    if #missing_items == 0 and #missing_techs == 0 then
        log("All dependencies validated successfully")
        return true
    else
        log("Dependency validation failed - mod may not function correctly")
        return false
    end
end

-- Call validation on init
script.on_init(function()
    validate_mod_dependencies()
    
    -- Continue with regular initialization...
    -- (your existing initialization code would follow here)
end)
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

-- Handle requisition token creation with flavor text and track total requisition tokens produced
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
    
    -- Track requisition token production
    if item_name == "imperial-requisition-token" then
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
