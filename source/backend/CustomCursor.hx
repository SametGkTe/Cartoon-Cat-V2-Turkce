package backend;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;

class CustomCursor extends FlxTypedGroup<FlxSprite>
{
    public var cursorDefault:FlxSprite;
    public var cursorPressed:FlxSprite;
    public var cursorCamera:FlxCamera;
    var mousePos:FlxPoint;

    public function new()
    {
        super();

        mousePos = new FlxPoint();

        cursorCamera = new FlxCamera();
        cursorCamera.bgColor = 0x00000000;
        FlxG.cameras.add(cursorCamera, false);

        cursorDefault = new FlxSprite();
        cursorDefault.loadGraphic(Paths.image('cursor/cursor-default'));
        cursorDefault.antialiasing = ClientPrefs.data.antialiasing;
        cursorDefault.scrollFactor.set(0, 0);
        cursorDefault.updateHitbox();
        cursorDefault.cameras = [cursorCamera];
        add(cursorDefault);

        cursorPressed = new FlxSprite();
        cursorPressed.loadGraphic(Paths.image('cursor/cursor-pressed'));
        cursorPressed.antialiasing = ClientPrefs.data.antialiasing;
        cursorPressed.scrollFactor.set(0, 0);
        cursorPressed.updateHitbox();
        cursorPressed.visible = false;
        cursorPressed.cameras = [cursorCamera];
        add(cursorPressed);

        FlxG.mouse.visible = false;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        // PlayState içinde biri normal mouse'u açsa bile tekrar kapat
        FlxG.mouse.visible = false;

        // PlayState kameralarında doğru pozisyon
        FlxG.mouse.getScreenPosition(cursorCamera, mousePos);

        cursorDefault.setPosition(mousePos.x, mousePos.y);
        cursorPressed.setPosition(mousePos.x, mousePos.y);

        if (FlxG.mouse.pressed)
        {
            cursorDefault.visible = false;
            cursorPressed.visible = true;
        }
        else
        {
            cursorDefault.visible = true;
            cursorPressed.visible = false;
        }
    }

    public function showCursor()
    {
        FlxG.mouse.visible = false;
        cursorDefault.visible = true;
        cursorPressed.visible = false;
    }

    public function hideCursor()
    {
        FlxG.mouse.visible = false;
        cursorDefault.visible = false;
        cursorPressed.visible = false;
    }

    override public function destroy()
    {
        if (cursorCamera != null)
        {
            FlxG.cameras.remove(cursorCamera, true);
            cursorCamera.destroy();
            cursorCamera = null;
        }

        if (mousePos != null)
        {
            mousePos.put();
            mousePos = null;
        }

        super.destroy();
    }
}