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
            'Sealed_Explorer_negative')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.hand and context.other_card.seal == 'Blue' and (next(context.card_effects[1]) or #context.card_effects > 1) then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    }

local get_end_of_round_effect = Card.get_end_of_round_effect
function Card.get_end_of_round_effect(context, ...)
    if next(SMODS.find_card("Sealed_Explorer")) then
        if context.debuff then return {} end
        local ret = {}
        if context.ability.h_dollars > 0 then
            ret.h_dollars = context.ability.h_dollars
            ret.card = context
        end
        if context.seal == "Blue" then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    if G.GAME.last_hand_played then
                        local _planet = nil
                        for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                            if planet_center.config.hand_type == G.GAME.last_hand_played then
                                _planet = planet_center.key
                            end
                        end
                        if _planet then
                            if #G.consumeables.cards + 1 > G.consumeables.config.card_limit then
                                if SMODS.pseudorandom_probability(card, 1, card.ability.extra.odds, 'Sealed_Explorer_retriggers')
                                then SMODS.add_card({ key = _planet, edition = "e_negative" })
                            else
                                SMODS.add_card({ key = _planet })
                            end
                        end
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end
            }))
            return { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }
        end,
        return ret
    else
        return get_end_of_round_effect(context, ...)
    end
end end end

