SMODS.Joker {
    key = 'Leprechaun',
    atlas = 'placeholders',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    cost = 6,
    config = { extra = { probability = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.pseudorandom_result and Card.is(context.trigger_obj, Card) then
            if context.identifier == 'lucky_mult' then
                context.trigger_obj.modprefix_lucky_mult_trigger = context.result
            end
            if context.identifier == 'lucky_money' and context.trigger_obj.modprefix_lucky_mult_trigger and context.result then
                context.trigger_obj.modprefix_lucky_mult_trigger = false
                context.trigger_obj.ability.modprefix_probability_add = (context.trigger_obj.ability.modprefix_probability_add or 0) +
                1
            end
        end
    end }
