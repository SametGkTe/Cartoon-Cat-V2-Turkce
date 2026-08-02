local VideoStart=false
function onCreatePost()
	if songName == 'Fright Fest' then
		if not lowQuality then
	makeLuaSprite("vignetteog", "cc/cc_go", -80, -50)
	setObjectCamera('vignetteog', 'hud')
	addLuaSprite('vignetteog', false)
	scaleObject('vignetteog', 2.2, 2.2)
	setObjectOrder('vignetteog',0)
	setProperty('vignetteog.alpha',0.15)
	setProperty('vignetteog.antialiasing',false)
		end
	makeLuaSprite('bflash', '', 0, 0);
	makeGraphic('bflash',680,340,'000000')
	addLuaSprite('bflash', false);
	setObjectCamera('bflash','hud')
	setLuaSpriteScrollFactor('bflash',0,0)
	setProperty('bflash.scale.x',3)
	setProperty('bflash.scale.y',3.4)
	setObjectOrder('bflash', 0);
	setProperty('bflash.alpha',0)
end
end
	function onStepHit()
		if curStep == 528 then
			setProperty('vignetteog.alpha',0.9)
			setProperty('bflash.alpha',1)
			doTweenAlpha('flTtw','bflash',0.14,16,'linear')
		end
		if curStep == 909 then
		doTweenAlpha('si','camGame',0,3,'linear')
	end
	if curStep == 944 then
		setProperty('camGame.alpha',1)
	end
	if curStep == 1239 then
		doTweenAlpha('flTtw','bflash',1,0.5,'easeIn')
	end
	if curStep == 1246 then
	function onCreatePost()
		local camHUD = getObject("camHUD")
		if camHUD then
		setObjectOrder('videoSprite', 100000, camHUD)
		else
		print("HUD object not found.")
		end
		end
		startVideo('fright_fest_ending')
		setProperty('inCutscene', false)
		return Function_Continue
	end		
end