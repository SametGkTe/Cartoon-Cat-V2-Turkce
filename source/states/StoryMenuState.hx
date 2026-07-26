package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;

import flixel.group.FlxGroup;
import flixel.graphics.FlxGraphic;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;

import objects.MenuItem;
import objects.MenuCharacter;

import substates.GameplayChangersSubstate;
import substates.ResetScoreSubState;

class StoryMenuState extends MusicBeatState
{
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	var scoreText:FlxText;

	private static var lastDifficultyName:String = '';
	var curDifficulty:Int = 1;

	var txtWeekTitle:FlxText;

	private static var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var lockSprite:FlxSprite;

	var loadedWeeks:Array<WeekData> = [];

	// TV Elementleri
	var storyTV:FlxSprite;
	var tvStatic:FlxSprite;

	// Mod sistemi (0 = week seçimi, 1 = difficulty seçimi)
	var curMode:Int = 0;

	// TV ekranının iç bölgesi
	var tvInnerX:Float = 0;
	var tvInnerY:Float = 0;
	var tvInnerW:Float = 468;
	var tvInnerH:Float = 372;

	// ============ AYAR DEĞERLERİ - BUNLARI DEĞİŞTİR ============

	// Static ayarları (tvInner'a göre offset)
	var staticOffsetX:Float = 25;      // + sağa, - sola
	var staticOffsetY:Float = -10;     // + aşağı, - yukarı
	var staticScaleX:Float = 0.97;     // 1.0 = tvInnerW ile aynı
	var staticScaleY:Float = 1.26;     // 1.0 = tvInnerH ile aynı

	// Karakter genel ayarları
	var charUseStaticSize:Bool = true; // true = static boyutunu baz al
	var charBaseScale:Float = 1.0;     // tüm karakterleri topluca küçült/büyüt

	// Karakter slot pozisyonları (static alanının yüzdesi)
	var charSlot0:Float = 0.22;       // Sol karakter
	var charSlot1:Float = 0.50;       // Orta karakter
	var charSlot2:Float = 0.78;       // Sağ karakter

	// Karakter başına ayrı offset [sol, orta, sağ]
	var charPerOffsetX:Array<Float> = [0, 0, 0];
	var charPerOffsetY:Array<Float> = [0, 0, 0];

	// Karakter başına ayrı scale çarpanı [sol, orta, sağ]
	var charScaleMul:Array<Float> = [1.0, 1.0, 1.0];

	// Cool (difficulty) ayarları
	var coolOffsetX:Float = -100;       // + sağa, - sola
	var coolOffsetY:Float = -241;      // ekran ortasından yukarı offset
	// ============================================================

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		PlayState.isStoryMode = true;
		WeekData.reloadWeekFiles(true);
		if (curWeek >= WeekData.weeksList.length)
			curWeek = 0;
		persistentUpdate = persistentDraw = true;

		#if DISCORD_ALLOWED
		DiscordClient.changePresence("In the Menus", null);
		#end

		// =============================================
		// KATMAN 1: STORY TV (ARKAPLAN ÇERÇEVE)
		// =============================================
		storyTV = new FlxSprite();
		storyTV.loadGraphic(Paths.image('storymenu/storyTV'));
		storyTV.antialiasing = ClientPrefs.data.antialiasing;
		storyTV.setGraphicSize(FlxG.width);
		storyTV.updateHitbox();
		storyTV.screenCenter();
		add(storyTV);

		// TV ekranının iç bölgesini hesapla
		tvInnerW = storyTV.width * 0.60;
		tvInnerH = storyTV.height * 0.64;
		tvInnerX = storyTV.x + (storyTV.width - tvInnerW) / 2;
		tvInnerY = storyTV.y + (storyTV.height * 0.18);

		// =============================================
		// KATMAN 2: WEEK VERİLERİNİ YÜKLE
		// =============================================
		var num:Int = 0;
		for (i in 0...WeekData.weeksList.length)
		{
			var weekFile:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var isLocked:Bool = weekIsLocked(WeekData.weeksList[i]);
			if (!isLocked || !weekFile.hiddenUntilUnlocked)
			{
				loadedWeeks.push(weekFile);
				num++;
			}
		}

		// =============================================
		// KATMAN 3: MENU KARAKTERLERİ (TV İÇİNDE)
		// =============================================
		WeekData.setDirectoryFromWeek(loadedWeeks[0]);
		var charArray:Array<String> = loadedWeeks[0].weekCharacters;

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();
		for (char in 0...3)
		{
			var weekCharacterThing:MenuCharacter = new MenuCharacter(0, charArray[char]);
			weekCharacterThing.antialiasing = ClientPrefs.data.antialiasing;
			grpWeekCharacters.add(weekCharacterThing);
		}
		add(grpWeekCharacters);

		fitCharactersToTV();

		// =============================================
		// KATMAN 4: TV STATIC (KARAKTERLERİN ÜSTÜNDE)
		// =============================================
		tvStatic = new FlxSprite();
		tvStatic.frames = Paths.getSparrowAtlas('storymenu/static');
		tvStatic.animation.addByPrefix('idle', 'TV static', 24, true);
		tvStatic.animation.play('idle');
		tvStatic.antialiasing = ClientPrefs.data.antialiasing;

		var staticRect = getStaticRect();
		tvStatic.setPosition(staticRect.x, staticRect.y);
		tvStatic.setGraphicSize(Std.int(staticRect.w), Std.int(staticRect.h));
		tvStatic.updateHitbox();
		tvStatic.alpha = 0.4;
		add(tvStatic);

		// =============================================
		// KATMAN 5: TEXT'LER
		// =============================================
		scoreText = new FlxText(10, 10, 0, "HAFTA SKORU: 0", 36);
		scoreText.setFormat("VCR OSD Mono", 32);
		add(scoreText);

		txtWeekTitle = new FlxText(0, 10, FlxG.width - 20, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;
		add(txtWeekTitle);

		txtTracklist = new FlxText(0, 0, FlxG.width * 0.3, "", 20);
		txtTracklist.setFormat(Paths.font("vcr.ttf"), 20, 0xFFe55777, CENTER, OUTLINE, FlxColor.BLACK);
		txtTracklist.borderSize = 2;
		txtTracklist.x = storyTV.x + storyTV.width - 200;
		txtTracklist.y = storyTV.y + storyTV.height * 0.3;
		add(txtTracklist);

		// Mod göstergesi
		var modeHint:FlxText = new FlxText(0, FlxG.height - 30, FlxG.width,
			"SOL/SAĞ: Hafta Değiştir  |  Yukarı: Zorluk Değiştir  |  ENTER: Seç", 16);
		modeHint.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		modeHint.borderSize = 1;
		modeHint.alpha = 0.5;
		add(modeHint);

		var coolAtlas = Paths.getSparrowAtlas('storymenu/cool');

		difficultySelectors = new FlxGroup();

		// Sol ok
		leftArrow = new FlxSprite();
		leftArrow.antialiasing = ClientPrefs.data.antialiasing;
		leftArrow.frames = coolAtlas;
		leftArrow.animation.addByPrefix('idle', 'left arrow', 24, true);
		leftArrow.animation.play('idle');
		leftArrow.visible = false;
		difficultySelectors.add(leftArrow);

		// Difficulty sprite
		sprDifficulty = new FlxSprite();
		sprDifficulty.antialiasing = ClientPrefs.data.antialiasing;
		sprDifficulty.visible = false;
		difficultySelectors.add(sprDifficulty);

		// Sağ ok
		rightArrow = new FlxSprite();
		rightArrow.antialiasing = ClientPrefs.data.antialiasing;
		rightArrow.frames = coolAtlas;
		rightArrow.animation.addByPrefix('idle', 'right arrow', 24, true);
		rightArrow.animation.play('idle');
		rightArrow.visible = false;
		difficultySelectors.add(rightArrow);

		add(difficultySelectors);

		// Lock sprite
		lockSprite = new FlxSprite();
		lockSprite.antialiasing = ClientPrefs.data.antialiasing;
		lockSprite.frames = coolAtlas;
		lockSprite.animation.addByPrefix('idle', 'lock', 24, true);
		lockSprite.animation.play('idle');
		lockSprite.visible = false;
		add(lockSprite);

		positionCoolElements();

		// Difficulty başlat
		Difficulty.resetList();
		if (lastDifficultyName == '')
		{
			lastDifficultyName = Difficulty.getDefault();
		}
		curDifficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(lastDifficultyName)));

		changeWeek();
		changeDifficulty();

		super.create();
	}

	function getStaticRect()
	{
		var sW:Float = tvInnerW * staticScaleX;
		var sH:Float = tvInnerH * staticScaleY;
		var sX:Float = tvInnerX + staticOffsetX - ((sW - tvInnerW) / 2);
		var sY:Float = tvInnerY + staticOffsetY - ((sH - tvInnerH) / 2);
		return {x: sX, y: sY, w: sW, h: sH};
	}

	function fitCharactersToTV()
	{
		var staticRect = getStaticRect();

		// Önce kaç karakter aktif say
		var activeChars:Array<Int> = [];
		for (i in 0...grpWeekCharacters.members.length)
		{
			var char = grpWeekCharacters.members[i];
			if (char != null && char.character != null && char.character.length > 0)
			{
				activeChars.push(i);
			}
		}

		var activeCount:Int = activeChars.length;
		if (activeCount == 0) return;

		// Aktif karakter sayısına göre anchor pozisyonları hesapla
		var anchorXs:Map<Int, Float> = new Map<Int, Float>();

		if (activeCount == 1)
		{
			// Tek karakter: tam ortada
			anchorXs.set(activeChars[0], staticRect.x + staticRect.w * 0.5);
		}
		else if (activeCount == 2)
		{
			// İki karakter: ortada eşit dağıt
			anchorXs.set(activeChars[0], staticRect.x + staticRect.w * 0.33);
			anchorXs.set(activeChars[1], staticRect.x + staticRect.w * 0.66);
		}
		else
		{
			// Üç karakter: eşit dağıt
			anchorXs.set(activeChars[0], staticRect.x + staticRect.w * 0.20);
			anchorXs.set(activeChars[1], staticRect.x + staticRect.w * 0.50);
			anchorXs.set(activeChars[2], staticRect.x + staticRect.w * 0.80);
		}

		for (i in 0...grpWeekCharacters.members.length)
		{
			var char = grpWeekCharacters.members[i];
			if (char == null) continue;

			if (char.character == null || char.character.length < 1)
			{
				char.visible = false;
				continue;
			}

			char.visible = true;
			char.offset.set(0, 0);

			var realW:Float = 100;
			var realH:Float = 100;

			if (char.frame != null)
			{
				realW = char.frame.frame.width;
				realH = char.frame.frame.height;
			}
			else
			{
				realW = char.width;
				realH = char.height;
			}

			if (realW <= 0) realW = 100;
			if (realH <= 0) realH = 100;

			var finalScale:Float = 1;

			if (charUseStaticSize)
			{
				var scaleByW:Float = (staticRect.w / activeCount) / realW;
				var scaleByH:Float = staticRect.h / realH;
				finalScale = Math.min(scaleByW, scaleByH) * charBaseScale;
			}
			else
			{
				var slotWidth:Float = staticRect.w / 3;
				var scaleByW:Float = slotWidth / realW;
				var scaleByH:Float = staticRect.h / realH;
				finalScale = Math.min(scaleByW, scaleByH) * charBaseScale;
			}

			if (i < charScaleMul.length)
				finalScale *= charScaleMul[i];

			char.scale.set(finalScale, finalScale);
			char.updateHitbox();

			var visibleW:Float = realW * finalScale;
			var visibleH:Float = realH * finalScale;

			var posX:Float = anchorXs.exists(i) ? anchorXs.get(i) : (staticRect.x + staticRect.w * 0.5);
			var offX:Float = (i < charPerOffsetX.length) ? charPerOffsetX[i] : 0;
			var offY:Float = (i < charPerOffsetY.length) ? charPerOffsetY[i] : 0;

			char.x = posX - (visibleW / 2) + offX;
			char.y = staticRect.y + staticRect.h - visibleH + offY;
		}
	}

	function positionCoolElements()
	{
		var centerX = (FlxG.width / 2) + coolOffsetX;
		var centerY = (FlxG.height / 2) + coolOffsetY;

		sprDifficulty.setPosition(centerX - (sprDifficulty.width / 2), centerY - (sprDifficulty.height / 2));

		leftArrow.x = sprDifficulty.x - leftArrow.width - 10;
		leftArrow.y = sprDifficulty.y + (sprDifficulty.height / 2) - (leftArrow.height / 2);

		rightArrow.x = sprDifficulty.x + sprDifficulty.width + 10;
		rightArrow.y = sprDifficulty.y + (sprDifficulty.height / 2) - (rightArrow.height / 2);

		lockSprite.setPosition(
			(FlxG.width / 2) - (lockSprite.width / 2),
			(FlxG.height / 2) - (lockSprite.height / 2)
		);
	}

	override function closeSubState()
	{
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}

	override function update(elapsed:Float)
	{
		lerpScore = Math.floor(FlxMath.lerp(intendedScore, lerpScore, Math.exp(-elapsed * 30)));
		if (Math.abs(intendedScore - lerpScore) < 10)
			lerpScore = intendedScore;

		scoreText.text = "HAFTA SKORU:" + lerpScore;

		if (!movedBack && !selectedWeek)
		{
			if (curMode == 0)
			{
				leftArrow.visible = false;
				rightArrow.visible = false;
				sprDifficulty.visible = false;

				if (controls.UI_LEFT_P)
				{
					changeWeek(-1);
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}
				else if (controls.UI_RIGHT_P)
				{
					changeWeek(1);
					FlxG.sound.play(Paths.sound('scrollMenu'));
				}

				if (FlxG.mouse.wheel != 0)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					changeWeek(-FlxG.mouse.wheel);
				}

				if (controls.UI_UP_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					curMode = 1;
					showCoolElements();
				}

				if (controls.ACCEPT)
				{
					selectWeek();
				}
			}
			else if (curMode == 1)
			{
				leftArrow.visible = true;
				rightArrow.visible = true;
				sprDifficulty.visible = true;

				if (controls.UI_RIGHT_P)
				{
					changeDifficulty(1);
				}
				else if (controls.UI_LEFT_P)
				{
					changeDifficulty(-1);
				}

				if (controls.UI_DOWN_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					curMode = 0;
					hideCoolElements();
				}

				if (controls.ACCEPT)
				{
					selectWeek();
				}
			}

			if (FlxG.keys.justPressed.CONTROL)
			{
				persistentUpdate = false;
				openSubState(new GameplayChangersSubstate());
			}
			else if (controls.RESET)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, '', curWeek));
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			if (curMode == 1)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				curMode = 0;
				hideCoolElements();
			}
			else
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				movedBack = true;
				MusicBeatState.switchState(new MainMenuState());
			}
		}

		super.update(elapsed);
	}

	function showCoolElements()
	{
		leftArrow.visible = true;
		rightArrow.visible = true;
		sprDifficulty.visible = true;

		sprDifficulty.alpha = 0;
		FlxTween.tween(sprDifficulty, {alpha: 1}, 0.3, {ease: FlxEase.quartOut});
		leftArrow.alpha = 0;
		FlxTween.tween(leftArrow, {alpha: 1}, 0.3, {ease: FlxEase.quartOut});
		rightArrow.alpha = 0;
		FlxTween.tween(rightArrow, {alpha: 1}, 0.3, {ease: FlxEase.quartOut});
	}

	function hideCoolElements()
	{
		FlxTween.tween(sprDifficulty, {alpha: 0}, 0.2, {
			ease: FlxEase.quartOut,
			onComplete: function(twn:FlxTween)
			{
				sprDifficulty.visible = false;
			}
		});
		FlxTween.tween(leftArrow, {alpha: 0}, 0.2, {
			ease: FlxEase.quartOut,
			onComplete: function(twn:FlxTween)
			{
				leftArrow.visible = false;
			}
		});
		FlxTween.tween(rightArrow, {alpha: 0}, 0.2, {
			ease: FlxEase.quartOut,
			onComplete: function(twn:FlxTween)
			{
				rightArrow.visible = false;
			}
		});
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (!weekIsLocked(loadedWeeks[curWeek].fileName))
		{
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = loadedWeeks[curWeek].songs;
			for (i in 0...leWeek.length)
			{
				songArray.push(leWeek[i][0]);
			}

			try
			{
				PlayState.storyPlaylist = songArray;
				PlayState.isStoryMode = true;
				selectedWeek = true;

				var diffic = Difficulty.getFilePath(curDifficulty);
				if (diffic == null)
					diffic = '';

				PlayState.storyDifficulty = curDifficulty;

				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic,
					PlayState.storyPlaylist[0].toLowerCase());
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;
			}
			catch (e:Dynamic)
			{
				trace('ERROR! $e');
				return;
			}

			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				tvStatic.alpha = 1;
				FlxTween.tween(tvStatic, {alpha: 0.8}, 0.5);

				for (char in grpWeekCharacters.members)
				{
					if (char.character != '' && char.hasConfirmAnimation)
					{
						char.animation.play('confirm');
					}
				}
				stopspamming = true;
			}

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
				FreeplayState.destroyFreeplayVocals();
			});

			#if (MODS_ALLOWED && DISCORD_ALLOWED)
			DiscordClient.loadModRPC();
			#end
		}
		else
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			lockSprite.visible = true;
			lockSprite.alpha = 1;
			FlxTween.tween(lockSprite, {alpha: 0}, 0.8, {
				ease: FlxEase.quartOut,
				onComplete: function(twn:FlxTween)
				{
					lockSprite.visible = false;
				}
			});
		}
	}

	var tweenDifficulty:FlxTween;

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = Difficulty.list.length - 1;
		if (curDifficulty >= Difficulty.list.length)
			curDifficulty = 0;

		WeekData.setDirectoryFromWeek(loadedWeeks[curWeek]);

		var diff:String = Difficulty.getString(curDifficulty);

		var newImage:FlxGraphic = Paths.image('menudifficulties/' + Paths.formatToSongPath(diff));
		if (newImage != null)
		{
			sprDifficulty.loadGraphic(newImage);
		}

		sprDifficulty.updateHitbox();

		var centerX = (FlxG.width / 2) + coolOffsetX;
		var centerY = (FlxG.height / 2) + coolOffsetY;

		sprDifficulty.x = centerX - (sprDifficulty.width / 2);
		sprDifficulty.y = centerY - (sprDifficulty.height / 2);

		leftArrow.x = sprDifficulty.x - leftArrow.width - 10;
		leftArrow.y = sprDifficulty.y + (sprDifficulty.height / 2) - (leftArrow.height / 2);

		rightArrow.x = sprDifficulty.x + sprDifficulty.width + 10;
		rightArrow.y = sprDifficulty.y + (sprDifficulty.height / 2) - (rightArrow.height / 2);

		sprDifficulty.alpha = 0;

		if (tweenDifficulty != null)
			tweenDifficulty.cancel();
		tweenDifficulty = FlxTween.tween(sprDifficulty, {alpha: 1}, 0.07, {
			onComplete: function(twn:FlxTween)
			{
				tweenDifficulty = null;
			}
		});

		lastDifficultyName = diff;

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= loadedWeeks.length)
			curWeek = 0;
		if (curWeek < 0)
			curWeek = loadedWeeks.length - 1;

		var leWeek:WeekData = loadedWeeks[curWeek];
		WeekData.setDirectoryFromWeek(leWeek);

		var leName:String = leWeek.storyName;
		txtWeekTitle.text = leName.toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		PlayState.storyWeek = curWeek;

		Difficulty.loadFromWeek();

		var unlocked:Bool = !weekIsLocked(leWeek.fileName);

		if (Difficulty.list.contains(Difficulty.getDefault()))
			curDifficulty = Math.round(Math.max(0, Difficulty.defaultList.indexOf(Difficulty.getDefault())));
		else
			curDifficulty = 0;

		var newPos:Int = Difficulty.list.indexOf(lastDifficultyName);
		if (newPos > -1)
		{
			curDifficulty = newPos;
		}

		tvStatic.alpha = 1;
		FlxTween.tween(tvStatic, {alpha: 0.3}, 0.5, {ease: FlxEase.quartOut});

		updateText();
		changeDifficulty();
	}

	function weekIsLocked(name:String):Bool
	{
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked
			&& leWeek.weekBefore.length > 0
			&& (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}

	function updateText()
	{
		var weekArray:Array<String> = loadedWeeks[curWeek].weekCharacters;
		for (i in 0...grpWeekCharacters.length)
		{
			grpWeekCharacters.members[i].character = null;
			grpWeekCharacters.members[i].changeCharacter(weekArray[i]);
		}

		fitCharactersToTV();

		var leWeek:WeekData = loadedWeeks[curWeek];
		var stringThing:Array<String> = [];
		for (i in 0...leWeek.songs.length)
		{
			stringThing.push(leWeek.songs[i][0]);
		}

		txtTracklist.text = '';
		for (i in 0...stringThing.length)
		{
			txtTracklist.text += stringThing[i] + '\n';
		}
		txtTracklist.text = txtTracklist.text.toUpperCase();
		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		#if !switch
		intendedScore = Highscore.getWeekScore(loadedWeeks[curWeek].fileName, curDifficulty);
		#end
	}
}