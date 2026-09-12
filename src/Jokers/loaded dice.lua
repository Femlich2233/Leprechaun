SMODS.Joker {
    key = 'Loaded_Dice',
    atlas = 'placeholders',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    cost = 10,
    config = { extra = { odds = 360 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'leper_loaded_dice')
        return { vars = { card.ability.extra.mult, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator * 10
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'leper_loaded_dice', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                G.GAME.pool_flags.leper_loaded_dice_extinct = true
                return {
                    message = localize('k_Snake Eyes!_ex')
                }
            else
                return {
                    message = localize('k_safe_ex') }
            end
        end
    end,
    no_pool_flag = 'leper_loaded_dice_extinct'
}
