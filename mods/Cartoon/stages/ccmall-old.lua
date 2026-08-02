function onCreate()
makeLuaSprite('mol','cc/mallBg',-225, 72)
addLuaSprite('mol')
scaleObject('mol', 1.75, 1.75)
setScrollFactor('mol', 0.90, 0.90);
end
function onCreatePost()
setProperty('vignetteog.alpha',0.15)
end