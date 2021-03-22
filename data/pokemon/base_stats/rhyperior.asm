if DEF(FAITHFUL)
	db 115, 140, 130,  40,  55,  55 ; 535 BST
	;   hp  atk  def  spd  sat  sdf
else
	db 120, 145, 135,  40,  58,  58 ; 556 BST
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db GROUND, ROCK ; type
else
	db STEEL, ROCK ; type
endc
	db 30 ; catch rate
	db 217 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/rhyperior/front.dimensions"
if DEF(FAITHFUL)
	abilities_for RHYPERIOR, LIGHTNING_ROD, SOLID_ROCK, RECKLESS
else
	abilities_for RHYPERIOR, ROCK_HEAD, SOLID_ROCK, RECKLESS
endc
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_GROUND ; egg groups

	ev_yield   0,   3,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLASH_CANNON, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, FOCUS_BLAST, DRAGON_PULSE, SHADOW_CLAW, POISON_JAB, AVALANCHE, GIGA_IMPACT, STONE_EDGE, SWORDS_DANCE, CUT, SURF, STRENGTH, WHIRLPOOL, AQUA_TAIL, BODY_SLAM, COUNTER, DOUBLE_EDGE, EARTH_POWER, ENDURE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, ICY_WIND, IRON_HEAD, PAY_DAY, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
