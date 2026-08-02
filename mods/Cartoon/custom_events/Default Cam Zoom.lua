function onEvent(name,value1,value2)

    if name == "Default Cam Zoom" then
        
        setProperty("defaultCamZoom",value1) 
        if not value1 == '' then
            setProperty("camGame.zoom",value1) 
	end
            
    end
end
function onUpdatePost(elapsed)
if songName == 'Evil Eye' or songName == 'evileyeold.json' then
  if keyboardJustPressed('SPACE') then
    makeLuaSprite('a', 'cc/leovincible/gloria', 0, 0);
    setObjectOrder('a', 70)
	scaleObject('a', 1.5, 1.5)
	addLuaSprite('a', true);
  setObjectCamera('a','other')
    setProperty('camHUD.visible', false)
    setPropertyFromClass('PlayState', 'instance.vocals.volume', 0)
      setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
      setPropertyFromClass('PlayState', 'instance.generatedMusic', false)
      setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
end
elseif songName == 'Cartoon Jam' then
	if keyboardJustPressed('SPACE') then
		runTimer('comer', 0.0001)
	end
elseif songName == 'Toon Swing' then
	if keyboardJustPressed('SPACE') then
    makeLuaSprite('a', 'cc/park/jacob', 0, 0);
    setObjectOrder('a', 70)
	scaleObject('a', 1.6, 1.6)
	addLuaSprite('a', true);
  setObjectCamera('a','hud')
		playSound('a', 0.99)
    runTimer('a', 0.8)
    triggerEvent('Screen Shake','1, 0.01','1, 0.01')
    function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'a' then
    doTweenAlpha('w', 'a', 0, 2, 'easeIn')
	end
end
end
end
end
function onCreatePost()
makeLuaText("fps", " ", -1, 5, 5)
setTextSize("fps", 9.1)
setObjectCamera("fps", 'other'); 
setTextColor('fps', 'ffffff')
addLuaText("fps",true)
setTextFont('fps',"Ticketing.ttf");
setTextBorder('fps', 0, '000000')
  addHaxeLibrary('Main');
  runHaxeCode([[
Main.fpsVar.visible = false;
  ]]);
end

function round(x, n)
  n = math.pow(10, n or 0)
  x = x * n
  if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
  return x / n
end
function onCreate()
end
mP = 0
memPeak = 0
function onUpdate()

local curFps = ""..getPropertyFromClass("Main", "fpsVar.currentFPS")
local m = round(getPropertyFromClass("openfl.system.System", "totalMemory") / 1000000, 1);
if mP < m then
mP = m
end
local peakLv = 0
  

yepp = ""

if m> 1024 then
memory = round(m / 1024,2)
measure = "GB"
else
memory = m
measure = "MB"
end

if mP> 1024 then
memPeak = round(mP / 1024,2)
measurePeak = "GB"
else
memPeak = mP
measurePeak = "MB"
end

if getPropertyFromClass("Main", "fpsVar.currentFPS") <=30 then
setTextColor('MemoryCounter', 'ff0000')
setTextColor('fps', 'ff0000')
else
setTextColor('MemoryCounter', 'ffffff')
setTextColor('fps', 'ffffff')
end
 
setTextString("MemoryCounter", " ")
setTextString("fps","FPS: "..curFps .. " - Bellek: " .. memory .." "..measure.. " ("..memPeak.." "..measurePeak.. " En Yüksek)")
end

function onEndSong() 
addHaxeLibrary('Main');
  runHaxeCode([[
Main.fpsVar.visible = true;
  ]]);
end

function onExitSong() 
addHaxeLibrary('Main');
  runHaxeCode([[
Main.fpsVar.visible = true;
  ]]);
end

