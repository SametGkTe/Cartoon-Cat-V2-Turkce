function onCreate()
	makeLuaSprite('bgsh', 'sirenforest/beje', -675, 675);
	scaleObject('bgsh', 2.55, 2.55)
	addLuaSprite('bgsh', false);

	makeAnimatedLuaSprite('corneta','sirenforest/corneta', 1510, 1840)
addAnimationByPrefix('corneta', 'idle', 'boombox animation', 8, true);
scaleObject('corneta',1.5, 1.5)
addLuaSprite('corneta', false)

	makeLuaSprite('sh', 'sirenforest/dialoguesh', -70, 600);
	setScrollFactor('sh', 0.9, 0.9);
	scaleObject('sh',2.55, 2.55)
	addLuaSprite('sh', true);
end

function onCreatePost()
	setProperty('sh.alpha', 0.00001)
	setProperty('camZooming', true)
		doTweenColor('dad', 'dadGroup', '94AAFF', 0.1, 'linear')
		doTweenColor('boyfriend', 'boyfriendGroup', '94AAFF', 0.1, 'linear')
		doTweenColor('gf', 'gfGroup', '94AAFF', 0.1, 'linear')
end

function onUpdate(elapsed)
	for i = 0,3 do
		setPropertyFromGroup('strumLineNotes', i, 'alpha', 0) 
	end
	if mustHitSection then
		setProperty('defaultCamZoom', 1.2)
	elseif not mustHitSection then
		setProperty('defaultCamZoom', 0.55)
	end
end

function onStepHit()
	if curStep == 1024 then 
		doTweenAlpha('shappear', 'sh', 1, 10, 'linear')
		setProperty('bgsh.alpha', 0.00001)
		setProperty('dadGroup.alpha', 0.00001)
		setProperty('boyfriendGroup.alpha', 0.00001)
		setProperty('gfGroup.alpha', 0.00001)
		setProperty('corneta.alpha', 0.00001)
		doTweenAlpha('juddd', 'camHUD', 0, 0.07, 'linear')
	end
	if curStep == 1142 then 
		removeLuaSprite('sh', true)
	end
	if curStep == 1152 then 
		setProperty('bgsh.alpha', 1)
		setProperty('dadGroup.alpha', 1)
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('gfGroup.alpha', 1)
		setProperty('corneta.alpha', 1)
		setProperty('camHUD.alpha', 1)
end
end