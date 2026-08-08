local DIALOGUE_TEXT_X = 140
local DIALOGUE_TEXT_Y = 560
local DIALOGUE_TEXT_WIDTH = 1000
-- Yaparken acı çekiyorum lütfen yardım edin - SametGkTe
local HINT_X = 900
local HINT_Y = 660

local BTN_Y = 590
local BTN_WIDTH = 200
local BTN_HEIGHT = 30
local BTN1_X = 390
local BTN2_X = 680

local FONT_NAME = 'Ticketing.ttf'
local FONT_SIZE = 18
local CHAR_DELAY = 0.045
local TEXT_COLOR = 'FFFFFF'
local debugModeJ = true

local dialogues = {
    [1]  = "Pekala Çocuk, önceden sana saldırıp aramızdaki \nbu küçük anlaşmayı bozmaya çalıştığım için \nözür dilerim.",
    [2]  = "Anlaşılan, bir az önce birkaç tane \ngerizekalı yüzünden oyunumuz yarıda kesildi.",
    [3]  = "Aradan geçen her yıl \ntekrar ve tekrar bu olup duruyor \nve artık bu benim canımı sıkmaya başladı",
    [4]  = "Demek istediğim, \nbu dünyayı yok edip gitsem beni kim tutabilirki? \nkesinlikle onlar değil.",
    [5]  = "Kaderi durduran benim, \nburayı yok etmek istemiyorum, en azından şimdi değil",
    [6]  = "Burda çok eğlenceli vakit geçirdin, \ninsanlar yavaş yavaş kendilerini yok ediyorlar \nve bunu görmezden gelmeye çalışıyorlar, \nizlemesi çok keyifli",
    [7]  = "Geçen bu süreçte bazıları \nbölgeme izinsiz giriş yaptılar, \nsayelerinde binlerce kedi fare oyunu oynadım",
    [8]  = "O fare kılıklı bütün insanlar \nelinde sonunda binlerce parçaya ayrıldılar",
    [9]  = "Yani sana 2 tane seçenek sunucam",
    [10] = "Seçenek 1: 3. bir şarkı oynarız, \niki taraf içinde mükemmel bir performans olur.",
    [11] = "Hatta bir kaç tane eski dostu \nizlemesi için çağırdım bile!",
    [12] = "Ama kaybedersen, işler biraz değişir.",
    [13] = "Ney mi değişir? 24 saat boyunca etrafındaki \nherşey kaybolcak",
    [14] = "Seçenek 2: direk seni öldürücem",
    [15] = "3. bir şarkı olmicak, \nbinlerce parçaya ayrılıcaksın, eski günlerki gibi!",
    [16] = "Buda benim işime gelir",
    [17] = "Odaklan ve iyi düşün",
}

local dialogueChoice2 = "Anlıyorum... diğer seçenekten biraz korktun ha?"
local dialogueChoice2b = "PLACEHOLDER - İkinci ölüm diyaloğu buraya gelecek."
local dialogue18 = "Gördüğüme göre tehlikeyi seviyorsunn.. \nNeyse uyarıyı ben yaptım artık geri dönüş yok."
local dialogue19 = "Hadi son bölümü oynayalım."

local choice1Text = "SEÇENEK 1"
local choice2Text = "SEÇENEK 2"

local systemActive = false
local currentDialogue = 0
local totalDialogues = 17

local phase = 'dialogue'

local soundPlaying = false
local soundFinished = false
local soundTag = ''

local fullText = ''
local cleanText = ''
local displayedText = ''
local charIndex = 0
local typewriterActive = false
local typewriterTimer = 0

local selectedChoice = 1
local choiceActive = false

local deathPhase = 'none'
local deathDialogueIndex = 0
local postGoodIndex = 0
local inputLocked = false
local uiReady = false

local exitQueued = false

local mouseWasDown = false
local mouseIsClicked = false

local mouseShown = false

local soundDurations = {
    ['1']  = 4.8,  ['2']  = 4.5,  ['3']  = 5.0,
    ['4']  = 5.0,  ['5']  = 4.0,  ['6']  = 6.5,
    ['7']  = 5.5,  ['8']  = 4.0,  ['9']  = 2.5,
    ['10'] = 4.5,  ['11'] = 3.5,  ['12'] = 3.0,
    ['13'] = 3.5,  ['14'] = 2.5,  ['15'] = 4.0,
    ['16'] = 1.5,  ['17'] = 1.8,  ['18'] = 4.5,
    ['19'] = 2.0,  ['01'] = 3.0,  ['02'] = 3.0,
}

local function safeShowMouse()
    local ok, err = pcall(function()
        showMouse()
    end)
    if ok then
        mouseShown = true
    end
end

local function safeHideMouse()
    if not mouseShown then return end
    local ok, err = pcall(function()
        hideMouse()
    end)
    if ok then
        mouseShown = false
    end
end

local function cleanupDialogueStuff()
    cancelTimer('dialogueStartDelay')
    cancelTimer('choiceInputDelay')
    cancelTimer('deathAnimDone')
    cancelTimer('exitAfterDeath')
    cancelTimer('soundCheckTimer')

    cancelTween('fadeBox')
    cancelTween('fadeEyes')
    cancelTween('fadeText')
    cancelTween('fadeHint')
    cancelTween('finalFade')

    if soundTag ~= nil and soundTag ~= '' then
        pcall(function()
            stopSound(soundTag)
        end)
    end

    pcall(function()
        stopSound('tafDeathMusic')
    end)
end

function stripMarkup(text)
    return string.gsub(text, "~", "")
end

function applyColorMarkup(tag, text)
    local clean = stripMarkup(text)
    setTextString(tag, clean)

    if string.find(text, "~") then
        local escaped = string.gsub(text, "\\", "\\\\")
        escaped = string.gsub(escaped, '"', '\\"')
        escaped = string.gsub(escaped, "\n", "\\n")

        runHaxeCode([[
            var obj = game.getLuaObject("]] .. tag .. [[");
            if(obj != null) {
                var ftext:FlxText = cast(obj, FlxText);
                if(ftext != null) {
                    ftext.applyMarkup("]] .. escaped .. [[",
                        [new FlxTextFormatMarkerPair(
                            new FlxTextFormat(0xFFFF4444), "~"
                        )]
                    );
                }
            }
        ]])
    end
end

function startTypewriter(text)
    fullText = text
    cleanText = stripMarkup(text)
    displayedText = ''
    charIndex = 0
    typewriterActive = true
    typewriterTimer = 0
    setTextString('dialogueText', '')
end

function finishTypewriter()
    typewriterActive = false
    displayedText = cleanText
    charIndex = string.len(cleanText)
    applyColorMarkup('dialogueText', fullText)
end

function canAdvance()
    return soundFinished and (not typewriterActive)
end

function playSoundFile(filename)
    cancelTimer('soundCheckTimer')

    local cleanTag = string.gsub(filename, '%.ogg', '')
    soundTag = 'tafSound_' .. cleanTag
    soundFinished = false
    soundPlaying = true
    inputLocked = true

    local soundPath = 'tafcutscene/' .. cleanTag

    pcall(function()
        stopSound(soundTag)
    end)

    pcall(function()
        playSound(soundPath, 1, soundTag)
    end)

    local key = string.gsub(filename, '%.ogg', '')
    local duration = soundDurations[key] or 4.0
    runTimer('soundCheckTimer', duration)
end

function mouseClicked(button)
    return mouseIsClicked
end

function onCreate()
    setVar('tafDialogueActive', true)
    setVar('tafDialogueDone', false)
end

function onStartCountdown()
    if seenCutscene or phase == 'done' then
        return Function_Continue
    end
    if not systemActive then
        initDialogueSystem()
        return Function_Stop
    end

    return Function_Stop
end

function initDialogueSystem()
    systemActive = true
    phase = 'dialogue'
    currentDialogue = 0
    exitQueued = false

    makeLuaSprite('tafBlackBg', '', 0, 0)
    makeGraphic('tafBlackBg', 1280, 720, '000000')
    setObjectCamera('tafBlackBg', 'other')
    setProperty('tafBlackBg.alpha', 1)
    addLuaSprite('tafBlackBg', true)

    makeLuaSprite('tafEyes', 'tafcutscene/eyes', 0, 0)
    setObjectCamera('tafEyes', 'other')
    addLuaSprite('tafEyes', true)
    screenCenter('tafEyes', 'xy')

    makeLuaSprite('tafBox', 'tafcutscene/box', 0, 0)
    setObjectCamera('tafBox', 'other')
    addLuaSprite('tafBox', true)
    setProperty('tafBox.x', 0)
    setProperty('tafBox.y', 0)

    makeAnimatedLuaSprite('tafDeath', 'tafcutscene/Bf_Taf_Death', 0, 0)
    addAnimationByPrefix('tafDeath', 'death', 'animshit', 24, false)
    setObjectCamera('tafDeath', 'other')
    setProperty('tafDeath.alpha', 0)
    setProperty('tafDeath.visible', false)
    addLuaSprite('tafDeath', true)

    createDialogueUI()
end

function createDialogueUI()
    makeLuaText('dialogueText', '', DIALOGUE_TEXT_WIDTH, DIALOGUE_TEXT_X, DIALOGUE_TEXT_Y)
    setTextFont('dialogueText', FONT_NAME)
    setTextSize('dialogueText', FONT_SIZE)
    setTextColor('dialogueText', TEXT_COLOR)
    addLuaText('dialogueText', true)
    setObjectCamera('dialogueText', 'other')
    setTextString('dialogueText', '')
    setProperty('dialogueText.x', DIALOGUE_TEXT_X)
    setProperty('dialogueText.y', DIALOGUE_TEXT_Y)
    setProperty('dialogueText.fieldWidth', DIALOGUE_TEXT_WIDTH)

    makeLuaText('continueHint', '[SPACE / ENTER] ile Geç', 300, HINT_X, HINT_Y)
    setTextFont('continueHint', FONT_NAME)
    setTextSize('continueHint', 16)
    setTextColor('continueHint', 'AAAAAA')
    setTextAlignment('continueHint', 'right')
    setProperty('continueHint.alpha', 0)
    addLuaText('continueHint', true)
    setObjectCamera('continueHint', 'other')

    local btnW = BTN_WIDTH
    local btnH = BTN_HEIGHT
    local borderSize = 3
    local btn1X = BTN1_X
    local btn2X = BTN2_X
    local btnY = BTN_Y

    makeLuaSprite('choiceHighlight1', '', 0, 0)
    makeGraphic('choiceHighlight1', btnW + borderSize * 2, btnH + borderSize * 2, 'FFFFFF')
    setObjectCamera('choiceHighlight1', 'other')
    setProperty('choiceHighlight1.x', btn1X - borderSize)
    setProperty('choiceHighlight1.y', btnY - borderSize)
    setProperty('choiceHighlight1.alpha', 0)
    addLuaSprite('choiceHighlight1', true)

    makeLuaSprite('choiceBg1', '', 0, 0)
    makeGraphic('choiceBg1', btnW, btnH, '000000')
    setObjectCamera('choiceBg1', 'other')
    setProperty('choiceBg1.x', btn1X)
    setProperty('choiceBg1.y', btnY)
    setProperty('choiceBg1.alpha', 0)
    addLuaSprite('choiceBg1', true)

    makeLuaSprite('choiceHighlight2', '', 0, 0)
    makeGraphic('choiceHighlight2', btnW + borderSize * 2, btnH + borderSize * 2, 'FFFFFF')
    setObjectCamera('choiceHighlight2', 'other')
    setProperty('choiceHighlight2.x', btn2X - borderSize)
    setProperty('choiceHighlight2.y', btnY - borderSize)
    setProperty('choiceHighlight2.alpha', 0)
    addLuaSprite('choiceHighlight2', true)

    makeLuaSprite('choiceBg2', '', 0, 0)
    makeGraphic('choiceBg2', btnW, btnH, '000000')
    setObjectCamera('choiceBg2', 'other')
    setProperty('choiceBg2.x', btn2X)
    setProperty('choiceBg2.y', btnY)
    setProperty('choiceBg2.alpha', 0)
    addLuaSprite('choiceBg2', true)

    makeLuaText('choiceBtn1', choice1Text, btnW, btn1X, btnY + 5)
    setTextFont('choiceBtn1', FONT_NAME)
    setTextSize('choiceBtn1', 18)
    setTextColor('choiceBtn1', 'FFFFFF')
    setTextAlignment('choiceBtn1', 'center')
    setProperty('choiceBtn1.alpha', 0)
    addLuaText('choiceBtn1', true)
    setObjectCamera('choiceBtn1', 'other')

    makeLuaText('choiceBtn2', choice2Text, btnW, btn2X, btnY + 5)
    setTextFont('choiceBtn2', FONT_NAME)
    setTextSize('choiceBtn2', 18)
    setTextColor('choiceBtn2', 'FFFFFF')
    setTextAlignment('choiceBtn2', 'center')
    setProperty('choiceBtn2.alpha', 0)
    addLuaText('choiceBtn2', true)
    setObjectCamera('choiceBtn2', 'other')

    inputLocked = true
    runTimer('dialogueStartDelay', 3)
    uiReady = true
end

function advanceDialogue()
    currentDialogue = currentDialogue + 1
    inputLocked = true
    setProperty('continueHint.alpha', 0)

    if currentDialogue > totalDialogues then
        showChoiceScreen()
        return
    end

    local text = dialogues[currentDialogue] or ("Diyalog " .. currentDialogue)
    startTypewriter(text)
    playSoundFile(currentDialogue .. '.ogg')
end

function showChoiceScreen()
    phase = 'choice'
    choiceActive = true
    selectedChoice = 1

    setTextString('dialogueText', 'Bir seçenek seç:')
    setProperty('dialogueText.y', DIALOGUE_TEXT_Y)
    setProperty('continueHint.alpha', 0)

    setProperty('choiceHighlight1.alpha', 1)
    setProperty('choiceHighlight2.alpha', 1)
    setProperty('choiceBg1.alpha', 1)
    setProperty('choiceBg2.alpha', 1)
    setProperty('choiceBtn1.alpha', 1)
    setProperty('choiceBtn2.alpha', 1)

    setTextColor('choiceBtn1', 'FFFFFF')
    setTextColor('choiceBtn2', 'FFFFFF')

    safeShowMouse()

    inputLocked = true
    runTimer('choiceInputDelay', 0.3)
end

function hideChoiceScreen()
    choiceActive = false
    setProperty('dialogueText.y', DIALOGUE_TEXT_Y)
    setProperty('choiceHighlight1.alpha', 0)
    setProperty('choiceHighlight2.alpha', 0)
    setProperty('choiceBg1.alpha', 0)
    setProperty('choiceBg2.alpha', 0)
    setProperty('choiceBtn1.alpha', 0)
    setProperty('choiceBtn2.alpha', 0)
end

function confirmChoice()
    hideChoiceScreen()
    inputLocked = true

    safeHideMouse()

    if selectedChoice == 2 then
        startDeathSequence()
    else
        startPostGoodSequence()
    end
end

function startPostGoodSequence()
    phase = 'post_good'
    postGoodIndex = 1

    startTypewriter(dialogue18)
    playSoundFile('18.ogg')
end

function advancePostGood()
    postGoodIndex = postGoodIndex + 1

    if postGoodIndex == 2 then
        inputLocked = true
        setProperty('continueHint.alpha', 0)
        startTypewriter(dialogue19)
        playSoundFile('19.ogg')
    else
        finishDialogueAndPlayVideo()
    end
end

function finishDialogueAndPlayVideo()
    cleanupDialogueStuff()
    safeHideMouse()

    phase = 'done'
    setPropertyFromClass('states.PlayState', 'seenCutscene', true)

    removeLuaSprite('tafBlackBg', true)
    removeLuaSprite('tafEyes', true)
    removeLuaSprite('tafBox', true)
    removeLuaSprite('tafDeath', true)
    removeLuaSprite('choiceBg1', true)
    removeLuaSprite('choiceBg2', true)
    removeLuaSprite('choiceHighlight1', true)
    removeLuaSprite('choiceHighlight2', true)
    removeLuaText('dialogueText')
    removeLuaText('continueHint')
    removeLuaText('choiceBtn1')
    removeLuaText('choiceBtn2')

    systemActive = false
    setVar('tafDialogueActive', false)
    setVar('tafDialogueDone', true)

    if getPropertyFromClass('states.PlayState', 'isStoryMode') then
        startVideo('vimuyj')
    else
        startCountdown()
    end
end

function startDeathSequence()
    cleanupDialogueStuff()

    phase = 'death'
    deathPhase = 'dialogue'
    inputLocked = true
    deathDialogueIndex = 1
    exitQueued = false

    startTypewriter(dialogueChoice2)
    playSoundFile('01.ogg')
end

function advanceDeathDialogue()
    deathDialogueIndex = deathDialogueIndex + 1

    if deathDialogueIndex == 2 then
        inputLocked = true
        setProperty('continueHint.alpha', 0)
        startTypewriter(dialogueChoice2b)
        playSoundFile('02.ogg')
    else
        startDeathFade()
    end
end

function startDeathFade()
    deathPhase = 'fadingOut'
    inputLocked = true
    setProperty('continueHint.alpha', 0)

    doTweenAlpha('fadeBox', 'tafBox', 0, 1, 'linear')
    doTweenAlpha('fadeEyes', 'tafEyes', 0, 1, 'linear')
    doTweenAlpha('fadeText', 'dialogueText', 0, 1, 'linear')
    doTweenAlpha('fadeHint', 'continueHint', 0, 0.5, 'linear')
end

function startDeathAnimation()
    deathPhase = 'animPlaying'

    setProperty('tafDeath.visible', true)
    setProperty('tafDeath.alpha', 1)
    screenCenter('tafDeath', 'xy')
    objectPlayAnimation('tafDeath', 'death', true)

    playSound('tafcutscene/taf', 1, 'tafDeathMusic')

    runTimer('deathAnimDone', 3.5)
end

function handleAdvanceInput()
    if inputLocked then return end
    if choiceActive then return end
    if not canAdvance() then return end

    if phase == 'dialogue' then
        advanceDialogue()
    elseif phase == 'post_good' then
        advancePostGood()
    elseif phase == 'death' and deathPhase == 'dialogue' then
        advanceDeathDialogue()
    end
end

function handleMouseChoice()
    local mx = getMouseX('other')
    local my = getMouseY('other')

    local b1x = getProperty('choiceBg1.x')
    local b1y = getProperty('choiceBg1.y')
    local b1w = getProperty('choiceBg1.width')
    local b1h = getProperty('choiceBg1.height')

    local b2x = getProperty('choiceBg2.x')
    local b2y = getProperty('choiceBg2.y')
    local b2w = getProperty('choiceBg2.width')
    local b2h = getProperty('choiceBg2.height')

    local overChoice1 = (mx >= b1x and mx <= b1x + b1w and my >= b1y and my <= b1y + b1h)
    local overChoice2 = (mx >= b2x and mx <= b2x + b2w and my >= b2y and my <= b2y + b2h)

    if overChoice1 then
        selectedChoice = 1
    elseif overChoice2 then
        selectedChoice = 2
    end

    if mouseClicked('left') then
        if overChoice1 or overChoice2 then
            confirmChoice()
        end
    end
end

function onUpdate(elapsed)
    if not systemActive then return end
    if not uiReady then return end

    if debugModeJ and keyboardJustPressed('J') then
        if choiceActive then
            hideChoiceScreen()
            safeHideMouse()
        end

        cleanupDialogueStuff()

        typewriterActive = false
        phase = 'post_good'
        postGoodIndex = 1
        choiceActive = false
        inputLocked = true
        soundFinished = false

        setProperty('continueHint.alpha', 0)
        startTypewriter(dialogue18)
        playSoundFile('18.ogg')
    end

    if typewriterActive then
        typewriterTimer = typewriterTimer + elapsed
        if typewriterTimer >= CHAR_DELAY then
            typewriterTimer = typewriterTimer - CHAR_DELAY
            charIndex = charIndex + 1
            if charIndex >= string.len(cleanText) then
                finishTypewriter()
            else
                displayedText = string.sub(cleanText, 1, charIndex)
                setTextString('dialogueText', displayedText)
            end
        end
    end

    if canAdvance() and not inputLocked and not choiceActive then
        setProperty('continueHint.alpha', 1)
    end

    if not inputLocked and not choiceActive then
        if keyboardJustPressed('SPACE') or keyboardJustPressed('ENTER') then
            handleAdvanceInput()
        end
    end

    if choiceActive and not inputLocked then
        if keyboardJustPressed('LEFT') then
            selectedChoice = 1
        elseif keyboardJustPressed('RIGHT') then
            selectedChoice = 2
        elseif keyboardJustPressed('ENTER') or keyboardJustPressed('SPACE') then
            confirmChoice()
        end
        handleMouseChoice()
    end
end

function onUpdatePost(elapsed)
    if not systemActive then return end
    local mouseDown = mousePressed('left')
    mouseIsClicked = (mouseDown and not mouseWasDown)
    mouseWasDown = mouseDown
end

function onSoundFinished(tag)
    if tag == soundTag then
        soundPlaying = false
        soundFinished = true
        if not choiceActive then
            inputLocked = false
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'fadeBox' then
        startDeathAnimation()
    end
    if tag == 'finalFade' then
        runTimer('exitAfterDeath', 1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'dialogueStartDelay' then
        advanceDialogue()
    end

    if tag == 'choiceInputDelay' then
        if choiceActive then
            inputLocked = false
        end
    end

    if tag == 'deathAnimDone' then
        deathPhase = 'closing'

        makeLuaSprite('tafRedScreen', 'tafcutscene/red', 0, 0)
        setObjectCamera('tafRedScreen', 'other')
        addLuaSprite('tafRedScreen', true)
        setProperty('tafRedScreen.x', 0)
        setProperty('tafRedScreen.y', 0)

        runTimer('exitAfterDeath', 1)
    end

    if tag == 'exitAfterDeath' then
        if exitQueued then
            return
        end

        if phase ~= 'death' then
            return
        end

        exitQueued = true
        systemActive = false
        cleanupDialogueStuff()

        local ok1, _ = pcall(function()
            runHaxeCode([[
                if(PlayState.instance != null) {
                    PlayState.instance.endSong();
                }
            ]])
        end)

        if not ok1 then
            pcall(function()
                runHaxeCode([[
                    FlxG.switchState(new states.MainMenuState());
                ]])
            end)
        end
    end

    if tag == 'soundCheckTimer' then
        soundFinished = true
        soundPlaying = false
        if not choiceActive then
            inputLocked = false
        end
    end
end

function onDestroy()
    cleanupDialogueStuff()
    safeHideMouse()
    systemActive = false
    choiceActive = false
    typewriterActive = false
    inputLocked = true
    exitQueued = false
    mouseShown = false
    setVar('tafDialogueActive', false)
end