SMODS.Joker {
    key = 'Sealed_Conqueror',
    atlas = 'placeholders',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    cost = 10,
    config = { extra = { odds = 4, repetitions = 2 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1,
            card.ability.extra.odds, 'conqueror_retriggers')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card:get_seal() == 'Red' then
            if SMODS.pseudorandom_probability(card, 'conqueror_retriggers', 1, card.ability.extra.odds) then
                return { repetitions = 2 }
            else
                return { repetitions = 1 }
            end
        end
    end }
