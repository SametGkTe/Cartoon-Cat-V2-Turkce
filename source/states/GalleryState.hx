package states;

import backend.Paths;
import backend.ClientPrefs;
import backend.MusicBeatState;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

typedef ExtrasItem = {
	var fileName:String;
	var title:String;
	var description:String;
}

class GalleryState extends MusicBeatState {
	var galleryItems:Array<ExtrasItem> = [
		{
			fileName: "cute",
			title: "Cute.",
			description: "Dadluş bir Bf",
		},
		{
			fileName: "fair",
			title: "fair",
			description: "fair",
		},
		{
			fileName: "the-disaster",
			title: "felaket",
			description: "Büyük bir felaket",
		},
		{
			fileName: "thepain",
			title: "Büyük bir acı",
			description: "",
		},
		{
			fileName: "altyazikaldirma",
			title: "Altyazılar.",
			description: "Samet Videoların Altyazısını Kaldırmaya Çalışıyor 4K Full HD Apk",
		},
		{
			fileName: "editnerde",
			title: "Emin Edit Nerde",
			description: "eminbeydeneditörolmamatavsiyesi",
		},
		{
			fileName: "nedemekyok",
			title: "NE DEMEK YOK",
			description: "salakenginedosyayibulamiyor",
		}
	];

	var curSelected:Int = 0;
	var disableInput:Bool = true;

	var menuBg:FlxSprite;
	var galleryBg:FlxSprite;
	var currentImage:FlxSprite;
	var arrowLeft:FlxSprite;
	var arrowRight:FlxSprite;
	var titleText:FlxText;
	var descText:FlxText;
	var pageText:FlxText;

	var fontPath:String;

	var imageAreaX:Float = 140;
	var imageAreaY:Float = 80;
	var imageAreaW:Float = 700;
	var imageAreaH:Float = 450;

	override function create() {
		fontPath = Paths.font("vcr.ttf");

		// En arkada menudesat
		menuBg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBg.scrollFactor.set(0, 0);
		menuBg.screenCenter();
		menuBg.color = FlxColor.fromRGB(40, 40, 60);
		add(menuBg);

		galleryBg = new FlxSprite().loadGraphic(Paths.image('gallery/bg'));
		galleryBg.scrollFactor.set(0, 0);
		galleryBg.scale.set(0.8, 0.8); // istedigin boyuta ayarla
		galleryBg.updateHitbox();
		galleryBg.screenCenter();
		galleryBg.antialiasing = ClientPrefs.data.antialiasing;
		add(galleryBg);
		
		// Gösterilecek resim
		currentImage = new FlxSprite();
		currentImage.scrollFactor.set(0, 0);
		currentImage.antialiasing = ClientPrefs.data.antialiasing;
		add(currentImage);

		// Sol ok (zaten sola bakiyor, flip yok)
		arrowLeft = new FlxSprite();
		arrowLeft.frames = Paths.getSparrowAtlas('gallery/flecha');
		arrowLeft.animation.addByPrefix('idle', 'flecha no select', 24, true);
		arrowLeft.animation.addByPrefix('press', 'flecha select', 24, false);
		arrowLeft.animation.play('idle');
		arrowLeft.scrollFactor.set(0, 0);
		arrowLeft.antialiasing = ClientPrefs.data.antialiasing;
		arrowLeft.x = 40;
		arrowLeft.screenCenter(Y);
		add(arrowLeft);

		// Sag ok (flipX ile saga cevir)
		arrowRight = new FlxSprite();
		arrowRight.frames = Paths.getSparrowAtlas('gallery/flecha');
		arrowRight.animation.addByPrefix('idle', 'flecha no select', 24, true);
		arrowRight.animation.addByPrefix('press', 'flecha select', 24, false);
		arrowRight.animation.play('idle');
		arrowRight.scrollFactor.set(0, 0);
		arrowRight.antialiasing = ClientPrefs.data.antialiasing;
		arrowRight.flipX = true;
		arrowRight.x = FlxG.width - arrowRight.width - 40;
		arrowRight.screenCenter(Y);
		add(arrowRight);

		// Title - resmin üstünde
		titleText = new FlxText(0, 30, FlxG.width, "");
		titleText.setFormat(fontPath, 32, FlxColor.WHITE, CENTER);
		titleText.scrollFactor.set(0, 0);
		titleText.borderStyle = OUTLINE;
		titleText.borderColor = FlxColor.BLACK;
		titleText.borderSize = 2;
		add(titleText);

		// Description - ekranın en altında
		descText = new FlxText(40, FlxG.height - 60, FlxG.width - 80, "");
		descText.setFormat(fontPath, 18, FlxColor.fromRGB(200, 200, 200), CENTER);
		descText.scrollFactor.set(0, 0);
		descText.borderStyle = OUTLINE;
		descText.borderColor = FlxColor.BLACK;
		descText.borderSize = 1;
		add(descText);

		// Sayfa numarası
		pageText = new FlxText(0, FlxG.height - 30, FlxG.width, "");
		pageText.setFormat(fontPath, 16, FlxColor.fromRGB(150, 150, 150), CENTER);
		pageText.scrollFactor.set(0, 0);
		add(pageText);

		// İlk resmi yükle
		loadCurrentImage();

		// Giriş animasyonu
		currentImage.alpha = 0;
		titleText.alpha = 0;
		descText.alpha = 0;
		pageText.alpha = 0;
		arrowLeft.alpha = 0;
		arrowRight.alpha = 0;

		FlxTween.tween(currentImage, {alpha: 1}, 0.4, {ease: FlxEase.sineOut, startDelay: 0.1});
		FlxTween.tween(titleText, {alpha: 1}, 0.4, {ease: FlxEase.sineOut, startDelay: 0.15});
		FlxTween.tween(descText, {alpha: 1}, 0.4, {ease: FlxEase.sineOut, startDelay: 0.2});
		FlxTween.tween(pageText, {alpha: 1}, 0.4, {ease: FlxEase.sineOut, startDelay: 0.25});
		FlxTween.tween(arrowLeft, {alpha: 1}, 0.4, {ease: FlxEase.sineOut, startDelay: 0.3});
		FlxTween.tween(arrowRight, {alpha: 1}, 0.4, {
			ease: FlxEase.sineOut,
			startDelay: 0.35,
			onComplete: function(twn:FlxTween) {
				disableInput = false;
			}
		});

		// Müzik
		if (FlxG.sound.music == null || !FlxG.sound.music.playing)
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.5);

		super.create();
	}

	function loadCurrentImage() {
		if (galleryItems.length == 0) return;

		var item = galleryItems[curSelected];

		// Resmi yükle
		try {
			currentImage.loadGraphic(Paths.image('gallery/images/' + item.fileName));
		} catch (e) {
			currentImage.makeGraphic(400, 300, FlxColor.fromRGB(40, 40, 40));
		}

		// Resmi bg'nin içine sığdır
		// bg'nin konumunu al
		var bgX = galleryBg.x;
		var bgY = galleryBg.y;

		// Resim alanı bg'ye göre hesapla
		var areaX = bgX + imageAreaX;
		var areaY = bgY + imageAreaY;

		// Scale hesapla - alana sığdır
		var scaleX = imageAreaW / currentImage.frameWidth;
		var scaleY = imageAreaH / currentImage.frameHeight;
		var finalScale = Math.min(scaleX, scaleY);

		currentImage.scale.set(finalScale, finalScale);
		currentImage.updateHitbox();

		// Alanın ortasına yerleştir
		currentImage.x = areaX + (imageAreaW - currentImage.width) / 2 + 20;
		currentImage.y = areaY + (imageAreaH - currentImage.height) / 2;

		// Metinleri güncelle
		titleText.text = item.title;
		descText.text = item.description;
		pageText.text = (curSelected + 1) + " / " + galleryItems.length;
	}

	function changeImage(direction:Int) {
		curSelected += direction;

		// Wrap around
		if (curSelected < 0) curSelected = galleryItems.length - 1;
		if (curSelected >= galleryItems.length) curSelected = 0;

		FlxG.sound.play(Paths.sound('scrollMenu'));

		// Geçiş animasyonu
		FlxTween.cancelTweensOf(currentImage);

		var slideDir:Float = direction > 0 ? -50 : 50;

		FlxTween.tween(currentImage, {alpha: 0}, 0.15, {
			ease: FlxEase.sineIn,
			onComplete: function(twn:FlxTween) {
				loadCurrentImage();
				currentImage.alpha = 0;

				// Yeni resim karşı yönden gelsin
				var targetX = currentImage.x;
				currentImage.x = targetX - slideDir;

				FlxTween.tween(currentImage, {alpha: 1, x: targetX}, 0.25, {ease: FlxEase.sineOut});
			}
		});

		// Title ve desc geçişi
		FlxTween.cancelTweensOf(titleText);
		FlxTween.cancelTweensOf(descText);
		FlxTween.tween(titleText, {alpha: 0}, 0.1, {
			onComplete: function(twn:FlxTween) {
				FlxTween.tween(titleText, {alpha: 1}, 0.2);
			}
		});
		FlxTween.tween(descText, {alpha: 0}, 0.1, {
			onComplete: function(twn:FlxTween) {
				FlxTween.tween(descText, {alpha: 1}, 0.2);
			}
		});
	}

	override function update(elapsed:Float) {
		if (!disableInput) {
			// Geri dön
			if (controls.BACK) {
				FlxG.sound.play(Paths.sound('cancelMenu'));
				disableInput = true;
				FlxTween.tween(currentImage, {alpha: 0}, 0.3);
				FlxTween.tween(titleText, {alpha: 0}, 0.3);
				FlxTween.tween(descText, {alpha: 0}, 0.3);
				FlxTween.tween(pageText, {alpha: 0}, 0.3);
				FlxTween.tween(arrowLeft, {alpha: 0}, 0.3);
				FlxTween.tween(arrowRight, {alpha: 0}, 0.3, {
					onComplete: function(twn:FlxTween) {
						FlxG.switchState(new states.MainMenuState());
					}
				});
				return;
			}

			// Sol
			if (controls.UI_LEFT_P) {
				arrowLeft.animation.play('press', true);
				changeImage(-1);
			}
			if (controls.UI_LEFT_R) {
				arrowLeft.animation.play('idle', true);
			}

			// Sağ
			if (controls.UI_RIGHT_P) {
				arrowRight.animation.play('press', true);
				changeImage(1);
			}
			if (controls.UI_RIGHT_R) {
				arrowRight.animation.play('idle', true);
			}
		}

		super.update(elapsed);
	}

	override function destroy() {
		super.destroy();
	}
}