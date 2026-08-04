package states;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxSpriteGroup;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;
import backend.Highscore;
import backend.Song;
import states.GalleryState;
import backend.WeekData;

#if VIDEOS_ALLOWED
#if (hxCodec >= "3.0.0") import hxcodec.flixel.FlxVideo as VideoHandler;
#elseif (hxCodec >= "2.6.1") import hxcodec.VideoHandler as VideoHandler;
#elseif (hxCodec == "2.6.0") import VideoHandler;
#else import vlc.MP4Handler as VideoHandler; #end
#end

#if sys
import sys.FileSystem;
#end
import openfl.utils.Assets as OpenFlAssets;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7.3';
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxText>;

	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'extras',
		'credits',
		'options'
	];

	var menuLabels:Array<{text:String, color:FlxColor}> = [
		{text: 'HİKAYE MODU', color: FlxColor.fromRGB(255, 100, 100)},
		{text: 'SERBEST OYUN', color: FlxColor.fromRGB(255, 255, 150)},
		{text: 'GALERİ', color: FlxColor.fromRGB(100, 255, 150)},
		{text: 'YAPIMCILAR', color: FlxColor.fromRGB(255, 165, 0)},
		{text: 'AYARLAR', color: FlxColor.fromRGB(255, 255, 150)}
	];

	var camFollow:FlxObject;

	var bgLayers:FlxTypedGroup<FlxSprite>;
	var currentTheme:String = '';

	var codesGroup:FlxSpriteGroup;
	var codesPanel:FlxSprite;
	var codesDarkBG:FlxSprite;
	var codeButtons:Array<FlxSprite> = [];
	var codeDisplay:FlxText;
	var currentCode:String = '';
	var codesOpen:Bool = false;
	var codesTweening:Bool = false;
	var codesPanelClosedY:Float = 0;
	var codesPanelOpenY:Float = 0;
	var playingSecretVideo:Bool = false;

	var aboutButton:FlxSprite;
	var githubButton:FlxSprite;

	static var secretCodes:Array<{code:String, song:String, diff:Int}> = [
		{code: '0504', song: 'secr', diff: 1},
		{code: '4124', song: 'thats-all-folks', diff: 1},
		{code: '5361', song: 'reruns', diff: 1},
		{code: '7342', song: 'fright-fest', diff: 1},
	];

	static var videoCodes:Array<{code:String, video:String}> = [
		{code: '3131', video: 'hmm/ders'},
		{code: '3169', video: 'hmm/kodlama'},
		{code: '5688', video: 'hmm/emineditnerde'},
		{code: '6899', video: 'hmm/betaemin'},
		{code: '1263', video: 'hmm/parlogyminayizorbaliyor4k'},
		{code: '3142', video: 'hmm/askperisi'},
		{code: '0000', video: 'hmm/thats-odd'},
		{code: '1590', video: 'hmm/hasanxparlogyforever'},
		{code: '5412', video: 'hmm/hasancano'},
		{code: '8342', video: 'hmm/ishowshizuka'},
	];

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		WeekData.reloadWeekFiles(false);
		Difficulty.resetList();

		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Ana Menüde", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		bgLayers = new FlxTypedGroup<FlxSprite>();
		loadRandomTheme();
		add(bgLayers);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		menuItems = new FlxTypedGroup<FlxText>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 50 - (Math.max(optionShit.length, 4) - 4) * 80;
			var yPos:Float = (i * 140) + offset + 5;

			var menuItem:FlxText = new FlxText(80, yPos, 0, "\n" + menuLabels[i].text, 120);
			menuItem.setFormat(Paths.font("murderer.ttf"), 130, menuLabels[i].color, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			menuItem.borderSize = 3;
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.scrollFactor.set(0, (optionShit.length < 6) ? 0 : (optionShit.length - 4) * 0.135);
			menuItem.ID = i;

			menuItem.y -= menuItem.height * 0.4;

			menuItems.add(menuItem);
		}

		var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine Türkiye v" + psychEngineVersion, 12);
		psychVer.scrollFactor.set();
		psychVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(psychVer);

		var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		fnfVer.scrollFactor.set();
		fnfVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fnfVer);

		aboutButton = new FlxSprite().loadGraphic(Paths.image('other/about', 'shared'));
		aboutButton.antialiasing = ClientPrefs.data.antialiasing;
		aboutButton.scrollFactor.set();
		aboutButton.x = FlxG.width - aboutButton.width - 10;
		aboutButton.y = 10;
		add(aboutButton);
		
		githubButton = new FlxSprite().loadGraphic(Paths.image('other/github', 'shared'));
		githubButton.antialiasing = ClientPrefs.data.antialiasing;
		githubButton.scrollFactor.set();
		githubButton.setGraphicSize(100, 100);
		githubButton.updateHitbox();
		githubButton.x = FlxG.width - githubButton.width - 10;
		githubButton.y = FlxG.height - githubButton.height - 10;
		add(githubButton);

		changeItem();

		initCodesPanel();

		FlxG.mouse.visible = true;

		#if ACHIEVEMENTS_ALLOWED
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
			Achievements.unlock('friday_night_play');

		#if MODS_ALLOWED
		Achievements.reloadList();
		#end
		#end

		super.create();

		FlxG.camera.follow(camFollow, null, 9);
	}

	function initCodesPanel():Void
	{
		codesDarkBG = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		codesDarkBG.scrollFactor.set();
		codesDarkBG.alpha = 0;
		add(codesDarkBG);

		codesGroup = new FlxSpriteGroup();
		codesGroup.scrollFactor.set();
		add(codesGroup);

		codesPanel = new FlxSprite((FlxG.width - 347) / 2, 0);
		codesPanel.frames = Paths.getSparrowAtlas('mainmenu/lock/lock_assets', 'shared');
		codesPanel.animation.addByPrefix('idle', 'lock_idle', 24, true);
		codesPanel.animation.addByPrefix('open', 'lock_open', 12, false);
		codesPanel.animation.play('idle');
		codesPanel.antialiasing = ClientPrefs.data.antialiasing;
		codesGroup.add(codesPanel);

		codeDisplay = new FlxText(codesPanel.x + 10, 295, codesPanel.width - 20, "_ _ _ _", 40);
		codeDisplay.setFormat("VCR OSD Mono", 28, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		codeDisplay.antialiasing = ClientPrefs.data.antialiasing;
		codeDisplay.alpha = 0;
		codesGroup.add(codeDisplay);

		var buttonLayout:Array<Array<String>> = [
			['1', '2', '3'],
			['4', '5', '6'],
			['7', '8', '9'],
			['O', '0', 'B']
		];

		var btnW:Float = 62;
		var btnH:Float = 36;
		var btnGapX:Float = 8;
		var btnGapY:Float = 6;
		var gridW:Float = btnW * 3 + btnGapX * 2;
		var btnStartX:Float = codesPanel.x + (codesPanel.width - gridW) / 2;
		var btnStartY:Float = 340;

		codeButtons = [];

		for (row in 0...buttonLayout.length)
		{
			for (col in 0...buttonLayout[row].length)
			{
				var btnKey:String = buttonLayout[row][col];
				var btn:FlxSprite = new FlxSprite(
					btnStartX + col * (btnW + btnGapX),
					btnStartY + row * (btnH + btnGapY)
				);

				btn.frames = Paths.getSparrowAtlas('mainmenu/lock/lock_buttons_assets', 'shared');
				btn.animation.addByPrefix('idle', 'button' + btnKey + 'Idle', 24, true);
				btn.animation.addByPrefix('press', 'button' + btnKey + 'Press', 24, false);
				btn.animation.play('idle');
				btn.antialiasing = ClientPrefs.data.antialiasing;
				btn.alpha = 0;

				if (btnKey == 'B')
					btn.ID = 10;
				else if (btnKey == 'O')
					btn.ID = 11;
				else
					btn.ID = Std.parseInt(btnKey);

				codesGroup.add(btn);
				codeButtons.push(btn);
			}
		}

		codesPanelClosedY = FlxG.height - (codesPanel.height * 0.35);
		codesPanelOpenY = (FlxG.height - codesPanel.height) / 2;
		codesGroup.y = codesPanelClosedY;
	}

	function handleCodesInput():Void
	{
		var mouseX:Float = FlxG.mouse.getScreenPosition().x;
		var mouseY:Float = FlxG.mouse.getScreenPosition().y;

		if (!codesOpen && !codesTweening)
		{
			if (FlxG.mouse.justPressed)
			{
				var realPanelX:Float = codesPanel.x;
				var realPanelY:Float = codesGroup.y;
				var panelW:Float = codesPanel.width;
				var panelH:Float = codesPanel.height;

				if (mouseX >= realPanelX
					&& mouseX <= realPanelX + panelW
					&& mouseY >= realPanelY
					&& mouseY <= realPanelY + panelH)
				{
					trace('Lock Open');
					openCodesPanel();
				}
			}
			return;
		}

		if (codesOpen && !codesTweening)
		{
			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				closeCodesPanel();
				return;
			}

			if (FlxG.mouse.justPressed)
			{
				for (btn in codeButtons)
				{
					if (btn == null || !btn.alive || btn.alpha == 0)
						continue;

					var btnRealX:Float = btn.x;
					var btnRealY:Float = codesGroup.y + (btn.y - codesGroup.y);

					if (mouseX >= btnRealX
						&& mouseX <= btnRealX + btn.width
						&& mouseY >= btnRealY
						&& mouseY <= btnRealY + btn.height)
					{
						btn.animation.play('press');
						btn.animation.finishCallback = function(name:String)
						{
							btn.animation.play('idle');
						};

						FlxG.sound.play(Paths.sound('scrollMenu'));
						onCodeButtonPress(btn.ID);
						break;
					}
				}
			}
		}
	}

	function openCodesPanel():Void
	{
		if (codesTweening)
			return;

		codesOpen = true;
		codesTweening = true;
		currentCode = '';
		updateCodeDisplay();
		codesPanel.animation.play('idle');

		FlxTween.tween(codesDarkBG, {alpha: 0.65}, 0.4, {ease: FlxEase.quartOut});

		FlxTween.tween(codesGroup, {y: codesPanelOpenY}, 0.5, {
			ease: FlxEase.backOut,
			onComplete: function(twn:FlxTween)
			{
				codesTweening = false;

				FlxTween.tween(codeDisplay, {alpha: 1}, 0.3, {ease: FlxEase.quartOut});

				for (i in 0...codeButtons.length)
				{
					var btn = codeButtons[i];
					btn.alpha = 0;
					FlxTween.tween(btn, {alpha: 1}, 0.2, {
						ease: FlxEase.quartOut,
						startDelay: i * 0.03
					});
				}
			}
		});
	}

	function closeCodesPanel():Void
	{
		if (codesTweening)
			return;

		codesTweening = true;

		codeDisplay.alpha = 0;
		for (btn in codeButtons)
		{
			btn.alpha = 0;
		}

		FlxTween.tween(codesDarkBG, {alpha: 0}, 0.4, {ease: FlxEase.quartOut});

		FlxTween.tween(codesGroup, {y: codesPanelClosedY}, 0.5, {
			ease: FlxEase.backIn,
			onComplete: function(twn:FlxTween)
			{
				codesOpen = false;
				codesTweening = false;
				currentCode = '';
				updateCodeDisplay();
			}
		});
	}

	function updateCodeDisplay():Void
	{
		var display:String = '';
		for (i in 0...4)
		{
			if (i < currentCode.length)
				display += currentCode.charAt(i);
			else
				display += '_';

			if (i < 3)
				display += ' ';
		}
		codeDisplay.text = display;
	}

	function onCodeButtonPress(btnID:Int):Void
	{
		if (btnID == 10)
		{
			if (currentCode.length > 0)
			{
				currentCode = currentCode.substr(0, currentCode.length - 1);
				updateCodeDisplay();
			}
		}
		else if (btnID == 11)
		{
			if (currentCode.length == 4)
				checkCode();
			else
				FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		else
		{
			if (currentCode.length < 4)
			{
				currentCode += Std.string(btnID);
				updateCodeDisplay();
			}
		}
	}

	function checkCode():Void
	{
		for (entry in videoCodes)
		{
			if (currentCode == entry.code)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				currentCode = '';
				updateCodeDisplay();
				closeCodesPanel();

				new flixel.util.FlxTimer().start(0.55, function(tmr:flixel.util.FlxTimer)
				{
					startVideo(entry.video);
				});

				return;
			}
		}

		var found:Bool = false;

		for (entry in secretCodes)
		{
			if (currentCode == entry.code)
			{
				found = true;

				codeDisplay.alpha = 0;
				for (btn in codeButtons)
				{
					btn.alpha = 0;
				}

				var oldHeight:Float = codesPanel.height;
				codesPanel.animation.play('open');
				codesPanel.offset.y = codesPanel.frameHeight - oldHeight;

				FlxG.sound.play(Paths.sound('confirmMenu'));

				new flixel.util.FlxTimer().start(0.8, function(tmr:flixel.util.FlxTimer)
				{
					var loaded:Bool = loadSecretSong(entry.song, entry.diff);

					if (loaded)
					{
						PlayState.isStoryMode = false;
						PlayState.storyDifficulty = entry.diff;
						PlayState.storyWeek = 0;

						if (FlxG.sound.music != null)
							FlxG.sound.music.stop();

						LoadingState.loadAndSwitchState(new PlayState());
					}
					else
					{
						trace('Şarkı yüklenemedi: ' + entry.song);
						FlxG.sound.play(Paths.sound('locked'));
						currentCode = '';
						updateCodeDisplay();
						codesPanel.animation.play('idle');
						codesPanel.offset.y = 0;
						codesTweening = false;
						closeCodesPanel();
					}
				});

				break;
			}
		}

		if (!found)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			currentCode = '';
			updateCodeDisplay();
		}
	}

	function loadSecretSong(songName:String, diff:Int):Bool
	{
		var songLowercase:String = Paths.formatToSongPath(songName);
		var jsonsToTry:Array<String> = [];

		Difficulty.resetList();

		var diffSuffix:String = null;
		if (Difficulty.list != null && diff >= 0 && diff < Difficulty.list.length)
		{
			diffSuffix = Difficulty.getFilePath(diff);
		}

		if (diffSuffix != null && diffSuffix.length > 0)
			jsonsToTry.push(songLowercase + diffSuffix);

		switch (diff)
		{
			case 0:
				jsonsToTry.push(songLowercase + '-easy');
				jsonsToTry.push(songLowercase);
			case 1:
				jsonsToTry.push(songLowercase);
				jsonsToTry.push(songLowercase + '-normal');
			case 2:
				jsonsToTry.push(songLowercase + '-hard');
				jsonsToTry.push(songLowercase);
			default:
				jsonsToTry.push(songLowercase);
		}

		var finalList:Array<String> = [];
		for (jsonName in jsonsToTry)
		{
			if (jsonName != null && finalList.indexOf(jsonName) == -1)
				finalList.push(jsonName);
		}

		for (jsonName in finalList)
		{
			try
			{
				trace('Şarkı yükleniyor: ' + jsonName + ' klasör: ' + songLowercase);
				PlayState.SONG = Song.loadFromJson(jsonName, songLowercase);
				return true;
			}
			catch (e:Dynamic)
			{
				trace('Denenen JSON başarısız: ' + jsonName + ' | ' + e);
			}
		}

		return false;
	}

	function loadRandomTheme():Void
	{
		var themes:Array<String> = ['cc', 'cd', 'fetid_king', 'long_horse', 'luna', 'tmwtudf'];
		currentTheme = themes[FlxG.random.int(0, themes.length - 1)];

		trace('Ana Menu Temasi: ' + currentTheme);

		switch (currentTheme)
		{
			case 'cc':
				loadTheme_CC();
			case 'cd':
				loadTheme_CD();
			case 'fetid_king':
				loadTheme_FetidKing();
			case 'long_horse':
				loadTheme_LongHorse();
			case 'luna':
				loadTheme_Luna();
			case 'tmwtudf':
				loadTheme_TMWTUDF();
		}
	}

	function addStaticLayer(path:String, ?x:Float = 0, ?y:Float = 0):FlxSprite
	{
		var spr:FlxSprite = new FlxSprite(x, y).loadGraphic(Paths.image(path, 'shared'));
		spr.antialiasing = ClientPrefs.data.antialiasing;
		spr.scrollFactor.set();
		bgLayers.add(spr);
		return spr;
	}

	function addAnimLayer(path:String, prefix:String, ?fps:Int = 24, ?x:Float = 0, ?y:Float = 0):FlxSprite
	{
		var spr:FlxSprite = new FlxSprite(x, y);
		spr.frames = Paths.getSparrowAtlas(path, 'shared');
		spr.animation.addByPrefix('idle', prefix, fps, true);
		spr.animation.play('idle');
		spr.antialiasing = ClientPrefs.data.antialiasing;
		spr.scrollFactor.set();
		bgLayers.add(spr);
		return spr;
	}

	function setSpriteWidth(spr:FlxSprite, newWidth:Int):Void
	{
		spr.setGraphicSize(newWidth);
		spr.updateHitbox();
	}

	function setSpriteHeight(spr:FlxSprite, newHeight:Int):Void
	{
		spr.setGraphicSize(0, newHeight);
		spr.updateHitbox();
	}

	function scaleSprite(spr:FlxSprite, mult:Float):Void
	{
		spr.scale.set(mult, mult);
		spr.updateHitbox();
	}

	function loadTheme_CC():Void
	{
		var bg = addStaticLayer('mainmenu/custom/cc/ccMenu_background');
		bg.screenCenter();

		var back = addAnimLayer('mainmenu/custom/cc/menuCartoonCat_back', 'cc_back', 24, 715, 30);

		var wall = addStaticLayer('mainmenu/custom/cc/ccMenu_wall');
		wall.x = -40;
		wall.y = 0;

		var front = addAnimLayer('mainmenu/custom/cc/menuCartoonCat_front', 'ccfront', 24, 625, 300);
	}

	function loadTheme_CD():Void
	{
		var bg = addStaticLayer('mainmenu/custom/cc/ccMenu_background');
		bg.screenCenter();

		var dog = addAnimLayer('mainmenu/custom/cd/menuCartoonDog', 'cd_idle', 24, 835, 170);

		var wall = addStaticLayer('mainmenu/custom/cc/ccMenu_wall');
		wall.x = -40;
		wall.y = 0;
	}

	function loadTheme_FetidKing():Void
	{
		var bg = addStaticLayer('mainmenu/custom/fetid king/bg');
		bg.screenCenter();

		var king = addAnimLayer('mainmenu/custom/fetid king/Fetid_King_Menu', 'Fetid King Menu Idle', 24);
		setSpriteWidth(king, FlxG.width);
		king.screenCenter();
		king.x += 270;
		king.y -= 76;

		var black = addStaticLayer('mainmenu/custom/fetid king/black');
		black.screenCenter();
		black.alpha = 0.6;
	}

	function loadTheme_LongHorse():Void
	{
		var bg = addStaticLayer('mainmenu/custom/long horse/bg');
		bg.screenCenter();

		var horse = addAnimLayer('mainmenu/custom/long horse/long_horse_menu_half_1', 'fondo long horse part 1', 24);
		setSpriteWidth(horse, FlxG.width);
		horse.screenCenter();
		horse.x += 30;
		horse.y -= 20;
	}

	function loadTheme_Luna():Void
	{
		var bg = addStaticLayer('mainmenu/custom/luna/bg');
		scaleSprite(bg, 1.08);
		bg.screenCenter();

		var luna = addAnimLayer('mainmenu/custom/luna/luna_H_menu', 'luna', 24);
		setSpriteHeight(luna, 500);
		luna.x = FlxG.width - luna.width + 100;
		luna.y = 150;
	}

	function loadTheme_TMWTUDF():Void
	{
		var baseBG = addStaticLayer('mainmenu/custom/luna/bg');
		scaleSprite(baseBG, 1.08);
		baseBG.screenCenter();

		var bg = addAnimLayer('mainmenu/custom/tmwtudf/Luna_bg_2', 'Luna_bg_2 Idle', 24);
		setSpriteHeight(bg, 860);
		bg.screenCenter();
		bg.x += 140;

		var man = addAnimLayer('mainmenu/custom/tmwtudf/Upsidedown_Man_bg', 'Upsidedown_Man_bg Idle', 24);
		setSpriteHeight(man, 820);
		man.screenCenter();
		man.x += 130;
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (playingSecretVideo)
		{
			super.update(elapsed);
			return;
		}

		handleCodesInput();
		handleAboutButton();

		if (!selectedSomethin && !codesOpen && !codesTweening)
		{
			if (controls.UI_UP_P)
				changeItem(-1);

			if (controls.UI_DOWN_P)
				changeItem(1);

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (selectedSomethin)
					return;

				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));

				FlxFlicker.flicker(menuItems.members[curSelected], 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					switch (optionShit[curSelected])
					{
						case 'story_mode':
							MusicBeatState.switchState(new StoryMenuState());

						case 'freeplay':
							MusicBeatState.switchState(new FreeplayState());

						case 'extras':
							MusicBeatState.switchState(new GalleryState());

						case 'credits':
							MusicBeatState.switchState(new CreditsState());

						case 'options':
							MusicBeatState.switchState(new OptionsState());
							OptionsState.onPlayState = false;
							if (PlayState.SONG != null)
							{
								PlayState.SONG.arrowSkin = null;
								PlayState.SONG.splashSkin = null;
								PlayState.stageUI = 'normal';
							}
					}
				});
			}

			#if desktop
			if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	function handleAboutButton():Void
	{
		if (selectedSomethin || codesOpen || codesTweening)
			return;

		if (FlxG.mouse.justPressed)
		{
			var mouseX:Float = FlxG.mouse.getScreenPosition().x;
			var mouseY:Float = FlxG.mouse.getScreenPosition().y;

			if (mouseX >= aboutButton.x
				&& mouseX <= aboutButton.x + aboutButton.width
				&& mouseY >= aboutButton.y
				&& mouseY <= aboutButton.y + aboutButton.height)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				MusicBeatState.switchState(new AboutState());
				return;
			}

			if (mouseX >= githubButton.x
				&& mouseX <= githubButton.x + githubButton.width
				&& mouseY >= githubButton.y
				&& mouseY <= githubButton.y + githubButton.height)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				CoolUtil.browserLoad("https://github.com/SametGkTe/Cartoon-Cat-V2-Turkce");
				return;
			}
		}
	}

	public function startVideo(name:String):Void
	{
		#if VIDEOS_ALLOWED
		playingSecretVideo = true;
		selectedSomethin = true;

		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.pause();
			FlxG.sound.music.volume = 0;
		}

		var filepath:String = Paths.video(name);

		#if sys
		if(!FileSystem.exists(filepath))
		#else
		if(!OpenFlAssets.exists(filepath))
		#end
		{
			FlxG.log.warn('Couldnt find video file: ' + name);
			playingSecretVideo = false;
			selectedSomethin = false;
			FlxG.sound.music.volume = 1;
			FlxG.sound.music.resume();
			return;
		}

		var video:VideoHandler = new VideoHandler();

		#if (hxCodec >= "3.0.0")
		video.play(filepath);
		video.onEndReached.add(function()
		{
			video.dispose();
			onSecretVideoFinished();
			return;
		}, true);
		#else
		video.playVideo(filepath);
		video.finishCallback = function()
		{
			onSecretVideoFinished();
			return;
		}
		#end

		#else
		FlxG.log.warn('Platform not supported!');
		playingSecretVideo = false;
		selectedSomethin = false;
		return;
		#end
	}

	function onSecretVideoFinished():Void
	{
		playingSecretVideo = false;
		selectedSomethin = false;

		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.volume = 0.8;
			FlxG.sound.music.resume();
		}
	}

	function changeItem(huh:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));

		menuItems.members[curSelected].alpha = 0.6;
		menuItems.members[curSelected].scale.set(1, 1);

		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.members[curSelected].alpha = 1;
		menuItems.members[curSelected].scale.set(1.2, 1.2);

		camFollow.setPosition(menuItems.members[curSelected].x + menuItems.members[curSelected].width / 2,
			menuItems.members[curSelected].y + menuItems.members[curSelected].height / 2);
	}
}