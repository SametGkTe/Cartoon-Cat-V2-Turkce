package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;

import objects.HealthIcon;
import objects.MusicPlayer;

import substates.GameplayChangersSubstate;
import substates.ResetScoreSubState;

import flixel.math.FlxMath;
import flixel.graphics.FlxGraphic;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class FreeplayState extends MusicBeatState
{
	public var songs:Array<SongMetadata> = [];

	private static var curSelected:Int = 0;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = Difficulty.getDefault();

	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	var curMode:Int = 0;

	var bg:FlxSprite;
	var overlay:FlxSprite;
	public var songText:FlxText;
	public var infoText:FlxText;

	var missingTextBG:FlxSprite;
	var missingText:FlxText;

	public var bottomString:String;
	public var bottomText:FlxText;
	var bottomBG:FlxSprite;

	var player:MusicPlayer;

	var bgTween:FlxTween;

	public var holdTime:Float = 0;

	override function create()
	{
		persistentUpdate = true;
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if DISCORD_ALLOWED
		DiscordClient.changePresence("In the Menus", null);
		#end

		for (i in 0...WeekData.weeksList.length)
		{
			if (weekIsLocked(WeekData.weeksList[i])) continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs)
			{
				var colors:Array<Int> = song[2];
				if (colors == null || colors.length < 3)
					colors = [146, 113, 253];
				addSong(song[0], i, song[1], FlxColor.fromRGB(colors[0], colors[1], colors[2]));
			}
		}
		Mods.loadTopMod();

		if (songs.length < 1)
			addSong("No Songs Found", 0, "face", FlxColor.fromRGB(128, 128, 128));

		bg = new FlxSprite();
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg);

		overlay = new FlxSprite();
		overlay.antialiasing = ClientPrefs.data.antialiasing;
		var overlayFrames = Paths.getSparrowAtlas('menus/freeplay/shit');
		if (overlayFrames != null)
		{
			overlay.frames = overlayFrames;
			overlay.animation.addByPrefix('idle', 'idle', 24, true);
			if (overlay.animation.exists('idle'))
				overlay.animation.play('idle');
		}
		else
		{
			var overlayGraphic:FlxGraphic = Paths.image('menus/freeplay/shit');
			if (overlayGraphic != null)
				overlay.loadGraphic(overlayGraphic);
		}
		overlay.setGraphicSize(FlxG.width, FlxG.height);
		overlay.updateHitbox();
		overlay.screenCenter();
		add(overlay);

		songText = new FlxText(0, 0, FlxG.width, "", 52);
		songText.setFormat(Paths.font("text.ttf"), 48, FlxColor.BLACK, CENTER);
		songText.screenCenter();
		add(songText);
		
		var songFormat = songText.textField.defaultTextFormat;
		songFormat.letterSpacing = -2; // -1 hafif, -2 iyi, -3 daha sıkı
		songText.textField.defaultTextFormat = songFormat;
		songText.textField.setTextFormat(songFormat);

		infoText = new FlxText(120, 80, FlxG.width * 0.5, "", 28);
		infoText.setFormat(Paths.font("text.ttf"), 28, FlxColor.BLACK, LEFT);
		add(infoText);

		missingTextBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		missingTextBG.alpha = 0.6;
		missingTextBG.visible = false;
		add(missingTextBG);

		missingText = new FlxText(50, 0, FlxG.width - 100, '', 24);
		missingText.setFormat(Paths.font("text.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missingText.scrollFactor.set();
		missingText.visible = false;
		add(missingText);

		bottomBG = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		bottomBG.alpha = 0.6;
		add(bottomBG);

		var leText:String = "SPACE: Dinle  |  CTRL: Oynanış Ayarları  |  RESET: Skoru Sıfırla";
		bottomString = leText;
		bottomText = new FlxText(bottomBG.x, bottomBG.y + 4, FlxG.width, leText, 16);
		bottomText.setFormat(Paths.font("text.ttf"), 16, FlxColor.WHITE, CENTER);
		bottomText.scrollFactor.set();
		add(bottomText);

		player = new MusicPlayer(this);
		add(player);

		if (curSelected >= songs.length) curSelected = 0;

		curDifficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(lastDifficultyName)));

		changeSelection(0, false);
		changeDiff(0);

		super.create();
	}

	override function closeSubState()
	{
		changeSelection(0, false);
		persistentUpdate = true;
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool
	{
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked
			&& leWeek.weekBefore.length > 0
			&& (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore)
				|| !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}

	var instPlaying:Int = -1;
	public static var vocals:FlxSound = null;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

		lerpScore = Math.floor(FlxMath.lerp(intendedScore, lerpScore, Math.exp(-elapsed * 24)));
		lerpRating = FlxMath.lerp(intendedRating, lerpRating, Math.exp(-elapsed * 12));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(CoolUtil.floorDecimal(lerpRating * 100, 2)).split('.');
		if (ratingSplit.length < 2) ratingSplit.push('');
		while (ratingSplit[1].length < 2) ratingSplit[1] += '0';

		if (!player.playingMusic)
		{
			var diffDisplay:String = Difficulty.getDisplayString(curDifficulty);

			var diffLine:String = '';
			if (curMode == 1 && Difficulty.list.length > 1)
				diffLine = '< ' + diffDisplay.toUpperCase() + ' >';
			else
				diffLine = diffDisplay.toUpperCase();

			infoText.text = 'SKOR: ' + lerpScore + ' (%' + ratingSplit.join('.') + ')\n' + diffLine;
		}

		var shiftMult:Int = 1;
		if (FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if (!player.playingMusic)
		{
			if (curMode == 0)
			{
				if (songs.length > 1)
				{
					if (FlxG.keys.justPressed.HOME)
					{
						curSelected = 0;
						changeSelection(0);
						holdTime = 0;
					}
					else if (FlxG.keys.justPressed.END)
					{
						curSelected = songs.length - 1;
						changeSelection(0);
						holdTime = 0;
					}

					if (controls.UI_LEFT_P)
					{
						changeSelection(-shiftMult);
						holdTime = 0;
					}
					if (controls.UI_RIGHT_P)
					{
						changeSelection(shiftMult);
						holdTime = 0;
					}

					if (controls.UI_LEFT || controls.UI_RIGHT)
					{
						var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
						holdTime += elapsed;
						var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

						if (holdTime > 0.5 && checkNewHold - checkLastHold > 0)
							changeSelection((checkNewHold - checkLastHold) * (controls.UI_LEFT ? -shiftMult : shiftMult));
					}

					if (FlxG.mouse.wheel != 0)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
						changeSelection(-shiftMult * FlxG.mouse.wheel, false);
					}
				}

				if (controls.UI_UP_P || controls.UI_DOWN_P)
				{
					curMode = 1;
					FlxG.sound.play(Paths.sound('scrollMenu'));
					holdTime = 0;
				}
			}
			else if (curMode == 1)
			{
				if (controls.UI_LEFT_P)
				{
					changeDiff(-1);
					_updateSongLastDifficulty();
				}
				else if (controls.UI_RIGHT_P)
				{
					changeDiff(1);
					_updateSongLastDifficulty();
				}

				if (controls.UI_UP_P || controls.UI_DOWN_P)
				{
					curMode = 0;
					FlxG.sound.play(Paths.sound('scrollMenu'));
					holdTime = 0;
				}
			}
		}

		if (controls.BACK)
		{
			if (player.playingMusic)
			{
				FlxG.sound.music.stop();
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;
				instPlaying = -1;

				player.playingMusic = false;
				player.switchPlayMusic();

				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
				FlxTween.tween(FlxG.sound.music, {volume: 1}, 1);
			}
			else
			{
				persistentUpdate = false;
				if (bgTween != null) bgTween.cancel();
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
		}

		if (FlxG.keys.justPressed.CONTROL && !player.playingMusic)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}

		if (FlxG.keys.justPressed.SPACE)
		{
			if (instPlaying != curSelected && !player.playingMusic)
			{
				destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;

				Mods.currentModDirectory = songs[curSelected].folder;
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
				if (PlayState.SONG.needsVoices)
				{
					vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
					FlxG.sound.list.add(vocals);
					vocals.persist = true;
					vocals.looped = true;
				}
				else if (vocals != null)
				{
					vocals.stop();
					vocals.destroy();
					vocals = null;
				}

				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.8);
				if (vocals != null)
				{
					vocals.play();
					vocals.volume = 0.8;
				}
				instPlaying = curSelected;

				player.playingMusic = true;
				player.curTime = 0;
				player.switchPlayMusic();
			}
			else if (instPlaying == curSelected && player.playingMusic)
			{
				player.pauseOrResume(player.paused);
			}
		}

		if (controls.ACCEPT && !player.playingMusic)
		{
			persistentUpdate = false;
			var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
			trace(poop);

			try
			{
				PlayState.SONG = Song.loadFromJson(poop, songLowercase);
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = curDifficulty;

				trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
				if (bgTween != null) bgTween.cancel();
			}
			catch (e:Dynamic)
			{
				trace('ERROR! $e');

				var errorStr:String = e.toString();
				if (errorStr.startsWith('[file_contents,assets/data/'))
					errorStr = 'Eksik dosya: ' + errorStr.substring(34, errorStr.length - 1);
				missingText.text = 'CHART YUKLENIRKEN HATA:\n$errorStr';
				missingText.screenCenter(Y);
				missingText.visible = true;
				missingTextBG.visible = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));

				super.update(elapsed);
				return;
			}
			LoadingState.loadAndSwitchState(new PlayState());

			FlxG.sound.music.volume = 0;
			destroyFreeplayVocals();
			#if (MODS_ALLOWED && DISCORD_ALLOWED)
			DiscordClient.loadModRPC();
			#end
		}

		if (controls.RESET && !player.playingMusic)
		{
			persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		super.update(elapsed);
	}

	public static function destroyFreeplayVocals()
	{
		if (vocals != null)
		{
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeDiff(change:Int = 0)
	{
		if (player.playingMusic) return;

		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = Difficulty.list.length - 1;
		if (curDifficulty >= Difficulty.list.length)
			curDifficulty = 0;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		lastDifficultyName = Difficulty.getString(curDifficulty);

		missingText.visible = false;
		missingTextBG.visible = false;
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if (player.playingMusic) return;

		_updateSongLastDifficulty();
		if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		var lastList:Array<String> = Difficulty.list;
		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		songText.text = '< ' + songs[curSelected].songName.toUpperCase() + ' >';
		songText.screenCenter();
		songText.x -= 200;

		updateBackground();

		Mods.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;
		Difficulty.loadFromWeek();

		var savedDiff:String = songs[curSelected].lastDifficulty;
		var lastDiff:Int = Difficulty.list.indexOf(lastDifficultyName);
		if (savedDiff != null && !lastList.contains(savedDiff) && Difficulty.list.contains(savedDiff))
			curDifficulty = Math.round(Math.max(0, Difficulty.list.indexOf(savedDiff)));
		else if (lastDiff > -1)
			curDifficulty = lastDiff;
		else if (Difficulty.list.contains(Difficulty.getDefault()))
			curDifficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(Difficulty.getDefault())));
		else
			curDifficulty = 0;

		changeDiff();
		_updateSongLastDifficulty();
	}

	function updateBackground()
	{
		var songName:String = songs[curSelected].songName;
		var bgPath:String = 'menus/freeplay/' + Paths.formatToSongPath(songName);

		var bgGraphic:FlxGraphic = Paths.image(bgPath);

		if (bgGraphic != null)
		{
			bg.loadGraphic(bgGraphic);
			bg.setGraphicSize(FlxG.width, FlxG.height);
			bg.updateHitbox();
			bg.screenCenter();
			bg.alpha = 0;
			if (bgTween != null) bgTween.cancel();
			bgTween = FlxTween.tween(bg, {alpha: 1}, 0.4, {
				ease: FlxEase.quartOut,
				onComplete: function(twn:FlxTween) { bgTween = null; }
			});
		}
		else
		{
			bg.loadGraphic(Paths.image('menuDesat'));
			bg.setGraphicSize(FlxG.width, FlxG.height);
			bg.updateHitbox();
			bg.screenCenter();
			bg.color = songs[curSelected].color;
			bg.alpha = 1;
		}
	}

	inline private function _updateSongLastDifficulty()
	{
		songs[curSelected].lastDifficulty = Difficulty.getString(curDifficulty);
	}

	override function destroy():Void
	{
		super.destroy();

		FlxG.autoPause = ClientPrefs.data.autoPause;
		if (!FlxG.sound.music.playing)
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";
	public var lastDifficulty:String = null;

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Mods.currentModDirectory;
		if (this.folder == null) this.folder = '';
	}
}