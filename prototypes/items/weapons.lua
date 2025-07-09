-- Imperial Weapons Items

-- Tier 0: Ancient Salvage
data:extend({
  {
    type = "item",
    name = "rusted-stub-gun",
    icon = "__warhammer-40k-imperium__/graphics/icons/rusted-stub-gun.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t0",
    order = "a[ancient-salvage]-a[rusted-stub-gun]",
    stack_size = 50,
    default_request_amount = 10
  },
  {
    type = "item", 
    name = "improvised-shovel",
    icon = "__warhammer-40k-imperium__/graphics/icons/improvised-shovel.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t0",
    order = "a[ancient-salvage]-b[improvised-shovel]",
    stack_size = 50,
    default_request_amount = 10
  }
})

-- Tier 1: STC Fragments
data:extend({
  {
    type = "item",
    name = "autogun",
    icon = "__warhammer-40k-imperium__/graphics/icons/autogun.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t1",
    order = "b[stc-fragments]-a[autogun]",
    stack_size = 50,
    default_request_amount = 10
  },
  {
    type = "item",
    name = "basic-lasrifle",
    icon = "__warhammer-40k-imperium__/graphics/icons/basic-lasrifle.png", 
    icon_size = 64,
    subgroup = "imperial-weapons-t1",
    order = "b[stc-fragments]-b[basic-lasrifle]",
    stack_size = 50,
    default_request_amount = 10
  },
  {
    type = "item",
    name = "frag-grenade",
    icon = "__warhammer-40k-imperium__/graphics/icons/frag-grenade.png",
    icon_size = 64, 
    subgroup = "imperial-weapons-t1",
    order = "b[stc-fragments]-c[frag-grenade]",
    stack_size = 100,
    default_request_amount = 20
  }
})

-- Tier 2: Adept Armaments
data:extend({
  {
    type = "item",
    name = "heavy-stubber",
    icon = "__warhammer-40k-imperium__/graphics/icons/heavy-stubber.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t2", 
    order = "c[adept-armaments]-a[heavy-stubber]",
    stack_size = 25,
    default_request_amount = 5
  },
  {
    type = "item",
    name = "improved-lasrifle",
    icon = "__warhammer-40k-imperium__/graphics/icons/improved-lasrifle.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t2",
    order = "c[adept-armaments]-b[improved-lasrifle]", 
    stack_size = 25,
    default_request_amount = 5
  },
  {
    type = "item",
    name = "bolt-revolver",
    icon = "__warhammer-40k-imperium__/graphics/icons/bolt-revolver.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t2",
    order = "c[adept-armaments]-c[bolt-revolver]",
    stack_size = 25,
    default_request_amount = 5
  }
})

-- Tier 3: Tech-Priest Arsenal
data:extend({
  {
    type = "item",
    name = "arc-rifle",
    icon = "__warhammer-40k-imperium__/graphics/icons/arc-rifle.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t3",
    order = "d[tech-priest-arsenal]-a[arc-rifle]",
    stack_size = 10,
    default_request_amount = 2
  },
  {
    type = "item", 
    name = "volkite-serpenta",
    icon = "__warhammer-40k-imperium__/graphics/icons/volkite-serpenta.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t3",
    order = "d[tech-priest-arsenal]-b[volkite-serpenta]",
    stack_size = 10,
    default_request_amount = 2
  },
  {
    type = "item",
    name = "plasma-caliver",
    icon = "__warhammer-40k-imperium__/graphics/icons/plasma-caliver.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t3", 
    order = "d[tech-priest-arsenal]-c[plasma-caliver]",
    stack_size = 10,
    default_request_amount = 2
  }
})

-- Tier 4: Forge World Relics
data:extend({
  {
    type = "item",
    name = "radium-carbine",
    icon = "__warhammer-40k-imperium__/graphics/icons/radium-carbine.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t4",
    order = "e[forge-world-relics]-a[radium-carbine]",
    stack_size = 5,
    default_request_amount = 1
  },
  {
    type = "item",
    name = "cognis-flamer",
    icon = "__warhammer-40k-imperium__/graphics/icons/cognis-flamer.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t4",
    order = "e[forge-world-relics]-b[cognis-flamer]",
    stack_size = 5,
    default_request_amount = 1
  },
  {
    type = "item",
    name = "phosphor-blaster", 
    icon = "__warhammer-40k-imperium__/graphics/icons/phosphor-blaster.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t4",
    order = "e[forge-world-relics]-c[phosphor-blaster]",
    stack_size = 5,
    default_request_amount = 1
  }
})

-- Tier 5: Omnissian Sanctum
data:extend({
  {
    type = "item",
    name = "conversion-beamer",
    icon = "__warhammer-40k-imperium__/graphics/icons/conversion-beamer.png", 
    icon_size = 64,
    subgroup = "imperial-weapons-t5",
    order = "f[omnissian-sanctum]-a[conversion-beamer]",
    stack_size = 1,
    default_request_amount = 1
  },
  {
    type = "item",
    name = "master-crafted-volkite-culverin",
    icon = "__warhammer-40k-imperium__/graphics/icons/master-crafted-volkite-culverin.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t5",
    order = "f[omnissian-sanctum]-b[master-crafted-volkite-culverin]",
    stack_size = 1,
    default_request_amount = 1
  },
  {
    type = "item",
    name = "grav-gun",
    icon = "__warhammer-40k-imperium__/graphics/icons/grav-gun.png",
    icon_size = 64,
    subgroup = "imperial-weapons-t5",
    order = "f[omnissian-sanctum]-c[grav-gun]",
    stack_size = 1, 
    default_request_amount = 1
  }
})