local VideoStart=false
function onCreatePost()
	setProperty('camHUD.visible', false)
end
function onStepHit()
	if curStep == 32 then
setProperty('camHUD.visible', true)
setProperty('iconP1.visible', false)
setProperty('iconP2.visible', false)
setProperty('healthBar.visible', false)
	end
	if curStep == 98 then
function onUpdate(elapsed)
	setProperty('camHUD.visible', false)
	setPropertyFromClass('PlayState', 'instance.vocals.volume', 0)
setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
setPropertyFromClass('PlayState', 'instance.generatedMusic', false)
setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
end
function onCreatePost()
	local camHUD = getObject("camHUD")
	if camHUD then
	setObjectOrder('videoSprite', 100000, camHUD)
	else
	print("HUD object not found.")
	end
	end
	startVideo('ssstwitter.com_1712652716020')
	setProperty('inCutscene', false)
	return Function_Continue
end
end