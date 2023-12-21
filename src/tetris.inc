

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


	.equ	FALL_SND,                     0
	.equ	LINE_SND,                          1
	.equ	PING_SND,                     2
	.equ	START_SND,                      3



    
