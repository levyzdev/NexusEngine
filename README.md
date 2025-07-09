![](https://github.com/levyzdev/NexusEngine/blob/main/art/nexus_engine.png?raw=true)
# FNF - Nexus Engine
An engine focused on making it easier for modders to make their **mods**.

## Compiling:

Refer to [the Build Instructions](./BUILDING.md)

## Customization:

if you wish to disable things like *Lua Scripts* or *Video Cutscenes*, you can read over to `Project.xml`

inside `Project.xml`, you will find variables to customize Nexus Engine to your liking

to start you off, disabling Videos should be simple, simply Delete the line `"VIDEOS_ALLOWED"` or comment it out by wrapping the line in XML-like comments, like this `<!-- YOUR_LINE_HERE -->`

same goes for *Lua Scripts*, comment out or delete the line with `LUA_ALLOWED`, this and other customization options are all available within the `Project.xml` file

## Credits:

### Nexus Team:
* levyzdev - Head/Programmer
* Angel - Artist
* Joseph - Artist and Dub

## Psych Engine Team:
* Shadow Mario - Programmer
* Riveren - Artist

### Special Thanks
* bbpanzu - Ex-Programmer
* Yoshubs - Ex-Programmer
* SqirraRNG - Crash Handler and Base code for Chart Editor's Waveform
* KadeDev - Fixed some cool stuff on Chart Editor and other PRs
* iFlicky - Composer of Psync and Tea Time, also made the Dialogue Sounds
* PolybiusProxy - .MP4 Video Loader Library (hxCodec)
* Keoiki - Note Splash Animations
* Smokey - Sprite Atlas Support
* Nebula the Zorua - some Lua reworks
* superpowers04 - LUA JIT Fork
_____________________________________

# Features

## New Title Screen
![](https://github.com/levyzdev/NexusEngine/blob/main/docs/img/nexus/titlenexus.png?raw=true)
* **Optimizations** and **fixes** applied.
* More **style** with less **appearance**

## Revamped RPC
![](https://github.com/levyzdev/NexusEngine/blob/main/art/rpc.png?raw=true)
* Most complete Discord **RPC** for your friends to see more of your **gameplay** (lol)
  
## New Options Settings Menu
![](https://github.com/levyzdev/NexusEngine/blob/main/docs/img/nexus/customMenu.png?raw=true)

* With **corrections** and improvements. 

## Main Menu Revamped
![](https://github.com/levyzdev/NexusEngine/blob/main/docs/img/nexus/menu.png?raw=true)
* **Minor changes** to button orders and new Tween

## PlayState Revamped
![Screenshot_1](https://user-images.githubusercontent.com/44785097/144632635-f263fb22-b879-4d6b-96d6-865e9562b907.png)
* Now with smoother camera and visual effects on strums

  
## Other features:
* ClientPrefs **reset** function.
* **Verse Events** to use in your **mods**.
* NexusVideoHanler **implemented** *(based on FlxVideo)*
* Spin Notes Strums.

