function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then
        startVideo('post hideout cutscene');
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end
