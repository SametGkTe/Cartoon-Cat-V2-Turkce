package debug;

import flixel.FlxG;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.system.System;
import openfl.utils.Assets;
import openfl.text.Font;

class FPSCounter extends TextField
{
	public var currentFPS(default, null):Int = 0;
	public var memoryMegas(get, never):Float;
	public var memoryPeak:Float = 0;

	@:noCompletion private var times:Array<Float>;
	private var fontName:String = "_sans";

	public function new(x:Float = 5, y:Float = 5, color:Int = 0xFFFFFF)
	{
		super();

		this.x = x;
		this.y = y;

		selectable = false;
		mouseEnabled = false;
		multiline = false;
		wordWrap = false;
		autoSize = LEFT;

		try
		{
			var font:Font = Assets.getFont("assets/fonts/text.ttf");
			if (font != null)
			{
				fontName = font.fontName;
				embedFonts = true;
			}
		}
		catch (e:Dynamic)
		{
			fontName = "_sans";
			embedFonts = false;
		}

		defaultTextFormat = new TextFormat(fontName, 4, color);
		textColor = 0xFFFFFFFF;
		text = "FPS: 0 - Bellek: 0 MB (0 MB En Yüksek)";
		setTextFormat(defaultTextFormat);

		times = [];
	}

	private override function __enterFrame(deltaTime:Float):Void
	{
		final now:Float = haxe.Timer.stamp() * 1000;
		times.push(now);

		while (times.length > 0 && times[0] < now - 1000)
			times.shift();

		currentFPS = (times.length < FlxG.updateFramerate) ? times.length : FlxG.updateFramerate;

		var currentMemory:Float = System.totalMemory / 1000000;
		if (currentMemory > memoryPeak)
			memoryPeak = currentMemory;

		updateText();
	}

	public dynamic function updateText():Void
	{
		var memoryText:String = formatMemory(System.totalMemory / 1000000);
		var peakText:String = formatMemory(memoryPeak);

		text = 'FPS: ' + currentFPS + ' - Bellek: ' + memoryText + ' (' + peakText + ' En Yüksek)';

		if (currentFPS <= 30)
			textColor = 0xFFFF0000;
		else
			textColor = 0xFFFFFFFF;

		setTextFormat(new TextFormat(fontName, 10, textColor));
	}

	private function formatMemory(m:Float):String
	{
		var value:Float = 0;
		var measure:String = "MB";

		if (m > 1024)
		{
			value = round(m / 1024, 2);
			measure = "GB";
		}
		else
		{
			value = round(m, 1);
			measure = "MB";
		}

		return Std.string(value) + " " + measure;
	}

	private function round(x:Float, n:Int = 0):Float
	{
		var p:Float = Math.pow(10, n);
		x *= p;
		if (x >= 0)
			x = Math.floor(x + 0.5);
		else
			x = Math.ceil(x - 0.5);
		return x / p;
	}

	inline function get_memoryMegas():Float
	{
		return cast(System.totalMemory, UInt);
	}
}