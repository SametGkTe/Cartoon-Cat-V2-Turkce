package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.transition.FlxTransitionableState;
import flxanimate.FlxAnimate;
import backend.Conductor;

class AboutState extends MusicBeatState
{
	var scrollY:Float = 0;
	var targetScrollY:Float = 0;
	var maxScroll:Float = 8000;
	var scrollSpeed:Float = 60;
	var smoothFactor:Float = 8;

	var mainGroup:FlxSpriteGroup;

	var petLogo:FlxSprite;
	var petBaseScale:Float = 1.0;
	var bumpScale:Float = 1.15;
	var bumpReturning:Bool = false;

	var crowdAnim:FlxAnimate;
	var bgSprite:FlxSprite;

	var creditIcons:Array<{sprite:FlxSprite, link:String, baseScale:Float, bumping:Bool}> = [];
	var hoveredCredit:Int = -1;

	var scrollbarBG:FlxSprite;
	var scrollbarThumb:FlxSprite;
	var scrollbarAlpha:Float = 1.0;
	var scrollbarTargetAlpha:Float = 1.0;
	var scrollbarIdleTimer:Float = 0;
	var scrollbarFadeDelay:Float = 1.0;
	var lastScrollY:Float = 0;
	var scrollbarTrackHeight:Float = 0;
	var scrollbarThumbHeight:Float = 0;

	override function create()
	{
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Hakkında", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var darkFill:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height * 20, FlxColor.fromRGB(30, 30, 30));
		darkFill.scrollFactor.set();
		add(darkFill);

		mainGroup = new FlxSpriteGroup();
		mainGroup.scrollFactor.set();
		add(mainGroup);

		crowdAnim = new FlxAnimate(0, 0, 'assets/shared/images/about/crowd');
		crowdAnim.anim.play();
		crowdAnim.antialiasing = ClientPrefs.data.antialiasing;
		crowdAnim.x = FlxG.width - 600;
		crowdAnim.y = FlxG.height - 720;
		mainGroup.add(crowdAnim);

		bgSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('about/bg', 'shared'));
		bgSprite.antialiasing = ClientPrefs.data.antialiasing;
		bgSprite.setGraphicSize(0, FlxG.height);
		bgSprite.updateHitbox();
		bgSprite.x = -50;
		bgSprite.y = 0;
		mainGroup.add(bgSprite);

		var scrollBGs:Array<String> = ['menuBG', 'menuBGMagenta', 'menuDesat', 'menuBGBlue'];
		var nextBgY:Float = FlxG.height;

		for (bgName in scrollBGs)
		{
			var bg:FlxSprite = new FlxSprite(0, nextBgY).loadGraphic(Paths.image(bgName, 'shared'));
			bg.antialiasing = ClientPrefs.data.antialiasing;
			bg.setGraphicSize(FlxG.width);
			bg.updateHitbox();
			mainGroup.add(bg);
			nextBgY += bg.height;
		}

		var mallBg:FlxSprite = new FlxSprite(0, nextBgY).loadGraphic(Paths.image('cc/mallBg', 'shared'));
		mallBg.antialiasing = ClientPrefs.data.antialiasing;
		mallBg.setGraphicSize(FlxG.width);
		mallBg.updateHitbox();
		mainGroup.add(mallBg);
		nextBgY += mallBg.height;

		var server:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('about/server', 'shared'));
		server.antialiasing = ClientPrefs.data.antialiasing;
		server.scale.set(0.5, 0.5);
		server.updateHitbox();
		server.x = 0;
		server.y = FlxG.height - server.height - 30;
		mainGroup.add(server);

		var lights:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('about/lights', 'shared'));
		lights.antialiasing = ClientPrefs.data.antialiasing;
		lights.scale.set(0.6, 0.6);
		lights.updateHitbox();
		lights.screenCenter(flixel.util.FlxAxes.X);
		lights.y = -20;
		mainGroup.add(lights);

		petLogo = new FlxSprite(0, 0).loadGraphic(Paths.image('about/pet', 'shared'));
		petLogo.antialiasing = ClientPrefs.data.antialiasing;
		petLogo.screenCenter(flixel.util.FlxAxes.X);
		petLogo.y = 80;
		petBaseScale = petLogo.scale.x;
		mainGroup.add(petLogo);

		var titleText:FlxText = new FlxText(0, petLogo.y + petLogo.height + 10, FlxG.width, "PSYCH ENGİNE TÜRKİYE");
		titleText.setFormat(Paths.font("Avgardd.ttf"), 48, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		titleText.borderSize = 2;
		titleText.antialiasing = ClientPrefs.data.antialiasing;
		mainGroup.add(titleText);

		var descStartY:Float = titleText.y + titleText.height + 20;

		var descriptions:Array<String> = [
			"Psych Engine Türkiye, Friday Night Funkin' Psych Engine'in",
			"Türkçe topluluğu için yapılmış bir modudur.",
			"",
			"Türk kullanıcılarına daha iyi bir.",
			"deneyim kurmayı amaçlar",
			"Bu proje açık kaynaklıdır ve herkesin katkıda",
			"bulunmasına açıktır.",
			"",
			"Bizi desteklediğiniz için teşekkür ederiz!",
		];

		for (i in 0...descriptions.length)
		{
			var line:FlxText = new FlxText(0, descStartY + (i * 36), FlxG.width, descriptions[i]);
			line.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			line.borderSize = 2;
			line.antialiasing = ClientPrefs.data.antialiasing;
			mainGroup.add(line);
		}

		var creditsStartY:Float = descStartY + (descriptions.length * 36) + 60;

		var creditsData:Array<Array<String>> = [
			['Psych Engine Türkiye'],
			['SametGkTe', 'gkte', 'Psych Engine Türkiye Yapımcısı', 'https://www.tiktok.com/@sametgkte', '26C21B'],
			['Temsilciler'],
			['XQZ64', 'tabi', 'Psych Engine Türkiye Temsilcisi', 'https://www.tiktok.com/@xqz_64', 'C2BDB8'],
			['Nexus', 'nexus', 'Psych Engine Türkiye Temsilcisi', 'https://www.tiktok.com/@skynexus0.03', '2ECC71'],
			['Syran', 'syran', 'Psych Engine Türkiye Temsilcisi', 'https://www.tiktok.com/@ssyrann', 'FF69B4'],
			['Ahmet Tanelan', 'goku', 'Psych Engine Türkiye Temsilcisi', 'https://www.tiktok.com/@skynexus0.03', 'FF8C00'],
			['New Rigel Records'],
			['Parlogy', 'cc', 'Cartoon Cat / Michael / New Rigel Records Kurucusu', 'https://www.tiktok.com/@prlyg_9001', '474543'],
			['Hasan Bey', 'rigel', 'Boyfriend / New Rigel Records Kurucusu', 'https://www.tiktok.com/@hasanbey5656', 'D1CBC7'],
			['Shizuka', 'luna', 'Luna Henderson', 'https://www.tiktok.com/@shizu_xa', '94613D'],
			['Minalin', 'gf', 'Girlfriend', 'https://www.tiktok.com/@minalin_s', 'D11547'],
			['Haktan', 'siren', 'Siren Kafa (Erkek), 911 Operatör, Daniel, Upsidedown Man', 'https://www.tiktok.com/@mr_milton010', '8F2234'],
			['Balc', 'lemon', 'Lemon Demon', 'https://www.tiktok.com/@balc_tr', 'B9C722'],
			['EminDub', 'equ', 'Cartoon Dog, Long Hair, Sahne Editörü', 'https://www.tiktok.com/@meetwith_emin', '858A84'],
			['Defne', 'siren', 'Siren Kafa (Kadın)', 'https://www.tiktok.com/@hasanbey5656', '8F2234'],
			['Programcılar'],
			['SametGkTe', 'gkte', 'Tüm Oyun, Engine, Menüler vb.', 'https://www.tiktok.com/@sametgkte', '26C21B'],
			['Çeviriler'],
			['Nexus', 'nexus', 'Bazı çeviriler', 'https://www.tiktok.com/@skynexus0.03', '2ECC71'],
			['Temsilciler'],
			['Serdar', 'rigel', 'Temsilci', 'https://www.tiktok.com/@mr_milton010', 'C2BDB8'],
			['Batuhan', 'rigel', 'Temsilci', 'https://www.tiktok.com/@mr_milton010', 'C2BDB8'],
			['Burak', 'rigel', 'Temsilci', 'https://www.tiktok.com/@mr_milton010', 'C2BDB8'],
			['Mete', 'rigel', 'Temsilci', 'https://www.tiktok.com/@mr_milton010', 'C2BDB8'],
			['Şeyma', 'rigel', 'Temsilci', 'https://www.tiktok.com/@mr_milton010', 'C2BDB8'],
			['Şeyma', 'rigel', 'Temsilci', 'https://www.tiktok.com/@mr_milton010', 'C2BDB8'],
		];

		var currentY:Float = creditsStartY;

		for (entry in creditsData)
		{
			if (entry.length == 1)
			{
				var categoryText:FlxText = new FlxText(0, currentY, FlxG.width, entry[0]);
				categoryText.setFormat(Paths.font("Avgardd.ttf"), 44, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				categoryText.borderSize = 3;
				categoryText.antialiasing = ClientPrefs.data.antialiasing;
				mainGroup.add(categoryText);
				currentY += 75;
			}
			else
			{
				var iconName:String = entry[1];
				var personName:String = entry[0];
				var role:String = entry[2];
				var link:String = entry[3];
				var hexColor:String = entry[4];

				var color:FlxColor = FlxColor.fromString('#' + hexColor);

				var icon:FlxSprite = new FlxSprite(FlxG.width / 2 - 200, currentY).loadGraphic(Paths.image('credits/' + iconName, 'shared'));
				icon.antialiasing = ClientPrefs.data.antialiasing;
				icon.setGraphicSize(110, 110);
				icon.updateHitbox();
				mainGroup.add(icon);

				var nameText:FlxText = new FlxText(Std.int(FlxG.width / 2 - 70), Std.int(currentY + 8), 600, personName);
				nameText.setFormat(Paths.font("Avgardd.ttf"), 36, color, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				nameText.borderSize = 2;
				nameText.antialiasing = ClientPrefs.data.antialiasing;
				mainGroup.add(nameText);

				var roleText:FlxText = new FlxText(Std.int(FlxG.width / 2 - 70), Std.int(currentY + 52), 600, role);
				roleText.setFormat(Paths.font("vcr.ttf"), 22, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				roleText.borderSize = 2;
				roleText.antialiasing = ClientPrefs.data.antialiasing;
				mainGroup.add(roleText);

				creditIcons.push({
					sprite: icon,
					link: link,
					baseScale: icon.scale.x,
					bumping: false
				});

				currentY += 130;
			}
		}

		currentY += 100;

		var thanksText:FlxText = new FlxText(0, currentY, FlxG.width, "OYNADIĞIN İÇİN TEŞEKKÜRLER");
		thanksText.setFormat(Paths.font("Avgardd.ttf"), 56, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		thanksText.borderSize = 3;
		thanksText.antialiasing = ClientPrefs.data.antialiasing;
		mainGroup.add(thanksText);

		maxScroll = currentY + thanksText.height + 100 - FlxG.height;
		if (maxScroll < 0)
			maxScroll = 0;

		var scrollbarPadding:Float = 10;
		scrollbarTrackHeight = FlxG.height - scrollbarPadding * 2;
		scrollbarThumbHeight = Math.max(40, scrollbarTrackHeight * (FlxG.height / (maxScroll + FlxG.height)));

		scrollbarBG = new FlxSprite(FlxG.width - 14, scrollbarPadding).makeGraphic(6, Std.int(scrollbarTrackHeight), FlxColor.fromRGB(80, 80, 80));
		scrollbarBG.scrollFactor.set();
		scrollbarBG.alpha = 0.4;
		add(scrollbarBG);

		scrollbarThumb = new FlxSprite(FlxG.width - 16, scrollbarPadding).makeGraphic(10, Std.int(scrollbarThumbHeight), FlxColor.WHITE);
		scrollbarThumb.scrollFactor.set();
		scrollbarThumb.alpha = 0.8;
		add(scrollbarThumb);

		scrollbarAlpha = 1.0;
		scrollbarTargetAlpha = 1.0;
		lastScrollY = 0;

		FlxG.mouse.visible = true;

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		var scrolling:Bool = false;

		if (FlxG.mouse.wheel != 0)
		{
			targetScrollY -= FlxG.mouse.wheel * scrollSpeed;
			scrolling = true;
		}

		if (controls.UI_DOWN)
		{
			targetScrollY += scrollSpeed * elapsed * 10;
			scrolling = true;
		}
		if (controls.UI_UP)
		{
			targetScrollY -= scrollSpeed * elapsed * 10;
			scrolling = true;
		}

		if (targetScrollY < 0)
			targetScrollY = 0;
		if (targetScrollY > maxScroll)
			targetScrollY = maxScroll;

		scrollY += (targetScrollY - scrollY) * smoothFactor * elapsed;

		mainGroup.y = -scrollY;

		if (scrolling || Math.abs(scrollY - lastScrollY) > 0.5)
		{
			scrollbarIdleTimer = 0;
			scrollbarTargetAlpha = 1.0;
		}
		else
		{
			scrollbarIdleTimer += elapsed;
			if (scrollbarIdleTimer >= scrollbarFadeDelay)
				scrollbarTargetAlpha = 0.0;
		}
		lastScrollY = scrollY;

		scrollbarAlpha += (scrollbarTargetAlpha - scrollbarAlpha) * 5.0 * elapsed;

		scrollbarBG.alpha = 0.4 * scrollbarAlpha;
		scrollbarThumb.alpha = 0.8 * scrollbarAlpha;

		if (maxScroll > 0)
		{
			var scrollRatio:Float = scrollY / maxScroll;
			var scrollbarPadding:Float = 10;
			var thumbTravel:Float = scrollbarTrackHeight - scrollbarThumbHeight;
			scrollbarThumb.y = scrollbarPadding + (scrollRatio * thumbTravel);
		}

		if (bumpReturning)
		{
			var returnSpeed:Float = 6.0;
			var diff:Float = petLogo.scale.x - petBaseScale;
			if (diff > 0.001)
			{
				var newScale:Float = petLogo.scale.x - diff * returnSpeed * elapsed;
				if (newScale <= petBaseScale)
				{
					newScale = petBaseScale;
					bumpReturning = false;
				}
				petLogo.scale.set(newScale, newScale);
			}
			else
			{
				petLogo.scale.set(petBaseScale, petBaseScale);
				bumpReturning = false;
			}
		}

		var mouseX:Float = FlxG.mouse.getScreenPosition().x;
		var mouseY:Float = FlxG.mouse.getScreenPosition().y;
		hoveredCredit = -1;

		for (i in 0...creditIcons.length)
		{
			var ci = creditIcons[i];
			var spr = ci.sprite;
			var realX:Float = spr.x;
			var realY:Float = spr.y + mainGroup.y;

			if (realY > -120 && realY < FlxG.height + 120)
			{
				if (mouseX >= realX && mouseX <= realX + 110
					&& mouseY >= realY && mouseY <= realY + 110)
				{
					hoveredCredit = i;
				}

				if (ci.bumping)
				{
					var returnSpd:Float = 6.0;
					var d:Float = spr.scale.x - ci.baseScale;
					if (d > 0.001)
					{
						var ns:Float = spr.scale.x - d * returnSpd * elapsed;
						if (ns <= ci.baseScale)
						{
							ns = ci.baseScale;
							ci.bumping = false;
						}
						spr.scale.set(ns, ns);
					}
					else
					{
						spr.scale.set(ci.baseScale, ci.baseScale);
						ci.bumping = false;
					}
				}
			}
		}

		if (FlxG.mouse.justPressed && hoveredCredit != -1)
		{
			var link = creditIcons[hoveredCredit].link;
			if (link != null && link.length > 0)
				CoolUtil.browserLoad(link);
		}

		if (FlxG.sound.music != null && FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}

		super.update(elapsed);
	}

	override function beatHit()
	{
		super.beatHit();

		if (petLogo != null)
		{
			petLogo.scale.set(petBaseScale * bumpScale, petBaseScale * bumpScale);
			bumpReturning = true;
		}

		if (hoveredCredit != -1 && hoveredCredit < creditIcons.length)
		{
			var ci = creditIcons[hoveredCredit];
			if (ci != null && ci.sprite != null)
			{
				ci.sprite.scale.set(ci.baseScale * bumpScale, ci.baseScale * bumpScale);
				ci.bumping = true;
			}
		}
	}
}