-- Warhammer 40K: Imperium Arsenal
-- data-updates.lua - Runs after all data.lua files are loaded but before data-final-fixes.lua

-- This is a good place to add any modifications to existing data
-- Here we prepare our mod to work alongside vanilla content but with our tech tree focus

log("Warhammer 40K: Imperium Arsenal - Updates loaded")

-- Ensure our technologies don't require vanilla technologies if we want a standalone experience
-- For now, we'll keep these prerequisites to maintain compatibility
-- We can remove these later when we implement full tech tree replacement

-- Example of how we could adjust prerequisites:
--[[
if data.raw.technology["stc-fragments"] then
  data.raw.technology["stc-fragments"].prerequisites = {}
end

if data.raw.technology["adept-armaments"] then
  -- Keep our mod tech as prerequisite but remove vanilla dependencies
  data.raw.technology["adept-armaments"].prerequisites = {"stc-fragments"}
end
--]]
