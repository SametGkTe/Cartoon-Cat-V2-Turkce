package backend;

import flixel.FlxG;
import flixel.FlxSprite;
import backend.Paths;

class StaticOverlay extends FlxSprite
{
	var lastW:Int = -1;
	var lastH:Int = -1;

	// Büyütme çarpanı - 1.0 = tam ekran, 1.5 = %50 daha büyük, 2.0 = 2 kat büyük
	var scaleMult:Float = 1.5;

	public function new()
	{
		super(0, 0);

		frames = Paths.getSparrowAtlas('static');
		animation.addByPrefix('idle', 'static lol', 24, true);
		animation.play('idle');

		antialiasing = false;
		scrollFactor.set(0, 0);
		alpha = 0.20;

		// Psych'in memory cleanup sisteminden koru
		if (graphic != null)
		{
			graphic.persist = true;
			graphic.destroyOnNoUse = false;

			if (graphic.key != null && !Paths.dumpExclusions.contains(graphic.key))
				Paths.dumpExclusions.push(graphic.key);
		}

		resizeToScreen();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (lastW != FlxG.width || lastH != FlxG.height)
			resizeToScreen();
	}

	override public function draw():Void
	{
		// Her zaman en son kamerada çiz
		if (FlxG.cameras != null && FlxG.cameras.list != null && FlxG.cameras.list.length > 0)
			cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

		super.draw();
	}

	function resizeToScreen():Void
	{
		lastW = FlxG.width;
		lastH = FlxG.height;

		// Ekranın scaleMult katı kadar büyüt
		var newW:Int = Math.ceil(lastW * scaleMult);
		var newH:Int = Math.ceil(lastH * scaleMult);

		setGraphicSize(newW, newH);
		updateHitbox();

		// Büyütülen sprite'ı ekranda ortala (taşan kısımlar kenarlardan çıkar)
		x = (lastW - newW) / 2;
		y = (lastH - newH) / 2;
	}
}