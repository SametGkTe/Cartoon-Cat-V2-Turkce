function onCreate()
    setPropertyFromClass('substates.GameOverSubstate', 'songGameOverMode', 'turnaround')
end

function onDestroy()
    setPropertyFromClass('substates.GameOverSubstate', 'songGameOverMode', 'meatbf')
end