-- Warhammer 40K: Imperium Outpost Scenario
-- Enhanced data script for atmosphere

-- Set darker atmosphere for new games
local default_map_gen_settings = {
    -- More pollution to create grimmer atmosphere
    pollution = {
        enabled = true,
        diffusion_ratio = 0.1,
        ageing = 0.5,
        -- Redder pollution to match the grim dark future
        enemy_attack_pollution_consumption_modifier = 1.5,
        min_pollution_to_damage_trees = 60,
        pollution_restored_per_tree_damage = 10
    },
    
    -- Enemy settings
    enemy_evolution = {
        enabled = true,
        -- Faster evolution to represent increasing xenos threat
        time_factor = 0.000007,
        destroy_factor = 0.002,
        pollution_factor = 0.000015
    },
    
    -- Enemy expansion to simulate xenos encroachment
    enemy_expansion = {
        enabled = true,
        max_expansion_distance = 7,
        settler_group_min_size = 5,
        settler_group_max_size = 15,
        min_expansion_cooldown = 4 * 3600,
        max_expansion_cooldown = 8 * 3600
    },
    
    -- Map generation
    autoplace_controls = {
        -- More trees to create dense environments for xenos to hide
        ["trees"] = {
            frequency = 1.5,
            size = 1.5
        },
        -- More water to create natural barriers
        ["water"] = {
            frequency = 1.1,
            size = 1.1
        }
    },
    
    -- Terrain segmentation and water settings
    terrain_segmentation = 1.0, -- Lower value = larger biomes
    water = 1.2, -- Slightly more water
    
    -- Starting area
    starting_area = 1.5, -- Larger starting area free of enemies
    
    -- Create more cliffs for defensive positions
    cliff_settings = {
        cliff_elevation_0 = 10,
        cliff_elevation_interval = 10,
        name = "cliff"
    }
}

-- Export map settings for scenario
return {
    map_gen_settings = default_map_gen_settings,
    
    -- Additional game settings
    default_game_settings = {
        -- Increase darkness for grimdark atmosphere
        darkness = {
            enabled = true,
            minimum_darkness = 0.5
        }
    }
}
