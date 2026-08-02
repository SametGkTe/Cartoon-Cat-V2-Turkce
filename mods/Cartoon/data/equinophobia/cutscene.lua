function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then
        startVideo('post-reruns_cutscene1');
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end
