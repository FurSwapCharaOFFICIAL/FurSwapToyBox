----------------
--CODING BEGIN--
----------------
---
---
---
furswap = {
	locale_colours = {
		lorecolor = '9E2A9F',
		captioncolor = '009A9A'
	},
}



---Text functions
local function faceartby(artist)
	return '{C:dark_edition,s:0.7,E:2}Floating sprite by : ' .. artist
end

local function originworld(world)
	return '{C:cry_exotic,s:0.7,E:2}Origin : ' .. world
end

local function altuni(world)
	return '{C:cry_blossom,s:0.7,E:2}A.U. : ' .. world
end

local function captions(cap)
	return '{C:captioncolor,E:1}' .. cap
end

local function lore(txt)
	return '{C:lorecolor,s:0.7,E:2}' .. txt
end

local function characterby(txt)
	return '{C:lorecolor,s:0.7,E:2}Character by: ' .. txt
end

--- Startup stuff

if not fur then
    fur = {}
end

SMODS.Atlas {
	key = "modicon",
	path = "furswap_avatar.png",
	px = 34,
	py = 34
}

function Card.add_to_deck(self, from_debuff)
    if not from_debuff then
		local cen = self.gc and self:gc()
		if cen then
			if cen.unique then
				for k, v in ipairs(G.jokers.cards) do
					if v ~= self and v:gc().key == cen.key then
						ease_dollars(self.sell_cost or 0)
						self:destroy()
						return --blocked
					end
				end
			end
		end
	end
end

--- RARITIES
SMODS.Rarity {
	key = 'nightmare',
	loc_txt = {
		name = 'Nightmareish'
	},
	badge_colour = G.C.BLACK
}

---JOKER ATLASES

--SMODS.Atlas {
--	key = 'furswapdemo',
--	px = 71,
--	py = 95,
--	path = 'j_furswap_demo.png'
--}
SMODS.Atlas {
	key = 'furswapnightmare',
	px = 71,
	py = 95,
	path = 'j_furswap_nightmare.png'
}

SMODS.Atlas {
	key = 'furswaplumi',
	px = 71,
	py = 95,
	path = 'j_furswap_lumi.png'
}

SMODS.Atlas {
	key = 'furswapnmlumi',
	px = 71,
	py = 95,
	path = 'j_furswap_lumi.png'

SMODS.Atlas {
	key = 'furswapchara',
	px = 71,
	py = 95,
	path = 'j_furswap_furswapchara.png'
}

SMODS.Atlas {
	key = 'furswapnightmarechara',
	px = 71,
	py = 95,
	path = 'j_furswap_nightmarechara.png'
}

--- Character blurbs
local lumi_blurbs = {
	'>:3 Hehehe.',
	'Bozo.',
	'Go cry about it.',
	'Fibsh.',
	'Ploopy.',
	'FUCK YOU!',
	'Next time, eat a blue fruit!',
	'You try getting better? Didn\'t think so, hehe!',
	'Time to cause chaos (in a cool way)'
}

---SFX
SMODS.Sound({key = 'gong', path = 'gong.ogg'})

---Jokers
SMODS.Joker {
    key = 'furswaplumi',
    loc_txt = {
        name = 'Luminescent',
        text = {'{C:money}Retrigger{} all jokers to the left of this one {C:money}#2# time(s){}.',
			'All jokers to the right of this one give {X:mult,C:white}X#1#{} Mult',
			captions('#3#'),
			faceartby('Quietsuburbs'),
			originworld('Rain World'),
			characterby('Luminescent123')
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
		return {vars ={center.ability.extra.Xmult,center.ability.extra.retriggers,lumi_blurbs[math.random(#lumi_blurbs)]}
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

SMODS.Joker {
	key = 'furswapchara',
	loc_txt = {
		name = 'FurSwap!Chara',
		text = {
			'{C:attention}Lucky{} cards give',
			'{X:purple,C:white}^#1#{} Chips & Mult',
			'when scored',
			' ',
			captions('#2#'),
			captions('#3#'),
			faceartby('FurSwap!Chara'),
			originworld('FurSwap (Undertale X Changed AU)'),
			characterby('FurSwap!Chara')
		}
	},
	config = {lucky = 2},
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	sinis = { x = 2, y = 0 },
	cost = 50,
	rarity = 'cry_exotic',
	fusable = true,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = 'furswapchara',
    loc_vars = function(self, info_queue, center)
        return {vars = {center.ability.lucky, Jen.sinister and 'PLEASE STOP IT! ' or fur.night and 'Hnfff... I feel like it\'s time' or 'Hope you\'re lucky, cuz I\'m sure not', Jen.sinister and 'MY BRAIN HURTS!' or ''}}
    end,
    calculate = function(self, card, context)
		if context.individual then
			if context.cardarea == G.play then
				if context.other_card.ability.name == 'Lucky Card' then
					return {
						e_chips = card.ability.lucky,
						e_mult = card.ability.lucky,
						colour = G.C.PURPLE,
						card = card
					}, true
				end
			end
		end
	end
}

	SMODS.Joker {
		key = 'furswapnightmarechara',
		loc_txt = {
			name = 'Nightmare FurSwap!Chara',
			text = {
				'{C:attention}Lucky{} cards give',
				'{C:edition,s:2.5}#1#(P+1){} Chips & Mult',
				'when scored',
				'{C:inactive}(P = order/position of card in played hand, max. 50)',
				'{C:cry_ascendant,s:1.5,E:1}#2#',
				'',
				faceartby('FurSwap!Chara'),
				originworld('FurSwap (Underswap X Changed)'),
				altuni('Indie Cross'),
				characterby('FurSwap!Chara')
			}
		},
		config = {},
		pos = { x = 0, y = 0 },
		soul_pos = { x = 1, y = 0, extra = { x = 2, y = 0 }},
		drama = { x = 3, y = 0 },
		cost = 250,
		rarity = 'furswap_nightmare',
		unlocked = true,
		discovered = true,
		no_doe = true,
		blueprint_compat = true,
		eternal_compat = true,
		perishable_compat = false,
		immutable = true,
		unique = true,
		debuff_immune = true,
		atlas = 'furswapnightmarechara',
		loc_vars = function(self, info_queue, center)
			return {vars = {'{P-1}', Jen.dramatic and 'Uehehehehe! MORE CHAOS! MOOOOOORE!' or 'I\'m finally STRONG again!'}}
		end,
		calculate = function(self, card, context)
			if context.individual then
				if context.cardarea == G.play then
					if context.other_card.ability.name == 'Lucky Card' then
						local ORDER = 1
						for k, v in ipairs(G.play.cards) do
							if v == context.other_card then
								ORDER = k
								break
							end
						end
						if ORDER == 1 then
							return {
								x_chips = 2,
								x_mult = 2,
								colour = G.C.PURPLE,
								card = card
							}, true
						elseif ORDER == 2 then
							return {
								e_chips = 3,
								e_mult = 3,
								colour = G.C.PURPLE,
								card = card
							}, true
						elseif ORDER == 3 then
							return {
								ee_chips = 4,
								ee_mult = 4,
								colour = G.C.PURPLE,
								card = card
							}, true
						elseif ORDER == 4 then
							return {
								eee_chips = 5,
								eee_mult = 5,
								colour = G.C.PURPLE,
								card = card
							}, true
						else
							ORDER = math.min(ORDER, 51)
							return {
								hyper_chips = {ORDER - 1, ORDER + 1},
								hyper_mult = {ORDER - 1, ORDER + 1},
								colour = G.C.PURPLE,
								card = card
							}, true
						end
					end
				end
			end
		end
	}


---Jokers
SMODS.Joker {
    key = 'furswapnmlumi',
    loc_txt = {
        name = 'Luminescent',
        text = {'{C:money}Retrigger{} all jokers to the left of this one {C:money}#2# time(s){}.',
			'All jokers to the right of this one give {X:mult,C:white}^#1#{} Mult',
			faceartby('Quietsuburbs'),
			originworld('Rain World'),
			characterby('Luminescent123'),
			altuni('Indie Cross')
			},
    },	
	atlas = 'furswaplumi',
    pos = { x = 0, y = 0 },
	soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 }},
	config = {
		extra = {
		emult = 2,
		retriggers = 5
		}
	},
	loc_vars = function(self,info_queue,center)
		return {vars ={center.ability.extra.Xmult,center.ability.extra.retriggers]}
		}
	end,
	cost = 50,
	rarity = 'furswap_nightmare',
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
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
        --E-mult
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
                    e_mult = card.ability.extra.emult,
                }
            end
        end
    end
}




--- THIS ONE IS CODED, just has no sprite yet.
---SMODS.Joker {
---	key = 'furswapdemo',
---	loc_txt = {
---		name = '{C:red}Demo',
---		text = {
---			'{C:clubs}Clubs{} reduce blind size by',
---			'{C:money}5%{} when scored',
---			' ',
--			captions('#2#'),
-- 			faceartby('QuietSuburbs'),
-- 			characterby('demoknight_tf2')
---		}
---	},
---	pos = { x = 0, y = 0 },
---	soul_pos = { x = 1, y = 0 },
---	cost = 50,
---	fusable = true,
---	rarity = 'cry_exotic',
---	unlocked = true,
---	discovered = true,
--	blueprint_compat = true
--	eternal_compat = true,
--	perishable_compat = false,
--	immutable = true,
--	atlas = 'furswapdemo',
  --  loc_vars = function(self, info_queue, center)
    --    return {vars = {center.ability.extra.reduction, Jen.sinister and "DEAR GOD, QUIT TRYNA BLOW UP THE COMPUTER!" or 'Cmon, Let\'s go blow up some blinds!'}}
    --end,
    --calculate = function(self, card, context)
	--	if context.individual and context.cardarea == G.play then
	--		if context.other_card:is_suit('Clubs') then
	--			if (G.SETTINGS.FASTFORWARD or 0) < 1 and (G.SETTINGS.STATUSTEXT or 0) < 2 then
	--				card_status_text(card, '-7% Blind Size', nil, 0.05*card.T.h, G.C.FILTER, 0.75, 1, 0.6, nil, 'bm', 'generic1')
	--			end
	--			change_blind_size(to_big(G.GAME.blind.chips) * to_big(0.95))
	--			return nil, true
	--		end
	--	end
--	end
--}


local nmstone_badge = function(self, card, badges)
	badges[#badges + 1] = create_badge("Supreme Spectral", G.C.CRY_EMBER, G.C.CRY_ASCENDANT, 1.2)
end


SMODS.Consumable {
	key = 'furswapnightmare',
	loc_txt = {
		name = 'Nightmare Stone',
		text = {
			'Create a {C:cry_ascendant,s:1.5,E:1}Nightmareish{C:attention} Joker{}.',
			'{C:red}destroy{} all other Jokers, {C:red,s:1.25}including {C:purple,s:1.25}Eternals',
			'{C:green}Don\'t destroy{} Jokers if you have {C:important,s:1.25}FurSwap!Chara.'
		}
	},
	set = 'Spectral',
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0},
	cost = 25,
	unlocked = true,
	discovered = true,
	atlas = 'furswapnightmare',
	set_card_type_badge = nmstone_badge,
	hidden = true,
	can_use = function(self, card)
		return jl.canuse()
	end,
	use = function(self, card, area, copier)
	use = function(self, card, area, copier)
		if #SMODS.find_card("j_furswap_furswapchara") <= 0 then
			Q(function()
				for k, v in ipairs(G.jokers.cards) do
						v:destroy()
					end
				end
				return true
			end, 0.4)
		end
		Q(function()
			play_sound('furswap_gong')
			local card = create_card('Joker', G.jokers, nil, 'furswap_nightmare', nil, nil, nil, 'furswap_nightmare')
			card:add_to_deck()
			G.jokers:emplace(card)
			card:juice_up(0.3, 0.5)
			return true
		end, 0.75)
	end,
}

----------------
---CODING END---
----------------


---notes
---Lilly wants to kill 2 to 3 jokers, then herself, but let you win the blind instantly.
--- I want to make a blind that debuffs all duplicate jokers.
