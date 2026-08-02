function onCreate()

	makeLuaSprite('songscreen','song screens/Fright Fest',0,0)
	setObjectCamera('songscreen','other')
	scaleObject('songscreen',1.67, 1.67)
addLuaSprite('songscreen')
setProperty('camHUD.alpha',0)
runHaxeCode([[
        FlxG.cameras.remove(game.camOther,false);
        FlxG.cameras.remove(game.camHUD,false);
        var camBAR = new FlxCamera();
        camBAR.bgColor = 0x00;
        setVar('camBAR',camBAR);
        game.getLuaObject('songscreen').camera = camBAR;
        FlxG.cameras.add(camBAR,false);
        FlxG.cameras.add(game.camHUD,false);
        FlxG.cameras.add(game.camOther,false);
    ]])

	makeAnimatedLuaSprite('letrero','letrero', -420, 315)
	addAnimationByPrefix('letrero', 'intro', 'intro', 12, false);
	addLuaSprite('letrero', true);
	scaleObject('letrero',1.6, 1.6)
	setObjectCamera('letrero', 'other')
	setProperty('letrero.alpha',0)

	makeLuaText('name', 'FRIGHT FEST', 780, 180, 320)
    setTextSize('name', 100)
	scaleObject('name',0.2, 0.2)
    setObjectCamera('name', 'other')
    addLuaText('name', true)
    setTextFont('name', 'impact.ttf')
    setProperty('name.alpha', 0)

	makeLuaText('credi', 'BY Frander', 780, 180, 350)
    setTextSize('credi', 90)
	scaleObject('credi',0.2, 0.2)
    setObjectCamera('credi', 'other')
    addLuaText('credi', true)
    setTextFont('credi', 'impact.ttf')
    setProperty('credi.alpha', 0)
end
	function onSongStart()
		playAnim('letrero', 'intro', true)
		setProperty('letrero.alpha',1)
		doTweenAlpha('songscreen', 'songscreen', 0, 0.4, 'sineInOut');
doTweenAlpha('songscreen2', 'camHUD', 1, 0.4, 'sineInOut');
	end
	function onStepHit()
		if curStep == 6 then
		doTweenAlpha('name', 'name', 1, 0.3, 'linear');
		elseif curStep == 7 then
		doTweenAlpha('credi', 'credi', 1, 0.3, 'linear');
		elseif curStep == 30 then
			doTweenX('chaoletrero', 'letrero', -820, 0.8, 'backIn');
			doTweenX('name', 'name', -230, 0.8, 'backIn');
			doTweenX('credi', 'credi', -230, 0.8, 'backIn');
		elseif curStep == 40 then
			removeLuaSprite('letrero', true)
			removeLuaSprite('songscreen', true)
			removeLuaText('name', true)
			removeLuaText('credi', true)
end
end