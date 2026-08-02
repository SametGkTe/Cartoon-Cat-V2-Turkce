package substates;

import backend.WeekData;

import objects.Character;

import states.StoryMenuState;
import states.FreeplayState;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;

using StringTools;

class GameOverSubstate extends MusicBeatSubstate
{
	public var boyfriend:Character;
	var camFollow:FlxObject;
	var moveCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";

	public static var characterName:String = 'bf-dead';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';

	// Lua ile değişecek mode
	public static var songGameOverMode:String = 'meatbf';

	public static var instance:GameOverSubstate;

	// Extra sprite'lar
	var extraGameOverSprites:Array<FlxSprite> = [];
	var customGameOverSprite:FlxSprite = null;

	public static function resetVariables()
	{
		characterName = 'bf-dead';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';

		var _song = PlayState.SONG;
		if(_song != null)
		{
			if(_song.gameOverChar != null && _song.gameOverChar.trim().length > 0) characterName = _song.gameOverChar;
			if(_song.gameOverSound != null && _song.gameOverSound.trim().length > 0) deathSoundName = _song.gameOverSound;
			if(_song.gameOverLoop != null && _song.gameOverLoop.trim().length > 0) loopSoundName = _song.gameOverLoop;
			if(_song.gameOverEnd != null && _song.gameOverEnd.trim().length > 0) endSoundName = _song.gameOverEnd;
		}
	}

	var charX:Float = 0;
	var charY:Float = 0;

	override function create()
	{
		instance = this;

		Conductor.songPosition = 0;

		boyfriend = new Character(PlayState.instance.boyfriend.getScreenPosition().x, PlayState.instance.boyfriend.getScreenPosition().y, characterName, true);
		boyfriend.x += boyfriend.positionArray[0] - PlayState.instance.boyfriend.positionArray[0];
		boyfriend.y += boyfriend.positionArray[1] - PlayState.instance.boyfriend.positionArray[1];
		add(boyfriend);

		// Song'a özel game over sistemi
		setupSongSpecificGameOver();

		if(songGameOverMode.toLowerCase() != 'turnaround')
			FlxG.sound.play(Paths.sound(deathSoundName));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		if(songGameOverMode.toLowerCase() != 'turnaround')
			boyfriend.playAnim('firstDeath');

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollow.setPosition(boyfriend.getGraphicMidpoint().x + boyfriend.cameraPosition[0], boyfriend.getGraphicMidpoint().y + boyfriend.cameraPosition[1]);
		FlxG.camera.focusOn(new FlxPoint(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2)));
		add(camFollow);
		
		PlayState.instance.setOnScripts('inGameOver', true);
		PlayState.instance.callOnScripts('onGameOverStart', []);

		super.create();
	}

	function addBehindBoyfriend(spr:FlxSprite)
	{
		spr.antialiasing = ClientPrefs.data.antialiasing;
		insert(members.indexOf(boyfriend), spr);
		extraGameOverSprites.push(spr);
	}

	function addReplacementSprite(spr:FlxSprite)
	{
		spr.antialiasing = ClientPrefs.data.antialiasing;
		insert(members.indexOf(boyfriend) + 1, spr);
		customGameOverSprite = spr;
	}

	function makeSpookyClone(offX:Float, offY:Float, flip:Bool)
	{
		var spr = new FlxSprite(boyfriend.x + offX, boyfriend.y + offY);
		spr.frames = Paths.getSparrowAtlas('gameOver/spookyCC');
		spr.animation.addByPrefix('dance', 'dancing furry', 24, true);
		spr.animation.play('dance', true);
		spr.flipX = flip;
		spr.scale.set(0.65, 0.65);
		spr.updateHitbox();
		addBehindBoyfriend(spr);
	}

	function setupSongSpecificGameOver()
	{
		var mode:String = 'meatbf';
		if(songGameOverMode != null && songGameOverMode.trim().length > 0)
			mode = songGameOverMode.toLowerCase();

		switch(mode)
		{
			case 'taf':
				var taf = new FlxSprite(boyfriend.x - 300, boyfriend.y - 170);
				taf.frames = Paths.getSparrowAtlas('gameOver/taf_cc_game_over');
				taf.animation.addByPrefix('idle', 'taf cc game oveerr', 24, true);
				taf.animation.play('idle', true);
				taf.scale.set(1.25, 1.25);
				taf.updateHitbox();
				addBehindBoyfriend(taf);

			case 'turnaround':
				boyfriend.visible = false;

				var turn = new FlxSprite(0, 0);
				turn.loadGraphic(Paths.image('gameOver/turnaroundead'));
				turn.setGraphicSize(FlxG.width, FlxG.height);
				turn.updateHitbox();
				turn.screenCenter();
				turn.alpha = 0;
				turn.scrollFactor.set(0, 0);
				addReplacementSprite(turn);
				FlxTween.tween(turn, {alpha: 1}, 0.5, {ease: FlxEase.quadOut});

			case 'spooky':
				// sol 3 (soldan sağa doğru)
				makeSpookyClone(-760, 0, true);
				makeSpookyClone(-520, 0, true);
				makeSpookyClone(-300, 0, true);

				// sağ 3 (soldan sağa doğru)
				makeSpookyClone(260, 0, false);
				makeSpookyClone(500, 0, false);
				makeSpookyClone(740, 0, false);

			case 'siren':
				boyfriend.visible = false;

				var siren = new FlxSprite(boyfriend.x - 100, boyfriend.y - 200);
				siren.frames = Paths.getSparrowAtlas('gameOver/sh_kills_bf');
				siren.animation.addByPrefix('start', 'start 1', 24, false);
				siren.animation.addByPrefix('loop', 'loop 2', 24, true);
				siren.animation.addByPrefix('end', 'end 2', 24, false);

				siren.animation.finishCallback = function(animName:String)
				{
					if(animName == 'start')
						siren.animation.play('loop', true);
				};

				siren.animation.play('start', true);
				siren.scale.set(0.65, 0.65);
				siren.updateHitbox();
				addReplacementSprite(siren);

			default:
				// meatBF = diğer tüm şarkılar
				boyfriend.visible = false;

				var meat = new FlxSprite(boyfriend.x, boyfriend.y); // gerekirse offset ver
				meat.frames = Paths.getSparrowAtlas('gameOver/meatBF');
				meat.animation.addByPrefix('death', 'bf dies meat note', 24, false);
				meat.animation.play('death', true);
				addReplacementSprite(meat);
		}
	}

	public var startedDeath:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		PlayState.instance.callOnScripts('onUpdate', [elapsed]);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			#if DISCORD_ALLOWED DiscordClient.resetClientID(); #end
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;

			Mods.loadTopMod();
			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new StoryMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			PlayState.instance.callOnScripts('onGameOverConfirm', [false]);
		}
		
		if (boyfriend.animation.curAnim != null)
		{
			if (boyfriend.animation.curAnim.name == 'firstDeath' && boyfriend.animation.curAnim.finished && startedDeath)
				boyfriend.playAnim('deathLoop');

			if(boyfriend.animation.curAnim.name == 'firstDeath')
			{
				if(boyfriend.animation.curAnim.curFrame >= 12 && !moveCamera)
				{
					FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, 0.6);
					moveCamera = true;
				}

				if (boyfriend.animation.curAnim.finished && !playingDeathSound)
				{
					startedDeath = true;
					if (PlayState.SONG.stage == 'tank')
					{
						playingDeathSound = true;
						coolStartDeath(0.2);
						
						var exclude:Array<Int> = [];
						//if(!ClientPrefs.cursing) exclude = [1, 3, 8, 13, 17, 21];

						FlxG.sound.play(Paths.sound('jeffGameover/jeffGameover-' + FlxG.random.int(1, 25, exclude)), 1, false, null, true, function() {
							if(!isEnding)
							{
								FlxG.sound.music.fadeIn(0.2, 1, 4);
							}
						});
					}
					else coolStartDeath();
				}
			}
		}
		
		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnScripts('onUpdatePost', [elapsed]);
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		var mode:String = songGameOverMode != null ? songGameOverMode.toLowerCase() : 'meatbf';

		if(mode == 'turnaround')
			return;

		if(mode == 'siren')
			FlxG.sound.playMusic(Paths.sound('gameOver/music/siren-head'), volume);
		else
			FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;

			var mode:String = songGameOverMode != null ? songGameOverMode.toLowerCase() : 'meatbf';

			if(mode == 'siren' && customGameOverSprite != null)
			{
				customGameOverSprite.animation.play('end', true);
			}

			if(mode == 'turnaround')
			{
				// Ses yok, sadece fade-out
				if(FlxG.sound.music != null)
					FlxG.sound.music.stop();

				if(customGameOverSprite != null)
				{
					FlxTween.tween(customGameOverSprite, {alpha: 0}, 0.5, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween)
					{
						FlxG.camera.fade(FlxColor.BLACK, 0.3, false, function()
						{
							MusicBeatState.resetState();
						});
					}});
				}
				else
				{
					FlxG.camera.fade(FlxColor.BLACK, 0.5, false, function()
					{
						MusicBeatState.resetState();
					});
				}
			}
			else
			{
				boyfriend.playAnim('deathConfirm', true);
				FlxG.sound.music.stop();
				FlxG.sound.play(Paths.music(endSoundName));
				new FlxTimer().start(0.7, function(tmr:FlxTimer)
				{
					FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
					{
						MusicBeatState.resetState();
					});
				});
			}

			PlayState.instance.callOnScripts('onGameOverConfirm', [true]);
		}
	}

	override function destroy()
	{
		instance = null;

		// güvenlik için defaulta dön
		songGameOverMode = 'meatbf';
		customGameOverSprite = null;
		extraGameOverSprites = [];

		super.destroy();
	}
}