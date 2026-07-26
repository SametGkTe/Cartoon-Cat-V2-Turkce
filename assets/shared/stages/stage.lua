function onCreate()
	makeLuaSprite('bgg', 'cc/park/parque', -940, -150);
        addLuaSprite('bgg', false);
        scaleObject('bgg', 2.5, 2.5);

		makeAnimatedLuaSprite('pibe','cc/park/putas-del-bg', -311.1,420.7)
        addAnimationByPrefix('pibe', 'idle', 'decide', 12, true);
        scaleObject('pibe',0.67, 0.67)
        addLuaSprite('pibe', false)

		makeAnimatedLuaSprite('piba','cc/park/putas-del-bg', -164, 392)
        addAnimationByPrefix('piba', 'idle', 'tipa', 12, true);
        scaleObject('piba',1, 1)
        addLuaSprite('piba', false)

		makeAnimatedLuaSprite('perrodecaricatura','cc/park/putas-del-bg', 1170,355)
        addAnimationByPrefix('perrodecaricatura', 'idle', 'perro', 12, true);
        scaleObject('perrodecaricatura',1, 1)
        addLuaSprite('perrodecaricatura', false)

		makeAnimatedLuaSprite('luna','cc/park/putas-del-bg', 1085,520)
        addAnimationByPrefix('luna', 'idle', 'luna', 12, true);
        scaleObject('luna',1, 1)
        addLuaSprite('luna', false)

		makeAnimatedLuaSprite('piba random','cc/park/putas-del-bg', 7.3,407.3)
        addAnimationByPrefix('piba random', 'idle', 'melody', 12, true);
        scaleObject('piba random',1, 1)
        addLuaSprite('piba random', false)

		makeAnimatedLuaSprite('efecto','cc/park/efecto_toon-swing',-35,-25)
        addAnimationByPrefix('efecto', 'static', 'efectp', 24, true);
        setObjectCamera('efecto','other')
        setProperty('efecto.alpha',0.5)
        scaleObject('efecto',2.8, 2.8)
        addLuaSprite('efecto', true)
end
function onCreatePost()
	setProperty('camHUD.alpha',0)
	removeLuaSprite('static', true)
	removeLuaSprite('vignetteog', true)
end
function onStepHit()
	if curStep == 1112 then
	removeLuaSprite('bgg', true)
	removeLuaSprite('pibe', true)
	removeLuaSprite('piba', true)
	removeLuaSprite('luna', true)
	removeLuaSprite('piba random', true)
	removeLuaSprite('perrodecaricatura', true)
	setProperty('gfGroup.visible', false)
	elseif curStep == 1144 then
		doTweenAlpha('chauGATO', 'dadGroup', 0.00001, 3, 'linear')
	elseif curStep == 1208 then
		doTweenAlpha('chauBF', 'boyfriendGroup', 0.00001, 3, 'linear')
	elseif curStep == 1240 then
		setProperty('camHUD.visible', false)
	end 
end
function onSongStart()
	doTweenAlpha('jud', 'camHUD', 1, 1, 'linear')
end