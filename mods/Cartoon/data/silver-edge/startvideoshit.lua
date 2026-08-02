function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then
        startVideo('has post cutscene final hopefully');
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end
