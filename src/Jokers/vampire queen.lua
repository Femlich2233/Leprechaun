SMODS.Joker {
    key = 'Vampire_Queen',
    atlas = 'placeholders',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    cost = 8,
    config = { extra = { Xmult_gain = 0.1, Xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local sealed = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card.seal and not scored_card.debuff and not scored_card.vampire_queened then
                    sealed[#sealed + 1] = scored_card
                    scored_card.vampire_queened = true
                    scored_card:set_seal()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            scored_card.vampire_queened = nil
                            return true
                        end
                    }))
                end
            end
            if #sealed > 0 then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain * #sealed
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                    colour = G.C.MULT
                }
            end
        end
        if context.individual and context.cardarea == G.play then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end }
