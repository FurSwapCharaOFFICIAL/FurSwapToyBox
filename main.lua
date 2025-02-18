--- STEAMODDED HEADER
--- MOD_NAME: FurSwap's Toy Box
--- MOD_ID: FURSWAP
--- MOD_AUTHOR: [FurSwap!Chara, TheChaoticShapeshift]
--- MOD_DESCRIPTION: A collection of my friends and OCs as Jokers and such, along with several other ideas I have in my head! Joker backgrounds by me, most face art by TheChaoticShapeshift, effect ideas by my friends!
--- BADGE_COLOUR: FF7F27
--- PREFIX: furswap
--- VERSION: 1.0.0
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-1304a, Cryptid>=0.5]
----------------
--CODING BEGIN--
----------------

--JOKER ATLASES
SMODS.Atlas {
	key = 'furswaplumi',
	px = 71,
	py = 95,
	path = 'j_furswap_lumi.png'
}
---Jokers
SMODS.Joker {
    key = 'furswaplumi',
    loc_txt = {
        name = 'Luminescent',
        text = {'{C:money}Retrigger{} all jokers to the left of this one {C:money}#2# time(s){}.',
			'All jokers to the right of this one give {X:mult,C:white}X#1#{} Mult',
			'{C:inactive,s:0.7,E:2}Face art by : FurSwap!Chara',
			'{C:inactive,s:0.7,E:2}Character by : Luminescent123',
			'{C:important,s:0.7,E:2}Origin : Rain World'
			},
    },	
	atlas = 'furswaplumi',
    pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0},
	config = {
		extra = {
		Xmult = 3,
		retriggers = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return {vars ={
		center.ability.extra.Xmult,
		center.ability.extra.retriggers}
		}
	end,
	cost = 20,
	rarity = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    calculate = function(self, card, context)
        --Retriggering
        if context.retrigger_joker_check and not context.retrigger_joker then
            --card = This Joker, context.other_card = card it's checking to retrigger
            if card.T.x + card.T.w / 2 > context.other_card.T.x + context.other_card.T.w / 2 then
                return {
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra.retriggers,
                    card = card,
                }
            end
        --Xmult
        elseif context.other_joker and card ~= context.other_joker then
            if card.T.x + card.T.w / 2 < context.other_joker.T.x + context.other_joker.T.w / 2 then
                if not Talisman.config_file.disable_anims then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.other_joker:juice_up(0.5, 0.5)
                            return true
                        end,
                    }))
                end
                return {
                    message = localize({ type = "variable", key = "a_xmult", vars = { 3 } }),
                    Xmult_mod = card.ability.extra.Xmult,
                }
            end
        end
    end
}
----------------
---CODING END---
----------------


---notes
---Lilly wants to kill 2 to 3 jokers, then herself, but let you win the blind instantly.
