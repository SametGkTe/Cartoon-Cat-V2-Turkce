local healthflipped = false;

function onCreate()
	setObjectOrder('vignetteog',3)
	makeLuaSprite('bgbgxxx', 'cc/forest/lunabg2', -620, -420);
        addLuaSprite('bgbgxxx', false);
        scaleObject('bgbgxxx', 3.3, 3.3);
		setScrollFactor('bgbgxxx', 0.3, 0.3);

		makeLuaSprite('bgbg', 'cc/forest/lunabg1', -990, -463);
        addLuaSprite('bgbg', false);
        scaleObject('bgbg', 3.3, 3.3);

		makeLuaSprite('bgbg2', 'cc/forest/lunasegudafase', -1132, -370);
        addLuaSprite('bgbg2', false);
        scaleObject('bgbg2', 2.5, 2.5);
		setProperty('bgbg2.alpha', 0.0001);

		makeAnimatedLuaSprite('patas','cc/forest/hmmpatas',-920,-470)
        addAnimationByPrefix('patas', 'caminando', 'caminando', 6, true);
        setProperty('patas.alpha',0.001)
        scaleObject('patas',4.7, 4.7)
        addLuaSprite('patas', true)
        setObjectCamera('patas','hud')
        setObjectOrder('patas', 0);

		makeAnimatedLuaSprite('patas2','cc/forest/hola puta', 970,-1110)
        addAnimationByPrefix('patas2', 'caminando', 'culo', 12, true);
        setProperty('patas2.visible',false)
        scaleObject('patas2',3.3, 3.3)
        addLuaSprite('patas2', true)

		makeLuaSprite('bflash', '', 0, 0);
        makeGraphic('bflash',1080,540,'000000')
        addLuaSprite('bflash', false);
        setObjectCamera('bflash','hud')
        setProperty('bflash.scale.x',1.4)
        setProperty('bflash.scale.y',1.75)
        setObjectOrder('bflash', 1);
        setProperty('bflash.alpha', 0);

end

function onUpdatePost()
	if healthflipped == true then
		   P1Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') *        getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)
   
		   P2Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)
   
		   setProperty('iconP1.x',P1Mult - 110)
   
		   setProperty('iconP1.origin.x',240)
   
		   setProperty('iconP1.flipX',true)
   
		   setProperty('iconP2.x',P2Mult + 110)
   
		   setProperty('iconP2.origin.x',-100)
   
		   setProperty('iconP2.flipX',true)
   
		   setProperty('healthBar.flipX',true)
		   if version >= '0.7' then
			setProperty('iconP1.x', getProperty('iconP1.x')+335)
			setProperty('iconP2.x', getProperty('iconP2.x')+330)
		end
   end
   
	if healthflipped == false then
   
		   P1Mult = getProperty('healthBar.x') - ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)
   
		   P2Mult = getProperty('healthBar.x') - ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)
   
		   setProperty('iconP2.origin.x',0)
   
		   setProperty('iconP2.flipX',false)
   
		   setProperty('iconP1.origin.x',0)
   
		   setProperty('iconP1.flipX',false)
   
		   setProperty('healthBar.flipX',false)
   end
   
end


   function onStepHit()
	if curStep == 383 then 
		doTweenAlpha('nigg', 'bflash', 1, 0.01, 'linear')
		setPropertyFromClass('flixel.FlxG', 'mouse.visible', true);
	elseif curStep == 390 then 
		setObjectOrder('bgbg', 20);
		setProperty('dadGroup.x', -200)
		setProperty('dadGroup.y', 180)
		setProperty('boyfriendGroup.x', 340)
		setProperty('boyfriendGroup.y', 140)
		setProperty('patas.alpha',1)
		setProperty('patas.x', -940)
		doTweenX('caminandoxdxd', 'patas', 1630, 8, 'linear')
	elseif curStep == 626 then 
		doTweenAlpha('nigg', 'bflash', 1, 0.5, 'linear')
		setProperty('patas.alpha',0)
	elseif curStep == 635 then 
		doTweenAlpha('nigg', 'bflash', 0, 0.5, 'linear')
		setObjectOrder('bgbg', 5);
		setProperty('dadGroup.x', -280)
		setProperty('dadGroup.y', 240)
		setProperty('boyfriendGroup.x', 700)
		setProperty('boyfriendGroup.y', 150)
	elseif curStep == 888 then 
			doTweenAlpha('nigg', 'bflash', 1, 0.01, 'linear')
			setPropertyFromClass('flixel.FlxG', 'mouse.visible', true);
		elseif curStep == 895 then 
			setObjectOrder('bgbg', 20);
			setProperty('dadGroup.x', 550)
			setProperty('dadGroup.y', 160)
			setProperty('boyfriendGroup.x', 1085)
			setProperty('boyfriendGroup.y', 140)
			setProperty('patas.alpha',1)
		setProperty('patas.x', -940)
		doTweenX('caminandoxdxd', 'patas', 1630, 8, 'linear')
		elseif curStep == 1032 then 
			removeLuaSprite('patas', true)
			doTweenAlpha('niggCam', 'camGame', 0, 0.7, 'linear')
   elseif curStep == 1035 then 
	if not middlescroll then
		noteTweenX('Movement X 0', 0, defaultPlayerStrumX0, 2, 'quintInOut')
		noteTweenX('Movement X 1', 1, defaultPlayerStrumX1, 2, 'quintInOut')
		noteTweenX('Movement X 2', 2, defaultPlayerStrumX2, 2, 'quintInOut')
		noteTweenX('Movement X 3', 3, defaultPlayerStrumX3, 2, 'quintInOut')
	
		noteTweenX('Movement X 4', 4, defaultOpponentStrumX0, 2, 'quintInOut')
		noteTweenX('Movement X 5', 5, defaultOpponentStrumX1, 2, 'quintInOut')
		noteTweenX('Movement X 6', 6, defaultOpponentStrumX2, 2, 'quintInOut')
		noteTweenX('Movement X 7', 7, defaultOpponentStrumX3  , 2, 'quintInOut')
	end
		healthflipped = true;
	elseif curStep == 1040 then 
		doTweenAlpha('niggCam', 'camGame', 1, 0.6, 'linear')
		removeLuaSprite('bgbgxxx', true)
		removeLuaSprite('bgbg', true)
		setProperty('boyfriendGroup.x', -370)
		setProperty('boyfriendGroup.y', -110)
		setProperty('dadGroup.x', 530)
		setProperty('dadGroup.y',-20)
		setProperty('bgbg2.alpha', 1)
	elseif curStep == 1344 then 
		setProperty('bflash.alpha', 1)
		doTweenAlpha('nigg', 'bflash', 0, 0.8, 'linear')
		setProperty('patas2.visible', true)
	elseif curStep == 1376 then 
		setProperty('camGame.alpha', 0)
	elseif curStep == 1377 then 
		setProperty('camGame.alpha', 1)
	elseif curStep == 1378 then 
		setProperty('camGame.alpha', 0)
	end
end
function onCreatePost()
	doTweenColor('dad', 'dadGroup', '94AAFF', 0.1, 'linear')
	doTweenColor('boyfriend', 'boyfriendGroup', '94AAFF', 0.1, 'linear')
	doTweenColor('gf', 'gfGroup', '94AAFF', 0.1, 'linear')
	doTweenColor('siren', 'patas2', '94AAFF', 0.1, 'linear')
	scaleObject('gfGroup', 1.98, 1.98)
	setProperty('gfGroup.x', 84)
	setProperty('gfGroup.y', -48)
end