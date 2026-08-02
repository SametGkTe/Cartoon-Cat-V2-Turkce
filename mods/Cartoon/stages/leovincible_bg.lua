function onCreate()
makeLuaSprite("holaperras", "cc/leovincible/bg1", -373, -118)
addLuaSprite('holaperras', false)
scaleObject('holaperras', 2.5, 2.5)

makeLuaSprite("overlei", "cc/leovincible/bg2", 0, 0)
addLuaSprite('overlei', false)
setObjectCamera('overlei', 'other')
scaleObject('overlei', 2.02, 2.34)
setProperty('overlei.antialiasing', false)

makeLuaSprite("ojos", "cc/leovincible/eyes", 100, 0)
addLuaSprite('ojos', false)
scaleObject('ojos', 2.7, 2.5)
setLuaSpriteScrollFactor('ojos',0.2,0.8)
setProperty('ojos.alpha', 0.0000001)
if not lowQuality then
makeLuaSprite("frenteojos", "cc/leovincible/fronteyes", -883, 70)
addLuaSprite('frenteojos', true)
scaleObject('frenteojos', 4.8, 4.6)
setLuaSpriteScrollFactor('frenteojos',0.2,0.8)
setProperty('frenteojos.alpha', 0.0000001)
end

makeLuaSprite('roj', 'roj', 0, 0);
    addLuaSprite('roj', true);
	setObjectCamera('roj', 'other')
	setBlendMode('roj', 'multiply')
    setLuaSpriteScrollFactor('roj',0,0)
    setProperty('roj.scale.x',3.7)
    setProperty('roj.scale.y',3.8)
	setProperty('roj.alpha', 0.0000001)
end
function onCreatePost()
	setProperty('vignetteog.alpha', 0.7)
	-- dad
	noteTweenX("Note2", 2, 976, 0.0001, "sineInOut")
	noteTweenX("Note3", 3, 1088, 0.0001, "sineInOut")
	-- bf
	noteTweenX("Note7", 4, 410, 0.0001, "sineInOut") -- Izquierda
	noteTweenX("Note4", 5, 526, 0.0001, "sineInOut") -- Abajo
	noteTweenX("Note5", 6, 644, 0.0001, "sineInOut") -- Arriba
	noteTweenX("Note6", 7, 757, 0.0001, "sineInOut") -- Derecha
	end
	function onStepHit()
		if curStep == 2 then
		noteTweenAlpha("Note0", 0, 0.5, 1, "sineInOut")
	    noteTweenAlpha("Note1", 1, 0.5, 1, "sineInOut")
		noteTweenAlpha("Note2", 2, 0.5, 1, "sineInOut")
	    noteTweenAlpha("Note3", 3, 0.5, 1, "sineInOut")
		elseif curStep == 1248 then
			setProperty('holaperras.alpha', 0)
			setProperty('white.alpha', 0.3)
			setProperty('roj.alpha', 1)
			setProperty('ojos.alpha', 1)
			setProperty('frenteojos.alpha', 1)
			doTweenX('ojos', 'ojos', -1500, 43, 'linear')
			doTweenX('frenteojos', 'frenteojos', 1500, 55, 'linear')
		elseif curStep == 1504 then
			setProperty('white.alpha', 1)
			removeLuaSprite('roj', true)
			removeLuaSprite('ojos', true)
			removeLuaSprite('frenteojos', true)
			setProperty('holaperras.alpha', 1)
		elseif curStep == 1824 then
			doTweenAlpha("chaou", "camGame", 0, 4, "linear")
		end
	end