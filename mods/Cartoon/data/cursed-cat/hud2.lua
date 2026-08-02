function onCreate()
setTimeBarColors('FF0000', '000000')
scaleObject('timeTxt', 1.2, 1.2)
setTextFont('timeTxt', 'gatoexe.ttf')
setProperty("timeTxt.x", 350)
setProperty("timeTxt.y", 13)
makeLuaText('duracion', '- 2:06', -1, 635, 10)
setTextSize('duracion', 30)
setObjectCamera('duracion', 'hud')
addLuaText('duracion', false)
setTextFont('duracion', 'gatoexe.ttf')
setProperty('duracion.alpha', 0)
scaleObject('duracion', 1.25, 1.25)
setTextBorder('duracion',1.3, '000000')
setTextBorder('timeTxt',1.3, '000000')
if downscroll then
setProperty('duracion.y', 666)
setProperty("timeTxt.y", 669)
end
if timeBarType == 'Disabled' then
setProperty('duracion.visible', false)
elseif timeBarType == 'Song Name' then
setProperty("timeTxt.x", 445)
setProperty('duracion.visible', false)
end
end
function onSongStart()
doTweenAlpha('hola', 'duracion', 1, 0.1, 'linear');
end