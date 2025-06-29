package backend;

import flixel.util.FlxColor;

class ResetPrefs {
	public static function apply():Void {
		var clientData = ClientPrefs.data;

		clientData.downScroll = false;
		clientData.middleScroll = false;
		clientData.opponentStrums = true;
		clientData.showFPS = true;
		clientData.flashing = true;
		clientData.autoPause = true;
		clientData.antialiasing = true;
		clientData.noteSkin = 'Default';
		clientData.splashSkin = 'Psych';
		clientData.splashAlpha = 0;
		clientData.lowQuality = false;
		clientData.shaders = true;
		clientData.cacheOnGPU = #if !switch false #else true #end;
		clientData.camZooms = true;
		clientData.hideHud = false;
		clientData.noteOffset = 0;

		clientData.arrowRGB = [
			[0xFF9B59B6, 0xFFE8DAEF, 0xFF512E5F],
			[0xFFAF7AC5, 0xFFF5EEF8, 0xFF4A235A],
			[0xFFAF7AC5, 0xFFF5EEF8, 0xFF4A235A],
			[0xFF9B59B6, 0xFFE8DAEF, 0xFF512E5F]
		];

		clientData.arrowRGBPixel = [
			[0xFF9B59B6, 0xFFE8DAEF, 0xFF512E5F],
			[0xFFAF7AC5, 0xFFF5EEF8, 0xFF4A235A],
			[0xFFAF7AC5, 0xFFF5EEF8, 0xFF4A235A],
			[0xFF9B59B6, 0xFFE8DAEF, 0xFF512E5F]
		];

		clientData.ghostTapping = true;
		clientData.timeBarType = 'Song Name';
		clientData.scoreZoom = true;
		clientData.noReset = false;
		clientData.healthBarAlpha = 1;
		clientData.hitsoundVolume = 0;
		clientData.pauseMusic = 'Tea Time';
		clientData.menuSong = 'freakyMenu';
		clientData.checkForUpdates = true;
		clientData.comboStacking = true;

		clientData.gameplaySettings = [
			'scrollspeed' => 1.0,
			'scrolltype' => 'multiplicative',
			'songspeed' => 1.0,
			'healthgain' => 1.0,
			'healthloss' => 1.0,
			'instakill' => false,
			'practice' => false,
			'botplay' => false,
			'opponentplay' => false
		];

		clientData.comboOffset = [0, 0, 0, 0];
		clientData.ratingOffset = 0;
		clientData.sickWindow = 45;
		clientData.goodWindow = 90;
		clientData.badWindow = 135;
		clientData.safeFrames = 10;
		clientData.guitarHeroSustains = true;
		clientData.discordRPC = true;

		ClientPrefs.saveSettings();
	}
}
