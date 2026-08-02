function onCreatePost()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') and 
        (not getPropertyFromGroup('unspawnNotes', i, 'mustPress')) then
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
        end
    end
end
function opponentNoteHit(_, _, _, s)
    if s then
        setProperty('dad.holdTimer', 0)
    end
end