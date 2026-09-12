SMODS.Joker {
    key = 'Sealed_Explorer',
    atlas = 'placeholders',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    cost = 10,
    config = { extra = { odds = 4, repetitions = 1 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_leper_Sealed_Explorer_negative')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.hand and context.other_card:get_seal() == 'Blue' and (next(context.card_effects[1]) or #context.card_effects > 1) then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}
