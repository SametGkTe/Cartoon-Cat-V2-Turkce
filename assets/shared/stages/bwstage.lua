function onCreate()
	makeLuaSprite('b','cc/bwstage/bg_restored(nose)',-550, -570)
	addLuaSprite('b')
	scaleObject('b', 3.3, 3.3)
	setLuaSpriteScrollFactor('b', 0.5, 0.5)

	makeAnimatedLuaSprite('partes','cc/bwstage/partes', -550, -370)
    addAnimationByPrefix('partes', 'idle', 'partes', 6, true);
    scaleObject('partes',5.5, 5)
    addLuaSprite('partes', false)
	setLuaSpriteScrollFactor('partes', 0.7, 0.7)

	makeLuaSprite('puente','cc/bwstage/bg5',-670, -570)
	addLuaSprite('puente')
	scaleObject('puente', 2.7, 2.7)

if not lowQuality then
	makeLuaSprite('nose','cc/bwstage/bg1',-670, -570)
	addLuaSprite('nose', true)
	scaleObject('nose', 2.7, 2.7)
	setProperty('nose.antialiasing', false)
end
if not hideHud then
makeLuaSprite('iniciodeicon','cc/bwstage/culo', 0, 603)
	scaleObject('iniciodeicon', 1.36, 1.36)
	setObjectCamera('iniciodeicon', 'hud')
	setObjectOrder('iniciodeicon',87)
	addLuaSprite('iniciodeicon', true)
	setProperty('iniciodeicon.antialiasing', false)

	makeLuaSprite('iconolargo','cc/bwstage/largo', 205, 603)
	scaleObject('iconolargo', 1.25, 1.36)
	setObjectCamera('iconolargo', 'hud')
	setObjectOrder('iconolargo',87)
	addLuaSprite('iconolargo', true)
	setProperty('iconolargo.antialiasing', false)

	makeLuaSprite('iconXXD','icons/a', 795, 600)
	scaleObject('iconXXD', 0.99, 0.99)
	setObjectCamera('iconXXD', 'hud')
	setObjectOrder('iconXXD',87)
	addLuaSprite('iconXXD', true)
	setProperty('iconXXD.flipX', true)


	makeAnimatedLuaSprite('iconXD','icons/pene', 685, 597)
    addAnimationByPrefix('iconXD', 'normal', 'pene', 4, false);
	setObjectCamera('iconXD', 'hud')
	setObjectOrder('iconXD',87)
    scaleObject('iconXD',0.99, 0.99)
    addLuaSprite('iconXD', true)
end
end
	function onUpdate(elapsed)
		scaleObject('iconXXD', 0.99, 0.99)
		scaleObject('iconXD', 0.99, 0.99)
	for i = 0,3 do
		setPropertyFromGroup('strumLineNotes', i, 'alpha', 0) 
	end
	if mustHitSection then
		setProperty('defaultCamZoom', 1.2)
	elseif not mustHitSection then
		setProperty('defaultCamZoom', 0.55)
	end
end
function onCreatePost()
	if version >= '0.7' then
		setObjectOrder('iconXXD',55)
		setObjectOrder('iconXD',56)
		setObjectOrder('iconolargo',24)
		setObjectOrder('iniciodeicon',25)
		setObjectOrder('scoreCC',60)
end
	setProperty('iconP2.visible', false)
	setProperty('iconP1.visible', false)
	if downscroll then
		setProperty('iconXXD.y', 40)
		setProperty('iconXD.y', 37)
		setProperty('iniciodeicon.y', 43)
		setProperty('iconolargo.y', 43)
	end
end
function onBeatHit()
	if curBeat % 1 == 0 then
	scaleObject('iconXXD', 1.1, 1.1)
	scaleObject('iconXD', 1.1, 1.1)
	end
	end
	function onStepHit()
		if curStep == 64 then
			doTweenX('scaleX', 'iconolargo.scale', 0.25, 200, 'linear')
			doTweenX('xxxxx', 'iconolargo', 4, 200, 'linear')
			doTweenX('afdwva', 'iconXD', 280, 200, 'linear')
			doTweenX('adwva', 'iconXXD', 395, 200, 'linear')
		elseif curStep == 1518 then
			addAnimationByPrefix('iconXD', 'poca vida', 'sexo', 4, true);
			objectPlayAnimation('iconXD', 'poca vida', true)
		end
	end
	-- zJosiz