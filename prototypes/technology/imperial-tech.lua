
-- Imperial Technology Tree

-- Tier 1: STC Fragments
data:extend({
  {
    type = "technology",
    name = "stc-fragments",
    icon = "__warhammer-40k-imperium__/graphics/technology/stc-fragments.png",
    icon_size = 256,
    effects = {
      { type = "unlock-recipe", recipe = "mechanicus-data-key" },
      { type = "unlock-recipe", recipe = "autogun" },
      { type = "unlock-recipe", recipe = "basic-lasrifle" },
      { type = "unlock-recipe", recipe = "frag-grenade" },
      { type = "unlock-recipe", recipe = "imperial-requisition-t1" }
    },
    prerequisites = {"automation"},
    unit = {
      count = 50,
      ingredients = { { "automation-science-pack", 1 } },
      time = 30
    },
    order = "a-a-a"
  }
})

-- Tier 2: Adept Armaments
data:extend({
  {
    type = "technology",
    name = "adept-armaments",
    icon = "__warhammer-40k-imperium__/graphics/technology/adept-armaments.png",
    icon_size = 256,
    effects = {
      { type = "unlock-recipe", recipe = "heavy-stubber" },
      { type = "unlock-recipe", recipe = "improved-lasrifle" },
      { type = "unlock-recipe", recipe = "bolt-revolver" },
      { type = "unlock-recipe", recipe = "imperial-requisition-t2" }
    },
    prerequisites = {"stc-fragments", "steel-processing", "electronics"},
    unit = {
      count = 100,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 }
      },
      time = 30
    },
    order = "a-a-b"
  }
})

-- Tier 3: Tech-Priest Arsenal
data:extend({
  {
    type = "technology",
    name = "tech-priest-arsenal",
    icon = "__warhammer-40k-imperium__/graphics/technology/tech-priest-arsenal.png",
    icon_size = 256,
    effects = {
      { type = "unlock-recipe", recipe = "arc-rifle" },
      { type = "unlock-recipe", recipe = "volkite-serpenta" },
      { type = "unlock-recipe", recipe = "plasma-caliver" },
      { type = "unlock-recipe", recipe = "imperial-requisition-t3" }
    },
    prerequisites = {"adept-armaments", "battery"},
    unit = {
      count = 200,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 }
      },
      time = 45
    },
    order = "a-a-c"
  }
})

-- Tier 4: Forge World Relics
data:extend({
  {
    type = "technology",
    name = "forge-world-relics",
    icon = "__warhammer-40k-imperium__/graphics/technology/forge-world-relics.png",
    icon_size = 256,
    effects = {
      { type = "unlock-recipe", recipe = "radium-carbine" },
      { type = "unlock-recipe", recipe = "cognis-flamer" },
      { type = "unlock-recipe", recipe = "phosphor-blaster" },
      { type = "unlock-recipe", recipe = "imperial-requisition-t4" }
    },
    prerequisites = {"tech-priest-arsenal", "processing-unit", "uranium-processing", "flamethrower"},
    unit = {
      count = 400,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 }
      },
      time = 60
    },
    order = "a-a-d"
  }
})

-- Tier 5: Omnissian Sanctum
data:extend({
  {
    type = "technology",
    name = "omnissian-sanctum",
    icon = "__warhammer-40k-imperium__/graphics/technology/omnissian-sanctum.png",
    icon_size = 256,
    effects = {
      { type = "unlock-recipe", recipe = "conversion-beamer" },
      { type = "unlock-recipe", recipe = "master-crafted-volkite-culverin" },
      { type = "unlock-recipe", recipe = "grav-gun" },
      { type = "unlock-recipe", recipe = "imperial-requisition-t5" }
    },
    prerequisites = {"forge-world-relics", "low-density-structure", "electric-engine"},
    unit = {
      count = 1000,
      ingredients = {
        { "automation-science-pack", 2 },
        { "logistic-science-pack", 2 },
        { "chemical-science-pack", 2 },
        { "production-science-pack", 2 },
        { "utility-science-pack", 1 }
      },
      time = 90
    },
    order = "a-a-e"
  }
})
