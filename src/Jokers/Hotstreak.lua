SMODS.Joker {
    key = 'Hotstreak',
    atlas = 'placeholders',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    cost = 8,
    config = { extra = { first_odds = 2, second_odds = 4, third_odds = 8, fourth_odds = 16, fifth_odds = 32, sixth_odds = 64, seventh_odds = 128 } },
    loc_vars = function(self, info_queue, card)
        local first_numerator, first_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.first_odds,
            'hotstreak_first_trigger')
        local second_numerator, second_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.second_odds,
            'hotstreak_second_trigger')
        local third_numerator, third_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.third_odds,
            'hotstreak_third_trigger')
        local fourth_numerator, fourth_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.fourth_odds,
            'hotstreak_fourth_trigger')
        local fifth_numerator, fifth_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.fifth_odds,
            'hotstreak_fifth_trigger')
        local sixth_numerator, sixth_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.sixth_odds,
            'hotstreak_sixth_trigger')
        local seventh_numerator, seventh_denominator = SMODS.get_probability_vars(card, 1,
            card.ability.extra.seventh_odds, 'hotstreak_seventh_trigger')
        return { vars = { first_numerator, first_denominator, second_numerator, second_denominator, third_numerator, third_denominator, fourth_numerator, fourth_denominator, fifth_numerator, fifth_denominator, sixth_numerator, sixth_denominator, seventh_numerator, seventh_denominator, card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_lucky') then
            local variables = { 'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh' }
            for i = #variables, 1, -1 do
                if SMODS.pseudorandom_probability(card, 'seed', 1, card.ability.extra[variables[i] .. '_odds']) then
                    return { repetitions = i }
                end
            end
        end
    end }
