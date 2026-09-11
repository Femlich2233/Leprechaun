SMODS.Joker {
    key= 'Overwhelming_Love',
    atlas= 'placeholders',
    pos= {
        x = 1,
        y = 0
    },
    rarity= 2,
    cost= 6,
    config= { extra = { repetitions = 1 } },
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end}