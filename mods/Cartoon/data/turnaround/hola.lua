local VideoStart=true
function onCreate()
	local camHUD = getObject("camHUD")
	if camHUD then
	setObjectOrder('videoSprite', 90, camHUD)
	else
	print("HUD object not found.")
	end
end
function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then
        startVideo('tmwtudf turnaround cutscene')
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end
