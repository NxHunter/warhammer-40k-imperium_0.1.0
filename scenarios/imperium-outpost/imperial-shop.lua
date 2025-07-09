-- Imperial Shop implementation for Warhammer 40K: Imperium Outpost

-- Define shop trades based on tech level
local shop_trades = {
    -- Tier 0 (Available at start)
    tier0 = {
        {item = "rusted-stub-gun", price = 15},
        {item = "improvised-shovel", price = 10},
        {item = "iron-plate", price = 2, amount = 5},
        {item = "copper-plate", price = 2, amount = 5},
        {item = "steel-plate", price = 5, amount = 2},
        {item = "electronic-circuit", price = 4, amount = 2},
    },
    
    -- Tier 1 (STC Fragments)
    tier1 = {
        {item = "autogun", price = 50},
        {item = "basic-lasrifle", price = 75},
        {item = "frag-grenade", price = 30, amount = 2},
        {item = "mechanicus-data-key", price = 25},
    },
    
    -- Tier 2 (Adept Armaments)
    tier2 = {
        {item = "heavy-stubber", price = 150},
        {item = "improved-lasrifle", price = 200},
        {item = "bolt-revolver", price = 120},
    },
    
    -- Tier 3 (Tech-Priest Arsenal)
    tier3 = {
        {item = "arc-rifle", price = 300},
        {item = "volkite-serpenta", price = 350},
        {item = "plasma-caliver", price = 400},
    },
    
    -- Tier 4 (Forge World Relics)
    tier4 = {
        {item = "radium-carbine", price = 600},
        {item = "cognis-flamer", price = 550},
        {item = "phosphor-blaster", price = 650},
    },
    
    -- Tier 5 (Omnissian Sanctum)
    tier5 = {
        {item = "conversion-beamer", price = 1000},
        {item = "master-crafted-volkite-culverin", price = 1200},
        {item = "grav-gun", price = 1500},
    },
}

-- Imperial Shop entity
local SHOP_ENTITY = "market" -- Using Factorio's market entity

-- Function to create the Imperial shop
function create_imperial_shop(surface, position)
    -- Create concrete area around the shop
    for x = -3, 3 do
        for y = -3, 3 do
            local tile_pos = {position.x + x, position.y + y}
            surface.set_tiles({{name = "concrete", position = tile_pos}})
        end
    end
    
    -- Create shop entity
    local shop = surface.create_entity{
        name = SHOP_ENTITY, 
        position = position,
        force = "player"
    }
    
    -- Set shop name
    shop.backer_name = "Imperial Munitorum Exchange"
    
    -- Store the shop entity in global for later reference
    global.imperial_shop = shop
    
    -- Initially add only tier 0 trades
    update_shop_trades(shop, 0)
    
    return shop
end

-- Function to update shop trades based on tech level
function update_shop_trades(shop, tech_level)
    if not shop or not shop.valid then return end
    
    -- Clear existing offers
    local current_items = shop.get_market_items()
    if current_items then
        for i = #current_items, 1, -1 do
            shop.remove_market_item(i)
        end
    end
    
    -- Add BUY section header
    shop.add_market_item({
        price = {{count = 0, name = "coin"}},
        offer = {type = "nothing"},
        title = "=== BUY ITEMS ==="
    })
    
    -- Add appropriate trades based on tech level
    for tier = 0, tech_level do
        local tier_trades = shop_trades["tier" .. tier]
        if tier_trades then
            for _, trade in pairs(tier_trades) do
                -- Default amount to 1 if not specified
                local amount = trade.amount or 1
                
                -- Add with clear BUY indication
                shop.add_market_item({
                    price = {{count = trade.price, name = "coin"}},
                    offer = {type = "give-item", item = trade.item, count = amount},
                    title = "[BUY] " .. trade.item .. " (" .. amount .. ")",
                    description = "Price: " .. trade.price .. " coins"
                })
            end
        end
    end
    
    -- Add SELL section header
    shop.add_market_item({
        price = {{count = 0, name = "coin"}},
        offer = {type = "nothing"},
        title = "=== SELL ITEMS ==="
    })
    
    -- Add the ability to sell items for coins
    add_sell_options(shop)
end

-- Add options to sell weapons for coins
function add_sell_options(shop)
    -- Sell weapons for coins
    local sell_options = {
        {item = "rusted-stub-gun", price = 10},
        {item = "improvised-shovel", price = 8},
        {item = "autogun", price = 35},
        {item = "basic-lasrifle", price = 50},
        {item = "heavy-stubber", price = 100},
        {item = "improved-lasrifle", price = 150},
        {item = "arc-rifle", price = 250},
        {item = "volkite-serpenta", price = 300},
        {item = "plasma-caliver", price = 350},
        {item = "radium-carbine", price = 500},
        {item = "cognis-flamer", price = 450},
        {item = "phosphor-blaster", price = 550},
        {item = "conversion-beamer", price = 800},
        {item = "master-crafted-volkite-culverin", price = 1000},
        {item = "grav-gun", price = 1200},
    }
    
    for _, option in pairs(sell_options) do
        -- Add with clear SELL indication
        shop.add_market_item({
            price = {{count = 1, name = option.item}},
            offer = {type = "give-item", item = "coin", count = option.price},
            title = "[SELL] " .. option.item,
            description = "Receive: " .. option.price .. " coins"
        })
    end
    
    -- Special trades header
    shop.add_market_item({
        price = {{count = 0, name = "coin"}},
        offer = {type = "nothing"},
        title = "=== SPECIAL TRADES ==="
    })
    
    -- Special offer: Convert weapons to requisition tokens
    shop.add_market_item({
        price = {{count = 1, name = "autogun"}, {count = 1, name = "basic-lasrifle"}},
        offer = {type = "give-item", item = "imperial-requisition-token", count = 1},
        title = "[TRADE] Weapons for Token",
        description = "Trade 1 Autogun + 1 Basic Lasrifle for 1 Imperial Requisition Token"
    })
    
    -- Resource trades for coins
    -- Resource trades header
    shop.add_market_item({
        price = {{count = 0, name = "coin"}},
        offer = {type = "nothing"},
        title = "=== RESOURCE TRADES ==="
    })
    
    -- Resource trades for coins
    local resource_trades = {
        {item = "iron-plate", price = 1, amount = 10},
        {item = "copper-plate", price = 1, amount = 10},
        {item = "steel-plate", price = 5, amount = 5},
        {item = "electronic-circuit", price = 3, amount = 2},
        {item = "advanced-circuit", price = 10, amount = 1},
        {item = "processing-unit", price = 25, amount = 1},
    }
    
    for _, trade in pairs(resource_trades) do
        -- Sell resources for coins with clear indication
        shop.add_market_item({
            price = {{count = trade.amount, name = trade.item}},
            offer = {type = "give-item", item = "coin", count = trade.price},
            title = "[SELL] " .. trade.amount .. "x " .. trade.item,
            description = "Receive: " .. trade.price .. " coins"
        })
    end
    
    -- Special: Give player starting coins for selling their initial shovel
    shop.add_market_item({
        price = {{count = 1, name = "improvised-shovel"}},
        offer = {type = "give-item", item = "coin", count = 20},
        title = "[SPECIAL DEAL] Improvised Shovel",
        description = "Receive: 20 coins (Special bonus)"
    })
end  -- ADDED MISSING CLOSING BRACE HERE

-- Helper function to check tech level
function get_player_tech_level(force)
    if force.technologies["omnissian-sanctum"] and force.technologies["omnissian-sanctum"].researched then
        return 5
    elseif force.technologies["forge-world-relics"] and force.technologies["forge-world-relics"].researched then
        return 4
    elseif force.technologies["tech-priest-arsenal"] and force.technologies["tech-priest-arsenal"].researched then
        return 3
    elseif force.technologies["adept-armaments"] and force.technologies["adept-armaments"].researched then
        return 2
    elseif force.technologies["stc-fragments"] and force.technologies["stc-fragments"].researched then
        return 1
    else
        return 0
    end
end

-- Update shop when technology is researched
script.on_event(defines.events.on_research_finished, function(event)
    local tech = event.research
    local force = tech.force
    
    -- Get current tech level
    local tech_level = get_player_tech_level(force)
    
    -- Update shop with new trades
    if global.imperial_shop and global.imperial_shop.valid then
        update_shop_trades(global.imperial_shop, tech_level)
        
        -- Announce new items available
        if tech.name == "stc-fragments" or 
           tech.name == "adept-armaments" or 
           tech.name == "tech-priest-arsenal" or 
           tech.name == "forge-world-relics" or 
           tech.name == "omnissian-sanctum" then
            
            game.print("[color=green]--- NOTICE: New items available at the Imperial Munitorum Exchange[/color]")
        end
    end
end)

-- Give starting coins to players
function give_starting_coins(player)
    if player and player.valid then
        -- Give starting coins so the player can use the shop
        player.insert({name = "coin", count = 25})
        
        -- Inform the player
        game.print("[color=yellow]IMPERIAL NOTICE: You have been issued 25 Imperial Thrones from the Departmento Munitorum.[/color]")
    end
end

-- Return the shop implementation functions
return {
    create_imperial_shop = create_imperial_shop,
    update_shop_trades = update_shop_trades,
    get_player_tech_level = get_player_tech_level,
    give_starting_coins = give_starting_coins
}
