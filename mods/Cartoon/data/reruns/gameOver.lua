local folder = 'gameOver/reruns/'
local maxVoices = 9
local lastVoice = 0
local chosenVoice = 1

local subtitleDuration = 7

local subtitles = {
    [1] = "Ne yani, bu kadar mıydı?",
    [2] = "Cidden zamanımı bunamı ayırdım şimdi, Hehehehehe! NE KADARDA UTANÇ VERİCİSİN.",
    [3] = "Dostum. Bu oyunu nineler gibi oynuyorsun biliyorsun değil mi?",
    [4] = "Ne, parmakların felan mi küçük senin?",
    [5] = "Hah! şovunu yaptın evlat bu kadarı yeterliydi zaten.",
    [6] = "Ayy, kaybettin diye ağlicakmısın şimdi?",
    [7] = "Ateşle oynamayı kessen iyi olur evlat",
    [8] = "Hah, nesin sen 5 yaşında falanmısın?",
    [9] = "Aaa hadi ama dostum, bu oyunda cidden bu kadar berbatmısın?"
}

local function pickVoice()
    local chosen = getRandomInt(1, maxVoices)

    while chosen == lastVoice and maxVoices > 1 do
        chosen = getRandomInt(1, maxVoices)
    end

    lastVoice = chosen
    return chosen
end

local function showSubtitle(text)
    makeLuaSprite('voiceSubtitleBox', '', 40, 620)
    makeGraphic('voiceSubtitleBox', 1200, 70, '000000')
    setObjectCamera('voiceSubtitleBox', 'other')
    setProperty('voiceSubtitleBox.alpha', 0.55)
    addLuaSprite('voiceSubtitleBox', true)

    makeLuaText('voiceSubtitle', text, 1160, 60, 635)
    setTextAlignment('voiceSubtitle', 'center')
    setTextSize('voiceSubtitle', 28)
    setTextBorder('voiceSubtitle', 2, '000000')
    setObjectCamera('voiceSubtitle', 'other')
    addLuaText('voiceSubtitle')

    runTimer('hideSubtitle', subtitleDuration)
end

local function hideSubtitle()
    removeLuaText('voiceSubtitle', true)
    removeLuaSprite('voiceSubtitleBox', true)
end

function onGameOverStart()
    chosenVoice = pickVoice()
    runTimer('playDeathVoice', 0.15)
end

function onTimerCompleted(tag)
    if tag == 'playDeathVoice' then
        playSound(folder .. chosenVoice, 1, 'deathVoice')

        if subtitles[chosenVoice] ~= nil and subtitles[chosenVoice] ~= '' then
            showSubtitle(subtitles[chosenVoice])
        end
    end

    if tag == 'hideSubtitle' then
        hideSubtitle()
    end
end

function onGameOverConfirm(retry)
    stopSound('deathVoice')
    cancelTimer('hideSubtitle')
    hideSubtitle()
end