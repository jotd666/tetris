

***    
*** BUILD OPTIONS
***

	.ifdef	RELEASE
    OPT_START_SCORE=0                 | LEAVE AT 0!!!
	OPT_SKIP_INTRO_SCREEN=0           | LEAVE AT 0!!!
	OPT_SKIP_GAME_DEMO=0              | LEAVE AT 0!!!
	OPT_NO_FORCED_DOWN=0              | LEAVE AT 0!!!
	OPT_FORCED_RANDOM=0              | LEAVE AT 0!!!
	.else
	
    * hardware options
    OPT_DISABLE_BG_LAYER=0
    OPT_DISABLE_SPRITES=0
   
	* permanent cheats/hacks to test game
    * score is BCD format
	* all options are zeroed for release
    OPT_START_SCORE=0
	OPT_SKIP_INTRO_SCREEN=0
	OPT_SKIP_GAME_DEMO=0
	OPT_NO_FORCED_DOWN=0
	
* shape:
* 1: red bar
* 2: green T
* 3: blue square
* 4: yellow L
* 5: purple L
* 6: light blue S
* 7: orange S

	OPT_FORCED_RANDOM=0
	.endif
	
***
*** end of BUILD OPTIONS
***




* sound ordinals



	.equ	GUARD_KILLED_SND,                     0
	.equ	PICKAXE_SND,                          1
	.equ	PLAYER_CLIMB_SND,                     2
	.equ	PLAYER_WALK_SND,                      3
	.equ	PLAYER_KILLED_TALK_SND,               4
	.equ	REWARD_TALK_SND,                      5
	.equ	FALL_IN_WAGON_SND,                    6
	.equ	PLAYER_GRABS_HANDLE_SND,              7
	.equ	BOMB_SND,                             8
	.equ	SHOT_SND,                             9
	.equ	CREDIT_SND,                           10
	.equ	TIME_WARN_SND,                        11
	.equ	TAKE_BAG_SND,                         12
	.equ	REWARD_TUNE_SND,                      13
	.equ	PLAYER_KILLED_TUNE_SND,     		  14
	.equ	TUNE1_SND,			                  15
	.equ	TUNE2_SND,			                  16
	* same as player climb/walk only less loud
	.equ	GUARD_CLIMB_SND,                      17
	.equ	GUARD_WALK_SND,                       18
	* same as player climb sound
	.equ	TYPING_SND,                      19



    
