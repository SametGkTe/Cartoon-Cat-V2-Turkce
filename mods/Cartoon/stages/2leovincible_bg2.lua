function onCreate()
makeLuaSprite("holaperras", "cc/leovincible/bg1", -370, -125)
addLuaSprite('holaperras', false)
scaleObject('holaperras', 2.5, 2.5)

makeLuaSprite("holaperras3", "cc/leovincible/a/2", -370, -125)
addLuaSprite('holaperras3', false)
scaleObject('holaperras3', 2.5, 2.5)
setProperty('holaperras3.alpha', 0)

makeLuaSprite("holaperras4", "cc/leovincible/a/3", -370, -125)
addLuaSprite('holaperras4', false)
scaleObject('holaperras4', 2.5, 2.5)
setProperty('holaperras4.alpha', 0)

makeLuaSprite("mensaje", "cc/leovincible/a/Josephs-message", 0, 0)
addLuaSprite('mensaje', false)
scaleObject('mensaje', 2.9, 2.9)
setProperty('mensaje.alpha', 0)
setObjectCamera('mensaje', 'other')

makeLuaSprite("mensaje de mi tio", "cc/leovincible/a/message-from-the-others", 0, 0)
addLuaSprite('mensaje de mi tio', false)
scaleObject('mensaje de mi tio', 2.9, 2.9)
setProperty('mensaje de mi tio.alpha', 0)
setObjectCamera('mensaje de mi tio', 'other')
end
function onCreatePost()
	removeLuaSprite('vignetteog', true)
	removeLuaSprite('static', true)
	end
	function onStepHit()
		if curStep == 2649 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 2651 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 2653 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 2655 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
		elseif curStep == 3184 then
		doTweenAlpha('negr', 'camGame', 0, 4, 'linear')
		doTweenAlpha('negrr', 'camHUD', 0, 4, 'linear')
		elseif curStep == 3278 then
		makeLuaSprite("holaperras2", "cc/leovincible/a/1", -370, -125)
addLuaSprite('holaperras2', false)
scaleObject('holaperras2', 2.5, 2.5)
removeLuaSprite('holaperras', true)
		elseif curStep == 3284 then
		doTweenAlpha('negr', 'camGame', 1, 1.2, 'linear')
		doTweenAlpha('negrr', 'camHUD', 1, 1.7, 'linear')
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
		setProperty('timeBar.visible', false)
		setProperty('timeBarBG.visible', false)
		setProperty('timeTxt.visible', false)
		setProperty('duracion.visible', false)
		setTextSize('scoreCC', 9.5)
		scaleObject('scoreCC', 1.37, 1.77)
		setTextBorder('scoreCC',1, '000000')
		setProperty('scoreCC.x',getProperty('scoreTxt.x')-230)
		setProperty('scoreCC.y',getProperty('scoreTxt.y')+1)
	elseif curStep == 3472 then
		setProperty('mensaje.alpha', 1)
	elseif curStep == 3480 then
		setProperty('mensaje de mi tio.alpha', 1)
	elseif curStep == 3488 then
		doTweenColor('e', 'noteCombo', '000000', 0.01, 'linear')
		setTextSize('scoreCC', 4)
		scaleObject('scoreCC', 3.57, 3.42)
		setTextBorder('scoreCC',1, '000000')
		setProperty('scoreCC.x',getProperty('scoreTxt.x')-1650)
		setProperty('scoreCC.y',getProperty('scoreTxt.y')-7)
		removeLuaSprite('mensaje', true)
		removeLuaSprite('mensaje de mi tio', true)
		removeLuaSprite('holaperras2', true)
		setProperty('holaperras3.alpha', 1)
	elseif curStep == 3936 then
		removeLuaSprite('holaperras3', true)
		setProperty('holaperras4.alpha', 1)
	elseif curStep == 4704 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4708 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4725 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4729 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4738 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4740 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4760 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4763 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4781 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4785 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4822 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4840 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4853 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4860 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4869 then
		setProperty('camGame.alpha', 0)
	elseif curStep == 4873 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 4883 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4892 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4900 then
		setProperty('camGame.alpha', 0)
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4907 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 4912 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4929 then
		setProperty('camGame.alpha', 0)
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4931 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 4940 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
		elseif curStep == 4950 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4964 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4980 then
		setProperty('camGame.alpha', 0)
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4982 then
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4992 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 5012 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 5014 then
		setProperty('camGame.alpha', 0)
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 5018 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 5022 then
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 5024 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
		setProperty('camGame.alpha', 0)
	elseif curStep == 5028 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 5032 then
		setProperty('camGame.alpha', 0)
	elseif curStep == 5036 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 5040 then
		setProperty('camGame.alpha', 0)
	elseif curStep == 5044 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 4912 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 4929 then
		setProperty('camGame.alpha', 0)
		setProperty('boyfriendGroup.alpha', 0.001)
		setProperty('dadGroup.alpha', 0.001)
	elseif curStep == 4931 then
		setProperty('camGame.alpha', 1)
	elseif curStep == 4840 then
		setProperty('boyfriendGroup.alpha', 1)
		setProperty('dadGroup.alpha', 1)
	elseif curStep == 5365 then
		removeLuaSprite('holaperras4', true)
		makeLuaSprite("holaperras5", "cc/leovincible/a/4", -370, -125)
addLuaSprite('holaperras5', false)
scaleObject('holaperras5', 2.5, 2.5)
	elseif curStep == 5694 then
		removeLuaSprite('holaperras5', true)
		makeLuaSprite("holaperras6", "cc/leovincible/a/5", -370, -125)
addLuaSprite('holaperras6', false)
scaleObject('holaperras6', 2.5, 2.5)
	elseif curStep == 5825 then
		removeLuaSprite('holaperras6', true)
		makeLuaSprite("holaperras7", "cc/leovincible/a/6", -370, -125)
addLuaSprite('holaperras7', false)
scaleObject('holaperras7', 2.5, 2.5)
	elseif curStep == 5921 then
		removeLuaSprite('holaperras7', true)
		setProperty('camGame.alpha', 0)
		setProperty('camHUD.alpha', 0)
		end
	end