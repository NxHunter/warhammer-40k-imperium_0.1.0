-- Imperial Components and Special Items

data:extend({
  {
    type = "item",
    name = "mechanicus-data-key",
    icon = "__warhammer-40k-imperium__/graphics/icons/mechanicus-data-key.png",
    icon_size = 64,
    subgroup = "imperial-components",
    order = "a[components]-a[mechanicus-data-key]",
    stack_size = 100,
    default_request_amount = 10
  },
  {
    type = "item",
    name = "imperial-requisition-token",
    icon = "__warhammer-40k-imperium__/graphics/icons/imperial-requisition-token.png", 
    icon_size = 64,
    subgroup = "imperial-components",
    order = "z[output]-a[imperial-requisition-token]",
    stack_size = 1000,
    default_request_amount = 100
  }
})

-- Create item subgroups for organizing items in the crafting menu
data:extend({
  {
    type = "item-subgroup",
    name = "imperial-weapons-t0",
    group = "combat",
    order = "a[imperial-weapons]-a[tier-0]"
  },
  {
    type = "item-subgroup", 
    name = "imperial-weapons-t1",
    group = "combat",
    order = "a[imperial-weapons]-b[tier-1]"
  },
  {
    type = "item-subgroup",
    name = "imperial-weapons-t2", 
    group = "combat",
    order = "a[imperial-weapons]-c[tier-2]"
  },
  {
    type = "item-subgroup",
    name = "imperial-weapons-t3",
    group = "combat",
    order = "a[imperial-weapons]-d[tier-3]"
  },
  {
    type = "item-subgroup",
    name = "imperial-weapons-t4",
    group = "combat", 
    order = "a[imperial-weapons]-e[tier-4]"
  },
  {
    type = "item-subgroup",
    name = "imperial-weapons-t5",
    group = "combat",
    order = "a[imperial-weapons]-f[tier-5]"
  },
  {
    type = "item-subgroup",
    name = "imperial-components",
    group = "intermediate-products",
    order = "z[imperial-components]"
  }
})