function onCreate()
for i = 0, getProperty('unspawnNotes.length')-1 do
if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Meat Note' then 
setPropertyFromGroup('unspawnNotes', i, 'texture', 'MEAT_NOTE_assets');
if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
end
end
end
end
function goodNoteHit(id, direction, noteType, isSustainNote)
if noteType == 'Meat Note' then
addHealth(-0.5)
end
end
