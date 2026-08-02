function onCreate()
setTimeBarColors('C9C9C9', '000000')
setTextFont('scoreTxt', 'Ticketing.otf')
setProperty("timeTxt.x", 375)
makeLuaText('duracion', '- 2:49', 430, 468, 20)
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
doTweenAlpha('ssssssss', 'duracion', 1, 0.1, 'linear');
end