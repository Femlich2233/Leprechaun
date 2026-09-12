SMODS.Joker {
    key = 'Sealed_Merchant',
    atlas = 'placeholders',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    cost = 10,
    config = { extra = { first_dollars = 3, second_dollars = 27, odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'leper_merchant_money')
        return { vars = { numerator, denominator, card.ability.extra.first_dollars, card.ability.extra.second_dollars } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_seal() == 'Gold' then
            if SMODS.pseudorandom_probability(card, 'leper_merchant_money', 1, card.ability.extra.odds) then
                return {
                    dollars = card.ability.extra.second_dollars
                }
            else
                return {
                    dollars = card.ability.extra.first_dollars
                }
            end
        end
    end }
