extends Node


enum AudioIds {
	BOSS_FIGHT = 0,
	GAMEPLAY_THEME_01 = 10,
	
	HOMEPAGE_LOBBY_THEME_01 = 100,
	
	QUESTION_INFO_THEME_01 = 150,
	TIMER_SOUND = 160,
	
	
	CORRECT_ANSWER = 1000,
	GAME_OVER_LOSE = 1001,
	GAME_STAGE_START= 1002,
	GAME_STAGE_WIN = 1003,
	MALFUNCTION = 1004,
	
	EXPLOSION_01 = 1500,
	TOWER_PURCHASE_01 = 1501,
	
}

const _audio_id_to_sound_file_path = {
	AudioIds.BOSS_FIGHT : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/BossFight.ogg",
	
	AudioIds.CORRECT_ANSWER : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/CorrectAnswer.wav",
	AudioIds.EXPLOSION_01 : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/Explosion.wav",
	AudioIds.GAME_OVER_LOSE : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/GameoverLose.wav",
	AudioIds.GAMEPLAY_THEME_01 : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/GameplayTheme.ogg",
	AudioIds.GAME_STAGE_START : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/GameStageStart.wav",
	AudioIds.GAME_STAGE_WIN : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/GameStageWin.wav",
	AudioIds.HOMEPAGE_LOBBY_THEME_01 : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/HomepageLobbyTheme.ogg",
	AudioIds.MALFUNCTION : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/Malfunction.wav",
	AudioIds.QUESTION_INFO_THEME_01 : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/Question_InfoTheme.ogg",
	AudioIds.TIMER_SOUND : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/TimerSound.ogg",
	AudioIds.TOWER_PURCHASE_01 : "res://CYDE_SPECIFIC_ONLY/Audio/Sound_FX/TowerPurchase(1).ogg",
}

##

func get_audio_path_of_id(arg_id):
	return _audio_id_to_sound_file_path[arg_id]
	

