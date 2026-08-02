function onEvent(n,v1,v2)
if n == 'White Screen Flash' then
setProperty('flash.alpha',1)
doTweenAlpha('flTw','flash',0,v2,'linear')
end
end
function onCreate()
    makeLuaSprite('flash', '', 0, 0);
    makeGraphic('flash',680,340,'ffffff')
    addLuaSprite('flash', false);
    setLuaSpriteScrollFactor('flash',0,0)
    setProperty('flash.scale.x',3)
    setProperty('flash.scale.y',3.4)
    setObjectOrder('flash', 0);
    setProperty('flash.alpha',0)
    runHaxeCode([[
        FlxG.cameras.remove(game.camOther,false);
        FlxG.cameras.remove(game.camHUD,false);
        var camBAR = new FlxCamera();
        camBAR.bgColor = 0x00;
        setVar('camBAR',camBAR);
        game.getLuaObject('flash').camera = camBAR;
        FlxG.cameras.add(camBAR,false);
        FlxG.cameras.add(game.camHUD,false);
        FlxG.cameras.add(game.camOther,false);
    ]])
end