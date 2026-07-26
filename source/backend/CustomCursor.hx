package backend;

import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class CustomCursor extends FlxTypedGroup<FlxSprite>
{
    public var cursorDefault:FlxSprite;
    public var cursorPressed:FlxSprite;
    public var cursorCamera:FlxCamera;

    public function new()
    {
        super();

        // Cursor için özel kamera oluştur (scroll etmesin)
        cursorCamera = new FlxCamera();
        cursorCamera.bgColor = 0x00000000; // Transparan arka plan
        FlxG.cameras.add(cursorCamera, false);

        // Default cursor
        cursorDefault = new FlxSprite();
        cursorDefault.loadGraphic(Paths.image('cursor/cursor-default'));
        cursorDefault.antialiasing = ClientPrefs.data.antialiasing;
        cursorDefault.scrollFactor.set(0, 0);
        cursorDefault.updateHitbox();
        cursorDefault.cameras = [cursorCamera];
        add(cursorDefault);

        // Pressed cursor
        cursorPressed = new FlxSprite();
        cursorPressed.loadGraphic(Paths.image('cursor/cursor-pressed'));
        cursorPressed.antialiasing = ClientPrefs.data.antialiasing;
        cursorPressed.scrollFactor.set(0, 0);
        cursorPressed.updateHitbox();
        cursorPressed.visible = false;
        cursorPressed.cameras = [cursorCamera];
        add(cursorPressed);

        // Sistem imlecini gizle
        FlxG.mouse.visible = false;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        // Ekran koordinatlarını kullan (kamera scroll'undan etkilenmez)
        var mouseX = FlxG.mouse.screenX;
        var mouseY = FlxG.mouse.screenY;

        cursorDefault.setPosition(mouseX, mouseY);
        cursorPressed.setPosition(mouseX, mouseY);

        // Tıklama kontrolü
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
        cursorDefault.visible = true;
        cursorPressed.visible = false;
        FlxG.mouse.visible = false;
    }

    public function hideCursor()
    {
        cursorDefault.visible = false;
        cursorPressed.visible = false;
    }

    override public function destroy()
    {
        if (cursorCamera != null)
        {
            FlxG.cameras.remove(cursorCamera);
        }
        FlxG.mouse.visible = true;
        super.destroy();
    }
}