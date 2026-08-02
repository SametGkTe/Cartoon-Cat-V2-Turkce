function onEndSong()
    if not allowCountdown and not seenCutscene then
        startVideo('revelations');
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end
