function onCreate()
   makeLuaSprite('white', '', -150, 100);
    makeGraphic('white',680,340,'ffffff')
    addLuaSprite('white', false);
    setLuaSpriteScrollFactor('white',0,0)
    setProperty('white.scale.x',3.7)
    setProperty('white.scale.y',3.8)
    setProperty('white.alpha',0.00001)

    makeLuaSprite('flash', '', 0, 0);
      setProperty('flash.alpha',0.000001)
      makeGraphic('flash',540,340,'ffffff')
      setObjectCamera('flash', 'hud')
	   addLuaSprite('flash', false);
	   setProperty('flash.scale.x',3.8)
	   setProperty('flash.scale.y',3.3)

      makeLuaSprite('drugs', 'cc/drugs/zeus', 8, -12);
      addLuaSprite('drugs', false);
      setProperty('drugs.scale.x',2.62)
      setProperty('drugs.scale.y',2.62)
end

function onStepHit()
   if curStep == 16 then
      setProperty('defaultCamZoom', 1)
   end

   if curStep == 32 then
      setProperty('defaultCamZoom', 0.8)
   end

   if curStep == 48 then
      setProperty('defaultCamZoom', 1)
   end

   if curStep == 64 then
      setProperty('defaultCamZoom', 0.8)
   end

   if curStep == 128 then
      setProperty('defaultCamZoom', 0.59);
      triggerEvent('Change Scroll Speed', 1.2, 0.01)
   end

   if curStep == 176 then
      setProperty('defaultCamZoom', 1)
   end

   if curStep == 192 then
      setProperty('defaultCamZoom', 0.8)
   end

   if curStep == 239 then
      triggerEvent('Change Scroll Speed', 1, 0.01)
   end

   if curStep == 240 then
      setProperty('defaultCamZoom', 1)
   end

   if curStep == 256 then
      triggerEvent('Change Scroll Speed', 1.2, 0.01)
      setProperty('defaultCamZoom', 0.8)
   end

   if curStep == 368 then
      setProperty('defaultCamZoom', 1)
   end

   if curStep == 374 then
      setProperty('defaultCamZoom', 1.2)
   end

   if curStep == 382 then
      setProperty('defaultCamZoom', 1.4)
   end
   

   if curStep == 384 then
      setProperty('defaultCamZoom', 1);
      triggerEvent('Change Scroll Speed', 1, 0.01)
   end

   if curStep == 544 then
      setProperty('defaultCamZoom', 0.59);
   end

   if curStep == 560 then
      setProperty('defaultCamZoom', 1);
   end

   if curStep == 590 then
      setProperty('defaultCamZoom', 1.2);
   end

   if curStep == 1664 then
      triggerEvent('Play Animation', 'sniff 0','dad')
      triggerEvent('Add Camera Zoom', 0.5,0.5)
   end

   if curStep == 605 then
      triggerEvent('Play Animation', 'sniff 1','dad')
      triggerEvent('Add Camera Zoom', 0.5,0.5)
   end

   if curStep == 617 then
      triggerEvent('Play Animation', 'sniff 1','dad')
      triggerEvent('Add Camera Zoom', 0.5,0.5)
   end

   if curStep == 629 then
      triggerEvent('Play Animation', 'sniff 2','dad')
   end

   if curStep == 630 then
      runTimer('fade', 1.5);
      doTweenAlpha('flTw','flash',1,1,'cubeIn')
   end

   if curStep == 644 then
      setTimeBarColors('FFFFFF', '000000')
      setProperty('white.alpha',1)
      setProperty('drugs.alpha',0)
      setProperty('gf.alpha',0)
      triggerEvent('Camera Follow Pos', 830, 600)
      triggerEvent('Change Scroll Speed', 0.8, 2)
      setProperty('defaultCamZoom', 0.8);
      doTweenColor('e', 'noteCombo', '000000', 0.01, 'linear')
      runTimer('OponenteChauNotas',0.4)
      runTimer('aeiou',1)
   end
     
   if curStep > 644 and curStep < 1184 then
      healthDrain()
   end

   if curStep == 1163 then
      triggerEvent('Play Animation', 'funny','dad')
   end
   if curStep == 1183 then
      setProperty('flash.alpha',1)
      runTimer('fadeagain', 0.1);
   end
   if curStep == 1184 then
      doTweenColor('e', 'noteCombo', 'FFFFFF', 0.01, 'linear')
      setTimeBarColors('460021', '000000')
      setProperty('drugs.alpha',1)
      setProperty('white.alpha',0)
      setProperty('gf.alpha',1)
      triggerEvent('Camera Follow Pos', '', '')
      triggerEvent('Play Animation', 'drugs','bf')
      triggerEvent('Change Scroll Speed', 1.2, 0.01)
      cancelTimer('aeiou')
      cancelTimer('abcd')
      noteTweenAlpha('p4', 4, 0.9, 3, 'elasticInOut')
      noteTweenAlpha('p5', 5, 1, 2.6, 'easeOut')
      noteTweenAlpha('p6', 6, 0.4, 3.2, 'sineInOut')
      noteTweenAlpha('p7', 7, 0.8, 2.3, 'cubeOut')
   end

   if curStep == 1440 then
      triggerEvent('Change Scroll Speed', 1, 0.01)
      setProperty('defaultCamZoom', 1.1);
   end

   if curStep == 1504 then
      setProperty('defaultCamZoom', 0.59);
   end

   if curStep == 1568 then
      setProperty('defaultCamZoom', 1);
   end

   if curStep == 1691 then
      triggerEvent('Play Animation', 'sniff 1','dad')
      setProperty('defaultCamZoom', 1.5);
   end
end


function onBeatHit()
   if curBeat > 31 and curBeat < 60 then
      if curBeat % 100 then
	      triggerEvent("Add Camera Zoom",0.05, 0.05);
      end
   end

   if curBeat > 64 and curBeat < 92 then
      if curBeat % 100 then
	    	triggerEvent("Add Camera Zoom",0.05, 0.05);
      end
   end

   if curBeat > 296 and curBeat < 360 then
      if curBeat % 100 then
	    	triggerEvent("Add Camera Zoom",0.05, 0.05);
      end
   end
end

function onTimerCompleted(tag, loops, loopsLeft)
   if tag == 'fade' then
      doTweenAlpha('flTw','flash',0,3,'cubeIn')
   end
   if tag == 'fadeagain' then
      doTweenAlpha('flTwas','flash',0,2,'cubeIn')
   end
   if tag == 'aeiou' then
      noteTweenAlpha('p4', 4, 0.2, 3.6, 'elasticInOut')
      noteTweenAlpha('p5', 5, 0.2, 2.9, 'sineIn')
      noteTweenAlpha('p6', 6, 0.2, 2.4, 'easeInOut')
      noteTweenAlpha('p7', 7, 0.2, 3.2, 'cubeInOut')
      runTimer('abcd',3.6)
   end
   if tag == 'abcd' then
      noteTweenAlpha('p4', 4, 0.6, 3, 'elasticInOut')
      noteTweenAlpha('p5', 5, 0.8, 2.6, 'easeOut')
      noteTweenAlpha('p6', 6, 0.9, 3.2, 'sineInOut')
      noteTweenAlpha('p7', 7, 0.7, 2.3, 'cubeOut')
      runTimer('aeiou',3)
   end
   if tag == 'OponenteChauNotas' then
      noteTweenAlpha('0', 0, 0.2, 3.3, 'sineInOut')
      noteTweenAlpha('1', 1, 0.2, 2.2, 'cubeInOut')
      noteTweenAlpha('2', 2, 0.2, 1.9, 'sineOut')
      noteTweenAlpha('3', 3, 0.2, 2.7, 'easeIn')
      runTimer('OponenteChauNotas2',3.4)
   end
   if tag == 'OponenteChauNotas2' then
      noteTweenAlpha('0', 0, 0.8, 2.2, 'cubeIn')
      noteTweenAlpha('1', 1, 0.8, 3.3, 'sineInOut')
      noteTweenAlpha('2', 2, 0.8, 2.6, 'easeOut')
      noteTweenAlpha('3', 3, 0.8, 2.4, 'elasticInOut')
      runTimer('OponenteChauNotas',3.6)
   end
end
function healthDrain()
   health = getProperty('health')
      if getProperty('health') > 0.05 then
      setProperty('health', health- 0.008);
   end
end
function onCreatePost()
	removeLuaSprite('vignetteog', true)
	removeLuaSprite('static', true)
end