function onEvent(name, value1, value2)
if name == 'Camera Set Target' then
if string.lower(value1) == 'bf' then
cameraSetTarget('boyfriend')
elseif string.lower(value1) == 'dad' then
cameraSetTarget('dad')
elseif string.lower(value1) == 'gf' then
setProperty('camFollow.x', getMidpointX('gf'))
setProperty('camFollow.y', getMidpointY('gf'))
end
elseif string.lower(value1) == 'center' then
setProperty('camFollow.x', getProperty('camFollow.x') + 400)
setProperty('camFollow.y', getProperty('camFollow.x') + 400)
end
if value2 == 'true' then
setProperty("isCameraOnForcedPos", true)
end
if value2 == 'false' then
setProperty("isCameraOnForcedPos", true)
end
end