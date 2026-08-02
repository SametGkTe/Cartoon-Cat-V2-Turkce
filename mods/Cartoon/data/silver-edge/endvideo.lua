function onEndSong()
    if not allowCountdown and isStoryMode and not seenCutscene then
        startVideo('ending');
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end
