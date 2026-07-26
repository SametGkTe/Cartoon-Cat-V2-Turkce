function onCreate()
	makeLuaSprite('abcdenotengoideas','cc/lamb/lambevicho',-1280,-1070)
	addLuaSprite('abcdenotengoideas')
	scaleObject('abcdenotengoideas', 2.5, 2.5)
	if lowQuality then
        makeLuaSprite('bflash', '', 0, 0);
        makeGraphic('bflash',680,340,'000000')
        addLuaSprite('bflash', false);
        setLuaSpriteScrollFactor('bflash',0,0)
        setProperty('bflash.scale.x',3)
        setProperty('bflash.scale.y',3.4)
        setProperty('bflash.antialiasing',false)
        end
		makeAnimatedLuaSprite('estatica','cc/taf/estaticauwu',0,0)
addAnimationByPrefix('estatica', 'loop', 'rojo', 24, true);
scaleObject('estatica', 13, 8)
setProperty('estatica.alpha',0.0001)
setProperty('estatica.antialiasing',false)
setObjectCamera('estatica','hud')
addLuaSprite('estatica', true);
	end
function onCreatePost()
	scaleObject('gfGroup', 2.38, 2.38)
	setProperty('bflash.alpha', 1)
	setObjectCamera('bflash','other')
end
function onUpdatePost()
	if mustHitSection then
		setProperty('defaultCamZoom', 0.7)
	else
		setProperty('defaultCamZoom', 0.5)
	end
end
function onStepHit()
	if curStep == 10 then
	doTweenAlpha('hoa', 'bflash', 0, 3, 'linear')
	elseif curStep == 48 then
	doTweenAlpha('estatci', 'estatica', 0.5, 1, 'linear')
	elseif curStep == 57 then
		setObjectCamera('bflash','hud')
		doTweenAlpha('estatci', 'estatica', 0, 0.2, 'linear')
		setProperty('bflash.alpha', 1)
		setObjectOrder('bflash', 4);
	elseif curStep == 64 then
		setProperty('bflash.alpha', 0)
	elseif curStep == 704 then
		setProperty('estatica.alpha', 0.4)
	elseif curStep == 712 then
		removeLuaSprite('estatica', true)
	elseif curStep == 1760 then
		setObjectCamera('bflash','other')
		doTweenAlpha('bflash', 'bflash', 1, 0.8, 'linear')
	end
end