function onCreatePost()

makeAnimatedLuaSprite('cd','characters/CD_remake_animations',0,0)
addAnimationByPrefix('cd', 'fall', 'cd animation falling', 24, false);
addAnimationByPrefix('cd','loop','CD Remake idle',24,true)
objectPlayAnimation('cd','loop',false);
scaleObject('cd',1.6, 1.6)
setProperty('cd.alpha',0)
addLuaSprite('cd')

	if not lowQuality then
	setObjectOrder('vignetteog',0.8)
	
	makeAnimatedLuaSprite('ST1','cc/static/static2',0,0)
addAnimationByPrefix('ST1', 'static', 'vine-boom', 24, true);
setObjectCamera('ST1','hud')
setProperty('ST1.alpha',0)
setProperty('ST1.antialiasing',false)
scaleObject('ST1',2.5, 2.5)
addLuaSprite('ST1')

makeAnimatedLuaSprite('ST','cc/static/static1',0,0)
addAnimationByPrefix('ST', 'static', 'vine-boom', 24, true);
setObjectCamera('ST','hud')
setProperty('ST.alpha',0)
setProperty('ST.antialiasing',false)
scaleObject('ST',2.5, 2.5)
addLuaSprite('ST')
	end
makeAnimatedLuaSprite('cd_glitch','cb_glitch',0,0)
addAnimationByPrefix('cd_glitch', 'static', 'cb', 24, true);
setObjectCamera('cd_glitch','other')
setProperty('cd_glitch.alpha',0.00001)
scaleObject('cd_glitch',1.7, 1.7)
addLuaSprite('cd_glitch')
if not lowQuality then
makeAnimatedLuaSprite('guards','cc/mallnew/guards_bg',-117,310)
addAnimationByPrefix('guards', 'idle', 'guardias reruns', 24, true);
setScrollFactor('guards', 0.90, 0.90);
setProperty('guards.alpha',0)
scaleObject('guards',1.75, 1.75)
addLuaSprite('guards', false)
end
end


function onStepHit()
	if curStep == 199 then
		setProperty('guards.alpha',1)
elseif curStep == 456 then
		doTweenAlpha('st1', 'ST1', 1, 0.3, 'linear');
elseif curStep == 461 then
		doTweenAlpha('st1', 'ST1', 0, 0.3, 'linear');
elseif curStep == 712 then
		doTweenAlpha('st1', 'ST1', 1, 0.3, 'linear');
elseif curStep == 717 then
		doTweenAlpha('st1', 'ST1', 0, 0.3, 'linear');
elseif curStep == 1104 then
	doTweenAlpha('camHUD', 'camHUD', 0, 1, 'linear');
	doTweenAlpha('camGame', 'camGame', 0, 1, 'linear');
elseif curStep == 1211 then
	doTweenAlpha('camHUD', 'camHUD', 1, 2, 'linear');
	doTweenAlpha('camGame', 'camGame', 1, 2, 'linear');
	setTextString('duracion', '- 2:48')
runHaxeCode([[game.songLength = (168000 + 1000);]])
elseif curStep == 1232 then
	setProperty('cd_glitch.alpha',1)
elseif curStep == 1236 then
	setProperty('cd_glitch.alpha',0)
elseif curStep == 1238 then
	setProperty('cd_glitch.alpha',1)
elseif curStep == 1240 then
	setProperty('cd_glitch.alpha',0)
elseif curStep == 1242 then
	setProperty('cd_glitch.alpha',1)
elseif curStep == 1246 then
	setProperty('cd_glitch.alpha',0)
elseif curStep == 1376 then
	setProperty('ST.alpha',1)
elseif curStep == 1381 then
	setProperty('ST.alpha',0)
	setProperty('cd.x', 708)
	setProperty('cd.y', -1001)
	setProperty('cd.alpha', 1)
	objectPlayAnimation('cd', 'fall', true)
elseif curStep == 1386 then
	setProperty('cd.x', 730)
	setProperty('cd.y', 320)
	objectPlayAnimation('cd', 'loop', true)
elseif curStep == 1532 then
	setProperty('ST.alpha',1)
elseif curStep == 1536 then
	setProperty('ST.alpha',0)
elseif curStep == 1552 then
	doTweenAlpha('camHUD', 'camHUD', 0, 14, 'linear');
	doTweenAlpha('camGame', 'camGame', 0, 10, 'linear');
end
end