local folder = 'gameOver/taf/'
local maxVoices = 5
local lastVoice = 0
local chosenVoice = 1

local subtitleDuration = 3  -- saniye

local subtitles = {
    [1] = "HAHAHAH, HAHAHAHAH, HAHAH, HAHAHAH, HAHAHAHAHAHA, HAHAHHA.",
    [2] = "BU TURU KAZANMAK İÇİN 10 FIRIN EKMEK YEMEN LAZIM EVLAT!",
    [3] = "NE YANİ, ELİNDEN GELEN BU KADAR MIYDI? HAHAHAHAHA!",
    [4] = "NE YANİ, ŞANSA BALA BU TURU KAZANABİLECEĞİNİ Mİ ZANNETMİŞTİN?",
    [5] = "AAA! HADİ AMA ÇOCUK CİDDEN BU OYUNDA BU KADAR BERBAT MISIN SEN?"
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