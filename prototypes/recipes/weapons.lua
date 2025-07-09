-- Imperial Weapons Recipes

-- Tier 0: Ancient Salvage (starting equipment)
data:extend({
  {
    type = "recipe",
    name = "rusted-stub-gun",
    enabled = true,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "iron-plate", amount = 5},
      {type = "item", name = "iron-gear-wheel", amount = 2}
    },
    results = {{type = "item", name = "rusted-stub-gun", amount = 1}}
  },
  {
    type = "recipe", 
    name = "improvised-shovel",
    enabled = true,
    energy_required = 3,
    ingredients = {
      {type = "item", name = "iron-plate", amount = 3},
      {type = "item", name = "wood", amount = 2}
    },
    results = {{type = "item", name = "improvised-shovel", amount = 1}}
  }
})

-- Special Component: Mechanicus Data Key
data:extend({
  {
    type = "recipe",
    name = "mechanicus-data-key",
    enabled = false,
    energy_required = 10,
    category = "advanced-crafting",
    ingredients = {
      {type = "item", name = "electronic-circuit", amount = 2},
      {type = "item", name = "iron-plate", amount = 1},
      {type = "item", name = "copper-cable", amount = 5}
    },
    results = {{type = "item", name = "mechanicus-data-key", amount = 1}}
  }
})

-- Tier 1: STC Fragments
data:extend({
  {
    type = "recipe",
    name = "autogun", 
    enabled = false,
    energy_required = 8,
    ingredients = {
      {type = "item", name = "iron-gear-wheel", amount = 3},
      {type = "item", name = "iron-plate", amount = 8},
      {type = "item", name = "mechanicus-data-key", amount = 1}
    },
    results = {{type = "item", name = "autogun", amount = 1}}
  },
  {
    type = "recipe",
    name = "basic-lasrifle",
    enabled = false,
    energy_required = 10,
    ingredients = {
      {type = "item", name = "iron-plate", amount = 6},
      {type = "item", name = "copper-cable", amount = 10},
      {type = "item", name = "electronic-circuit", amount = 2},
      {type = "item", name = "mechanicus-data-key", amount = 1}
    },
    results = {{type = "item", name = "basic-lasrifle", amount = 1}}
  },
  {
    type = "recipe",
    name = "frag-grenade",
    enabled = false,
    energy_required = 6,
    ingredients = {
      {type = "item", name = "iron-plate", amount = 2},
      {type = "item", name = "explosives", amount = 3},
      {type = "item", name = "mechanicus-data-key", amount = 1}
    },
    results = {{type = "item", name = "frag-grenade", amount = 3}}
  }
})

-- Tier 2: Adept Armaments
data:extend({
  {
    type = "recipe",
    name = "heavy-stubber",
    enabled = false,
    energy_required = 15,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 12},
      {type = "item", name = "iron-gear-wheel", amount = 8},
      {type = "item", name = "advanced-circuit", amount = 2}
    },
    results = {{type = "item", name = "heavy-stubber", amount = 1}}
  },
  {
    type = "recipe",
    name = "improved-lasrifle",
    enabled = false,
    energy_required = 12,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 8},
      {type = "item", name = "advanced-circuit", amount = 3},
      {type = "item", name = "battery", amount = 5}
    },
    results = {{type = "item", name = "improved-lasrifle", amount = 1}}
  },
  {
    type = "recipe",
    name = "bolt-revolver",
    enabled = false,
    energy_required = 18,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 10},
      {type = "item", name = "iron-gear-wheel", amount = 6},
      {type = "item", name = "explosives", amount = 5},
      {type = "item", name = "advanced-circuit", amount = 1}
    },
    results = {{type = "item", name = "bolt-revolver", amount = 1}}
  }
})

-- Tier 3: Tech-Priest Arsenal
data:extend({
  {
    type = "recipe",
    name = "arc-rifle",
    enabled = false,
    energy_required = 20,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 15},
      {type = "item", name = "advanced-circuit", amount = 5},
      {type = "item", name = "battery", amount = 10},
      {type = "item", name = "copper-cable", amount = 20}
    },
    results = {{type = "item", name = "arc-rifle", amount = 1}}
  },
  {
    type = "recipe",
    name = "volkite-serpenta", 
    enabled = false,
    energy_required = 25,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 12},
      {type = "item", name = "processing-unit", amount = 3},
      {type = "item", name = "battery", amount = 8},
      {type = "item", name = "copper-cable", amount = 15}
    },
    results = {{type = "item", name = "volkite-serpenta", amount = 1}}
  },
  {
    type = "recipe",
    name = "plasma-caliver",
    enabled = false,
    energy_required = 30,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 18},
      {type = "item", name = "processing-unit", amount = 5},
      {type = "item", name = "battery", amount = 15},
      {type = "item", name = "advanced-circuit", amount = 8}
    },
    results = {{type = "item", name = "plasma-caliver", amount = 1}}
  }
})

-- Tier 4: Forge World Relics
data:extend({
  {
    type = "recipe",
    name = "radium-carbine",
    enabled = false,
    energy_required = 35,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 20},
      {type = "item", name = "processing-unit", amount = 8},
      {type = "item", name = "uranium-238", amount = 5},
      {type = "item", name = "engine-unit", amount = 2}
    },
    results = {{type = "item", name = "radium-carbine", amount = 1}}
  },
  {
    type = "recipe",
    name = "cognis-flamer",
    enabled = false,
    energy_required = 30,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 15},
      {type = "item", name = "advanced-circuit", amount = 10},
      {type = "item", name = "flamethrower-ammo", amount = 10},
      {type = "item", name = "sulfur", amount = 20}
    },
    results = {{type = "item", name = "cognis-flamer", amount = 1}}
  },
  {
    type = "recipe",
    name = "phosphor-blaster",
    enabled = false,
    energy_required = 40,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 25},
      {type = "item", name = "processing-unit", amount = 10},
      {type = "item", name = "sulfur", amount = 30},
      {type = "item", name = "engine-unit", amount = 3}
    },
    results = {{type = "item", name = "phosphor-blaster", amount = 1}}
  }
})

-- Tier 5: Omnissian Sanctum
data:extend({
  {
    type = "recipe",
    name = "conversion-beamer",
    enabled = false,
    energy_required = 60,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 40},
      {type = "item", name = "processing-unit", amount = 20},
      {type = "item", name = "low-density-structure", amount = 10},
      {type = "item", name = "electric-engine-unit", amount = 5}
    },
    results = {{type = "item", name = "conversion-beamer", amount = 1}}
  },
  {
    type = "recipe",
    name = "master-crafted-volkite-culverin",
    enabled = false,
    energy_required = 80,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 50},
      {type = "item", name = "processing-unit", amount = 25},
      {type = "item", name = "low-density-structure", amount = 8},
      {type = "item", name = "electric-engine-unit", amount = 3},
      {type = "item", name = "battery", amount = 20}
    },
    results = {{type = "item", name = "master-crafted-volkite-culverin", amount = 1}}
  },
  {
    type = "recipe",
    name = "grav-gun",
    enabled = false,
    energy_required = 70,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 35},
      {type = "item", name = "processing-unit", amount = 15},
      {type = "item", name = "low-density-structure", amount = 12},
      {type = "item", name = "electric-engine-unit", amount = 4},
      {type = "item", name = "battery", amount = 25}
    },
    results = {{type = "item", name = "grav-gun", amount = 1}}
  }
})

-- Imperial Requisition System - Convert weapons to requisition tokens
data:extend({
  {
    type = "recipe",
    name = "imperial-requisition-t0",
    enabled = true,
    energy_required = 2,
    category = "crafting",
    ingredients = {
      {type = "item", name = "rusted-stub-gun", amount = 5},
      {type = "item", name = "improvised-shovel", amount = 5}
    },
    results = {{type = "item", name = "imperial-requisition-token", amount = 1}}
  },
  {
    type = "recipe",
    name = "imperial-requisition-t1", 
    enabled = false,
    energy_required = 3,
    category = "crafting",
    ingredients = {
      {type = "item", name = "autogun", amount = 2},
      {type = "item", name = "basic-lasrifle", amount = 2},
      {type = "item", name = "frag-grenade", amount = 10}
    },
    results = {{type = "item", name = "imperial-requisition-token", amount = 5}}
  },
  {
    type = "recipe",
    name = "imperial-requisition-t2",
    enabled = false,
    energy_required = 5,
    category = "crafting",
    ingredients = {
      {type = "item", name = "heavy-stubber", amount = 1},
      {type = "item", name = "improved-lasrifle", amount = 2},
      {type = "item", name = "bolt-revolver", amount = 1}
    },
    results = {{type = "item", name = "imperial-requisition-token", amount = 15}}
  },
  {
    type = "recipe",
    name = "imperial-requisition-t3",
    enabled = false,
    energy_required = 8,
    category = "crafting",
    ingredients = {
      {type = "item", name = "arc-rifle", amount = 1},
      {type = "item", name = "volkite-serpenta", amount = 1},
      {type = "item", name = "plasma-caliver", amount = 1}
    },
    results = {{type = "item", name = "imperial-requisition-token", amount = 50}}
  },
  {
    type = "recipe",
    name = "imperial-requisition-t4",
    enabled = false,
    energy_required = 12,
    category = "crafting",
    ingredients = {
      {type = "item", name = "radium-carbine", amount = 1},
      {type = "item", name = "cognis-flamer", amount = 1},
      {type = "item", name = "phosphor-blaster", amount = 1}
    },
    results = {{type = "item", name = "imperial-requisition-token", amount = 150}}
  },
  {
    type = "recipe",
    name = "imperial-requisition-t5",
    enabled = false,
    energy_required = 20,
    category = "crafting",
    ingredients = {
      {type = "item", name = "conversion-beamer", amount = 1},
      {type = "item", name = "master-crafted-volkite-culverin", amount = 1},
      {type = "item", name = "grav-gun", amount = 1}
    },
    results = {{type = "item", name = "imperial-requisition-token", amount = 500}}
  }
})