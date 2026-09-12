SMODS.Joker {
    key = 'Jillpot',
    atlas = 'placeholders',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    cost = 6,
    config = { extra = { odds = 7, repetitions = 7, type = 'Three of a Kind' } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1,
            card.ability.extra.odds, 'leper_Jillpot_retriggers')
        return { vars = { numerator, denominator, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.scoring_name == card.ability.extra.type and next(context.poker_hands[card.ability.extra.type]) then
            local passed = false
            for k, v in pairs(context.poker_hands[card.ability.extra.type]) do
                for kk, vv in pairs(v) do
                    if vv:get_id() == 7 and vv == context.other_card then
                        passed = true
                    end
                end
            end
            if passed and SMODS.pseudorandom_probability(card, 'leper_Jillpot_retriggers', 1, card.ability.extra.odds) then
                return { repetitions = card.ability.extra.repetitions }
            end
        end
    end
}
