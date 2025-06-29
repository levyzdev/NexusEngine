function goodNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        runTimer('spinAllPlayerNotes', 0.4) 
    end
end

function onTimerCompleted(tag)
    if tag == 'spinAllPlayerNotes' then
        for i = 4, 7 do
            local tagSpin = 'groupSpin_' .. i .. '_' .. curStep
            noteTweenAngle(tagSpin, i, 360, 0.3, 'circOut')
        end
        runTimer('resetAllAngles', 0.3)
    elseif tag == 'resetAllAngles' then
        for i = 4, 7 do
            setPropertyFromGroup('strumLineNotes', i, 'angle', 0)
        end
    end
end
