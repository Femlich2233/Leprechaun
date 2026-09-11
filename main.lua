--#region Atlases

SMODS.Atlas {
    key= 'placeholders',
    path= 'placeholders.png',
    px= 71,
    py= 95
}

--#endregion

--#region File Loading

local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()

end

SMODS.Enhancement:take_ownership('m_lucky', {
    calculate = function(self, context, card)
        if context.mod_probability and context.trigger_obj == card and card.ability.modprefix_probability_add and card.ability.modprefix_probability_add > 0 then
            return {numerator = context.numerator + card.ability.modprefix_probability_add}
        end
    end,
})

--#endregion