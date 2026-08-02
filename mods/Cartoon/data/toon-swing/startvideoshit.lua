function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then
        startVideo('toon-swing-cutscene-shit');
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end
