-- Warhammer 40K: Imperium Arsenal
-- data-final-fixes.lua - Runs after all other mods have loaded

-- DISABLE VANILLA TECHNOLOGIES
-- This section hides all vanilla technologies while keeping our mod's tech tree visible

-- List of technologies from our mod that should remain visible
local imperium_techs = {
  "stc-fragments",
  "adept-armaments",
  "tech-priest-arsenal",
  "forge-world-relics",
  "omnissian-sanctum"
}

-- Create a set for faster lookup
local imperium_techs_set = {}
for _, tech_name in pairs(imperium_techs) do
  imperium_techs_set[tech_name] = true
end

-- Hide all vanilla technologies
for tech_name, tech in pairs(data.raw["technology"]) do
  -- Check if this is one of our technologies
  if imperium_techs_set[tech_name] then
    -- Keep our mod's technologies visible
  else
    -- Hide vanilla techs (but don't disable them yet)
    tech.hidden = true
  end
end

-- Print debug message to confirm this file is running
log("Warhammer 40K: Imperium Arsenal - Vanilla technologies hidden")
