function onCreate()
setTimeBarColors('4B3938', '')
setTextFont('scoreTxt', 'Ticketing.otf')
setProperty("timeTxt.x", 375)
makeLuaText('duracion', '- 2:00', 430, 468, 20)
setTextSize('duracion', 30)
setTextFont('duracion', 'impact.ttf')
setObjectCamera('duracion', 'hud')
addLuaText('duracion', false)
setTextFont('duracion', 'vcr.ttf')
setProperty('duracion.alpha', 0)
if downscroll then
setProperty('duracion.y', 677)
end
if timeBarType == 'Disabled' then
setProperty('duracion.visible', false)
elseif timeBarType == 'Song Name' then
setProperty("timeTxt.x", 445)
setProperty('duracion.visible', false)
end
end
function onSongStart()
runHaxeCode([[game.songLength = (120000 + 1000);]])
    doTweenAlpha('hola', 'duracion', 1, 0.1, 'linear');
end
function onStepHit()
if curStep == 1040 then
setTextString('duracion', '- 2:35')
runHaxeCode([[game.songLength = (155000 + 1000);]])
end
end