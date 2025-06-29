wO = {}

function onCreate()
  --BG VARS
  setOnLuas('build', (buildTarget == 'browser' or buildTarget == 'android' or buildTarget == 'unknown') and 'mobile' or 'pc')
  setOnLuas('psychVersion', tonumber((version:gsub('%.', ''))))
  setOnLuas('language', os.setlocale(nil, 'collate') or 'english')
  setOnLuas('curStepR', 0)

  -------------------------===================---------------------------
  local events = getTextFromFile('scripts/aVerseEvents.lua', false)
  local functions = {}
  local haxeArgs = ''
  local luaArgs = ''

  for funcName, args in events:gmatch("function%s+_(%w+)%((.-)%)") do
    local cache = {}

    for arg in args:gmatch("[^,]+") do
      arg = arg:gsub("^%s*(.-)%s*$", "%1")
      table.insert(cache, arg)
      functions[funcName] = cache
    end

    runHaxeCode(string.format([==[createGlobalCallback('%s', function(%s) { parentLua.call('_%s', [%s]); } );]==], 
      funcName,
      table.concat(functions[funcName] or {}, ', ?'),
      funcName,
      table.concat(functions[funcName] or {}, ',')))
  end
  -------------------------===================---------------------------

  runHaxeCode([[import openfl.filters.ShaderFilter;]])

  for i=1,2 do
    makeLuaSprite('bar'..i, nil, 0, (i == 1) and -screenHeight or screenHeight)
    makeGraphic('bar'..i, screenWidth, screenHeight, '000000')
    setObjectCamera('bar'..i, 'camHUD')
    addLuaSprite('bar'..i, false)
  end
end

--PLAYSTATE VARS
function onCreatePost()
  --WINDOWS
  setOnLuas('monitorWidth', getPropertyFromClass('openfl.Lib', 'application.window.display.bounds.width'))
  setOnLuas('monitorHeight', getPropertyFromClass('openfl.Lib', 'application.window.display.bounds.height'))

  for _,w in pairs({'x', 'y', 'width', 'height'}) do
    wO[w] = getPropertyFromClass('openfl.Lib', 'application.window.'..w)
  end

  setOnLuas('windowOrigin', wO)
  setOnLuas('reposWindow', false)

  makeLuaSprite('window', nil, windowOrigin.x, windowOrigin.y)
  makeGraphic('window', windowOrigin.width, windowOrigin.height, '0000ff')
  setProperty('window.visible', false)
  setProperty('window.alpha', 0)
  addLuaSprite('window', false)

  setOnLuas('botPlayOrigin', getProperty('cpuControlled'))
  setOnLuas('stageZoom', getProperty('defaultCamZoom'))
  setOnLuas('camSpeed', getProperty('cameraSpeed'))
end

function onStepHit() setOnLuas('curStep', curStep + curStepR) end

--EVENTS
function _camZoom(float)
  setProperty('defaultCamZoom', stageZoom + (float and float or 0))
end

function _camTweenZoom(zoom, time, ease, fixCam)
  doTweenZoom('camGameZ', 'camGame', stageZoom + zoom, time, (ease and ease or 'linear'))

  if fixCam then
    setProperty('defaultCamZoom', stageZoom + zoom)
  end
end

function _camSpeed(float)
  setProperty('cameraSpeed', camSpeed + (float and float or 0))
end

function _camDueto(dueto, offsetX, offsetY)
  if dueto then
    triggerEvent('Camera Follow Pos', offsetX + (getProperty('dad.x') + (getProperty('boyfriend.x') + getProperty('boyfriend.width'))) / 2, offsetY + (getProperty('dad.y') + getProperty('boyfriend.y'))/2)
  else
    triggerEvent('Camera Follow Pos', nil, nil)
  end
end

function _cinematic(height, duration, animation, moveNotes)
  for i=1,2 do
    cancelTween('bar'..i..'Y')
    doTweenY('bar'..i..'Y', 'bar'..i, i == 1 and ((screenHeight - height) - ((screenHeight - height) * 2)) or screenHeight - height , duration, animation)
  end

  if moveNotes then
    for i=0,7 do
      cancelTween('noteY'..i)
      noteTweenY('noteY'..i, i, downscroll and defaultPlayerStrumY0 - (height/1.4) or defaultPlayerStrumY0 + (height/1.4), duration, animation)
    end
  end
end

--WINDOWS
function onUpdate(elapsed)
  if not (inGameOver and build == 'mobile') then
    for _,w in pairs({'x', 'y', 'width', 'height'}) do
      if getProperty('window.'..w) ~= getPropertyFromClass('openfl.Lib', 'application.window.'..w) and not getPropertyFromClass('openfl.Lib', 'application.window.fullscreen') then
        setPropertyFromClass('openfl.Lib', 'application.window.'..w, getProperty('window.'..w))
      end

      if not reposWindow and windowOrigin[w] ~= getPropertyFromClass('openfl.Lib', 'application.window.'..w) then
        wO[w] = getPropertyFromClass('openfl.Lib', 'application.window.'..w)
      end

      if reposWindow and windowOrigin[w] ~= getPropertyFromClass('openfl.Lib', 'application.window.'..w) then
        setOnLuas('windowOrigin', wO[w])
      end
    end

    updateHitbox('window')
  end
end

--SHADERS
function _setShaderCamera(shader, cam)
  makeLuaSprite(shader..'SR')
  makeGraphic(shader..'SR', screenWidth, screenHeight)
  setSpriteShader(shader..'SR', shader)
  
  for i=1,#cam do
    runHaxeCode([[
      game.]]..(cam[i]:lower():find('game') and [[camGame]] or cam[i]:lower():find('hud') and [[camHUD]] or cam[i]:lower():find('other') and [[camOther]] or cam[i])..[[.setFilters([new openfl.filters.ShaderFilter(game.getLuaObject(']]..shader..'SR'..[[').shader)]);
    ]])
  end
end

function _removeCameraShader(cam)
  runHaxeCode([[
    game.]]..(cam:lower():find('game') and [[camGame]] or cam:lower():find('hud') and [[camHUD]] or cam:lower():find('other') and [[camOther]] or cam)..[[.setFilters([]);
  ]])
end

--TOOLS/INUTES
function _precacheVideo(videoFile)
  runHaxeCode([[Paths.video(]]..videoFile..[[)]])
end



function onPause()
  if reposWindow and build == 'pc' then
    for _,w in pairs({'x', 'y', 'width', 'height'}) do
      setPropertyFromClass('openfl.Lib', 'application.window.'..w, windowOrigin[w])
    end
  end

  callMethod('videoCutscene.pause')
end

function onResume()
  callMethod('videoCutscene.resume')
end

function onGameOver()
  if reposWindow and build == 'pc' then
    for _,w in pairs({'x', 'y', 'width', 'height'}) do
      setPropertyFromClass('openfl.Lib', 'application.window.'..w, windowOrigin[w])
    end
  end

  callMethod('videoCutscene.destroy')
  callMethod('remove', {instanceArg('videoCutscene')})
end

function onDestroy()
  if reposWindow and build == 'pc' then
    for _,w in pairs({'x', 'y', 'width', 'height'}) do
      setPropertyFromClass('openfl.Lib', 'application.window.'..w, windowOrigin[w])
    end
  end
end
--script by marshverso(YT)