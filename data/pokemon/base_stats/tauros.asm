	db  75, 100,  95, 110,  40,  70 ; 490 BST
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 211 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F0, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/tauros/front.dimensions"
	abilities_for TAUROS, INTIMIDATE, ANGER_POINT, SHEER_FORCE
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield   0,   1,   0,   1,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, WILD_CHARGE, WATER_PULSE, GIGA_IMPACT, STONE_EDGE, SURF, STRENGTH, WHIRLPOOL, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, IRON_HEAD, SLEEP_TALK, SWAGGER, ZAP_CANNON, ZEN_HEADBUTT
	; end
