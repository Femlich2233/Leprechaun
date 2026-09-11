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
        loc_vars = function(self, info_queue, card)
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'merchant_money')
            return { vars = { numerator, denominator, card.ability.extra.first_dollars, card.ability.extra.second_dollars } }
        end
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.seal == 'gold' then
            if context.pseudorandom_probability then
                return {
                    card.ability.extra.second_dollars
                }
            else
                return {
                    card.ability.extra.first_dollars
                }
            end
        end
    end }
