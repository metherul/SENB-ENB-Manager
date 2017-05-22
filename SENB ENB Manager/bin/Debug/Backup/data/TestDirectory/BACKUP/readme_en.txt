//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//ENBSeries is a set of graphical modifications for games
//Description on the web page may not be equal to this info.
//created by Boris Vorontsov http://enbdev.com
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

PUBLISHING BINARY FILES OF ENBSERIES ON NEXUS SITES (TES NEXUS, SKYRIM NEXUS, ETC)
IS STRICTLY PROHIBITED. ONLY PRESETS AND SHADERS CAN BE HOSTED THERE.



ENBSeries v0.308 for TES Skyrim (graphic mod and patch).

Restored old skylighting code, it's less buggy in some places. Removed dependency of LocationID
from mods loading order. Added support of loading multiple plugins (.dllplugin extention) from
"enbseries" folder.


To use weather system or some effects like mist, download enbhelper plugin.
Helper plugin is special addon for ENBSeries and it work only with latest version of the
game (like SKSE), i advise to use it. Download from http://dev-c.com
and place enbhelper.dll to "enbseries" folder inside game folder.



WARNING!
bFloatPointRenderTarget=1 must be set in SkyrimPrefs.ini file to make this mod work.
Start SkyrimLauncher.exe to configure your video options again.


This is just the mod without preset, you need to download them from the forum
http://enbdev.com or Nexus web site.


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//RECOMMENDED OTHER MODS
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
BUGFIX FOR INVALID OBJECTS:
http://enbseries.enbdev.com/forum/viewtopic.php?f=6&t=1499
User MINDFLUX created (still wip, but available for download) fix for transparent objects
which do not work properly with ENBSeries as their properties are wrong. For example
some water particles glow in the night, doors looks transparent with ssao.



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//CHANGES LOG
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Version 0.305:
Added DawnDuskEnable parameter for toggling dawn and dusk times of the day and their
parameters. By default it's disabled for compatibility with old presets.

Version 0.304:
Added localization support files enblocalization.xml and enbfontunicode.png, hope
this feature will help users to understand how to tweak mod. Example localization
is very short and contains just description of some parameters in english.
Added EnableUnsafeFixes parameter to enblocal.ini to activate previously disabled
fixes which removes microstuttering, scripts and physics bugs, but have negative
side effects of showing another game bugs, like worldmap issue.

Version 0.303:
Added new ENBoost features which improve stability at cost of performance, check parameters
under [THREADS] category of enblocal.ini. Bigger values for DataSync and Priority modes means
lower frame rate, more stuttering and higher incompatibility with other software, some
previously working screen capturing tools may crash or be extremely slow with new setting
other than 0. Developed and tested for mods pack which have 40% crash rate on loading,
when DataSyncMode=1 no crashes occurs.

Version 0.302:
Added per location weather configuration file. Increased performance of skylighting.

Version 0.301:
Added color filter and it's amount parameters to game weather dependent variables, so
now editing weather in Creation Kit is not required for making nice looking preset.
Some variables do not have ColorFilterAmount parameter, this means their values can be
set to one by curve=0 or such parameters do not change with weather to bother with
increasing complexity of the mod for end users.

Version 0.292:
Disabled forcing of antialiasing in loading screens. Added color filter parameters for direct light,
fog and sky gradients.

Version 0.290:
Fixed bug of incorrect colors of some particle type. Added SDK to control parameters
of shaders or configuration files.

Version 0.279:
Changed ENBoost memory manager by forcing memory statistics of the mod only to reduce
issues with bad drivers and software. Changed ssao/ssil code for faster performance
on videocards with memory like AMD Fury.
Added BruteForce with new hotkey (shift+b) for screen archers. This mode enables
very high quality for effects and advanced algorithms, at huge performance cost.
Right now only ambient occlusion and indirect lighting is improved only, calculations
including self shadowing of these effects. Be careful with it, low quality videocards
or overclocked can be corrupted. Added to profiler two variables which show how many
valid and invalid textures are loaded by ENBoost memory manager, because invalid
textures have much longer loading times and stuttering as result (medium and low
texture quality do the same).

Version 0.277:
Removed EnableTransparencyAA, becaise not widely used and cost performance even when
disabled. Removed EnableZPrepass, because performance improvement is minor, but many
users have unknown bugs with it. Added parameters to profiler to visualise ambient
occlusion, indirect lighting and reflections, this will help to find balance between
quality and performance (press apply changes button).

Version 0.272:
Added long exposure mode to enblocal.ini config file and it's accumulate hdr image data.
This mode is useful for making artistic screenshots.

Version 0.269:
Various fixes and improvements.

Version 0.266:
Removed bloom quality parameter. Added FixLag parameter to enblocal.ini which reduce
annoying delays mostly in windowed mode, seems for NVidia cards only. Reduced video
memory usage when some effects are disabled, because it's the reason of low performance
with some videocards. Fixed performance drop when terrain parallax is not enabled.
Added EnableZPrepass parameter to enblocal.ini to increase fillrate performance. It
may fail if skyrimprefs.ini is not configured properly.
Added AmountInterior and PowerInterior parameters for reflection.

Version 0.265:
Added AnchorsAmount*** parameters as mix factors between mist anchors and world center.
Temporal antialiasing now capture data from helper plugin to fix bugs at certain places.
Forced fps limiter for loading screens to 60 fps.
Added parallax for terrain, some vanilla textures already work (alpha channel of diffuse
maps is height data for parallax). It's controlled by variable FixParallaxTerrain.
Added specular parameters as multipliers to existing for [OBJECT], [VEGETATION] and [EYE]
categories of enbseries.ini to control individually, may be useful for wet body mods.
Added string variables to shaders for text annotations.
Added detailed shadows for hemisphere and spot lights.

Version 0.264:
Added alt+f4 key combination to terminate game. Fixed bug with eyes when antialiasing enabled.
Added texOriginal for enbeffectprepass.fx shader, which is first input texture.
Removed obsolete FixSsaoHairTransparency parameter.
Added edge antialiasing for loading screens.
Added depth computation for transparent objects to fix depth based artifacts of objects
like some hair types, fire and other particles, volumetric fog, mist.
Added hack which allow to disable relfection for certain objects, check out HACKS section
in description how to use it.
Removed ForceFakeVideocard parameter.

Version 0.262:
Added distance fade parameter to the mist category. Also rescaled vertical fade of
the mist by 0.25.
Added EnableTextureAlpha parameter for subsurface scattering effect, it can be modified
only manually with game restart. When enabled, alpha channel of sss textures is used
to modify subsurface scattering computation radius and amount. Alpha values between
192..255 affect radius by decreasing it up to 4 times, 0..191 values modify amount
of subsurface effect. By default alpha is white in textures, so i don't expect any
issues with existing body modifications, feel free to modify their sss texture alpha
channel, dxt5 format is preffered.
Added WeatherAndTime vector for external shaders which allow identify weathers and time
of the day in hours. For performance reasons i suggest to compute data in vertex shader.

Version 0.261:
Added opacity parameters for volumetric fog (by request). Fixed bug with flickering
ambient occlusion, image based lighting and subsurface scattering when using camera
fly mode console command at some conditions.

Version 0.254:
Only bugfixes and tweaks for ENBoost.

Version 0.252:
Tweaked ENBoost memory manager to increase performance when no free video memory available.
Parameter ReservedMemorySizeMb now can be modified inside editor in game.

Version 0.251:
Added parameters to control mipmapping lod bias. Added texOriginal texture type for
effect.txt shaders which is always unchanged first texture, this allow to make some
more complex computations. Added text messages on shader compilation errors.
IgnoreLoadingScreen parameter removed. Shader compilation errors displayed only when
editor enabled, but i recommend to delete or replace files which produce such errors,
they do not work anyway.

Version 0.250:
Changed ENBoost, now it support up to 128 Gb of memory or about 192 when compression enabled,
may be this will be useful for the future. Don't forget to update ENBHOST.EXE file.
Added mist effect, it may work without helper plugin, but then absolute world positioning
will not work, so grab enbhelper from http://www.dev-c.com/skyrim/. I'll fix all it
artifacts in updates.
Added anchors editor for mist effect to allow modify vertical offset of the mist in
different places. Now the mist (which is fog and haze in same effect) have all required
properties and i'm not planning to add new, so feel free to build presets with it.
Increased startup performance.

Version 0.246:
Added procedural sun to fix pixelization and low precision issues of standart sun.
Added CloudsEdgeFadeRange parameter to control sun scattering for clouds and changed
it algorithm to not depend from texture of sun. Added Density and SkyColorAmount
parameters for volumetric sun rays. Fixed previous bug of procedural sun visibility
even when set to zero.
Modified method of reading sun visibility for enbsunsprite.fx shader (sun glare effect)
to be independent from size of the sun and to work properly with procedural sun, but
side effect of these changes is higher intensity of sun glare effect, so rescale it
accordinly.
Added supersampling for ambient occlusions (not editable when game running), it works
twice slower and make image four times more clear. Added additional ambient occlusion
filter quality modes for very sharp look when supersampling enabled. Removed parameter
UseOldType which previously activated very old non optimized ssao type. Fixed bug
with twice bigger intensity of image based lighting, so please scale up this effect
in your presets, if used. Restored water displacement optimization for AMD users, which
had much lower wave aplitude, if it work now, then it was my bug with speedhack. Modified
all quality parameters by names, previous "extreme -1" is now named "very high -1" and
extreme have value -2, this do not affect anything by performance or quality, so no need
to modify anything.
Improved performance of ambient occlusions in general and NVidia specific for supersampling
mode of this effect. Added ILType parameter to [SSAO_SSIL] category to toggle previous
simplified and less noisy method vs proper but noisy (used in versions for other games).
Fixed crashes for some users.
Added EnableComplexFilter parameter for ambient occlusions to reduce noise.

Version 0.244: Optimized ambient occlusions. Fixed darker textures bug for amd users.

Version 0.243: Added occlusion culling performance optimization which partially work at this moment in
exteriors, it can be toggled by new parameter EnableOcclusionCulling in enblocal.ini.
Added VSyncSkipNumFrames parameter to enblocal.ini for users with high refresh rate
displays who need to limit game performance (game physics work wrong at high fps).
Did workaround for AMD driver bug of lower water displacement amplitude compared
to NVidia cards, at cost of performance and not working filter quality parameter,
but for NVidia users nothing is changed.

Version 0.241: Added volumetric rays. Fixed image based lighting bug and flickering sun, disabled sun
drawing below horizon. Added opacity parameter for cloud shadows. Renamed parameter of
cloud shadows activation. Added separate parameter for water volumetric shadows.
Increased water displacement pefformance. Added parameter DisplacementFilterQuality
to control performance of water displacement.

Version 0.240: Added shadows from clouds (can't be enabled in editor while playing,
similar to sky lighting).

Version 0.239: Added muddiness control for water. Changed blending of various effects
to draw them without affecting transparent objects like smoke, fire and volumetric fog.

Version 0.236: Added volumetric shadows for underwater lighting, fixed incorrect deepness fade factors.
Underwater require helper plugin, download it here http://www.dev-c.com/skyrim/enbhelper/

Version 0.235: Added new underwater parameters and effects. Volumetric lighting, darker
deepness, tint multipler, etc.

Version 0.234: Tweaked water filter to reduce ssao and other screen effects. Added
underwater parameters. Various other changes to water.

Version 0.233: Added water displacement, which is parallax occlusion culling at this moment.
Added water lighting and specular from sun control. Removed ForceFakeVideocard mode.
Added waves amplitude parameter dependent from weather and time of the day, modified
old parallax code.

Version 0.231: Added fake self reflection for water and some minor internal fixes.

Version 0.229: Added parallax for water, it use alpha channel of normal maps, check if your favorite
water mod is updated or edit it textures yourself.
Did temporary workaround for critical AMD drivers bug when water enabled, at cost of
performance of other effects (very noticable with old videocards like gf9600).
Added fix of cursor visibility (new parameter in enblocal.ini), because users reported
incompatibility of ENBSeries with such mod.

Version 0.228: Added water caustics and some other things. Fixed game bug with ibl in
water when ambient occlusion disabled.

Version 0.227: Added water category in enbseries.ini. Fixed some particles to allow edit
them. Fixed game bug with sky reflection in water.

Version 0.226: Added support for external helper plugin which replace helper mod functionality, so
per weather setting are now available. Download it from http://alexander.sannybuilder.com
Fixed distance fog for particles and volumetric fog above mountains, linked background
color to fog parameters under [ENVIRONMENT] category of enbseries.ini to reduce graphic
artifacts.

Version 0.224: Added parameter of shadow blurring range for interiors and denoiser for
ambient occlusions. Fixed parallax for some interiors.

Version 0.223: Added parameter to disable compression of memory manager to reduce
stuttering while objects are loading at cost of memory usage.
Removed [CAMERAFX] category from enbseries.ini, added [LENS] category and separate
enblens.fx shader with enblensmask image. Removed lens reflection code from enbbloom.fx.
Added FieldOfView variable to shaders.

Version 0.221: Optimized a little subsurface scattering, added quality options of it
(require "save" and then "apply" button to be pressed in editor). Added separate parameters
of vanilla subsurface scattering control for eyes only. Removed depth of field fix
which added in previous version and which not working for some users.

Version 0.220: Removed most of fixes for subsurface scattering of previous version as they produce
artifacs with many modified bodies and some vanilla hairs. Added another fixes instead.
Subsurface scattering effect performance increased.

Version 0.219: Did various fixes to graphic bugs of detailed shadows, subsurface
scattering, ssao, hairs. Subsurface scattering effect still the same as in previous
version, only quality fixes applied.

Version 0.217: Added subsurface scattering effect (new parameters in enbseries.ini),
it work only when deffered rendering enabled. I recommed to set SubSurfaceScatteringMultiplier
under [OBJECT] category to zero, because that original game SSS. Quality of SSS
not yet working, code is not optimized, i'm waiting responses on the forum.
Fixed distant foggy objects (at some weathers) by applying fade.

Version 0.217: Added support of shader parameters precision via "UIStep" annotation.
Added support of shader techniques names via "UIName" annotations to allow users
select shaders. Ask preset makers to adopt their code to new features.

Version 0.215: Moved [FIX] and [ANTIALIASING] categories from enbseries.ini to enblocal.ini.
Added parameter EnableSunGlare which toggling enbsunsprite.fx shader functionality.
Added EnableTransparencyAA parameter which enable hardware transparency antialiasing
for certain types of objects (grass, hairs) when antialiasing enabled in game video
options, otherwise it use slower approximation for antialiasing.
Added color correction filters (gamma, brightness, contrast, saturation, balance, etc)
to enbeffect.fx file with editable variables in editor.
Modified edge antialiasing to affect color differencies, not just edges.

Version 0.214: Modified a little memory to increase game stability. Added support of
loading images in external shaders via annotations. Removed PhysicsFix parameter.

Version 0.213: Restored memory manager statistics from 0.209-0.211 version, seems
it was better for some users. Temporal antialiasing now do not require helper mod
(sli/crossfire not supported).

Version 0.212: Removed warning message at start which notify than incompatible
software detected, instead stopped all tech support for CTDs (crashes to desktop)
and freezes. Modified memory manager, it will free memory automatically when frame
rate is low and also long freezes replaced by CTDs. Added parameter FixAliasedTextures
to reduce aliasing of snow on mountains and other similar objects. Added EnableSubPixelAA
parameter which in this version apply supersampling to specular.

Version 0.211: Protection against crapware replaced by message at start.

Version 0.210: Added protection against crapware

Version 0.209: Restored memory manager code from version 0.207, because 0.208 prooved
that i don't need to listen everybody. Tweak yourself VideoMemorySizeMb.

Version 0.208: Restored most of memory manager code from version 0.201.

Version 0.207: Fixed low performance of memory manager for some combinations of high-end
videocards and drivers. Reduced stuttering.

Version 0.206: Improved performance of wrong textures bugfix to reduce stuttering.

Version 0.205: Again tweaks made to dynamic reallocation of memory.

Version 0.204: Another tweaks made to dynamic reallocation of memory. Report on the forum results of
this version with ReduceMemoryUsage=true, compared to previous. Tried to fix freezes
of previous version, hope it work properly now. Fixed parallax for some locations without
shadows and sky.

Version 0.202: Improved dynamic reallocation of memory reducing code. I recommend to backup version
0.201 before trying this one, as not yet sure which have less stuttering with memory
reducing enabled.

Version 0.201: Added dynamic reallocation to memory reducing code. New parameter DisablePreloadToVRAM
allow to skip some issues with loading game when not enough video memory available.
Added hotkey to free video memory (by default it's not set, modify [INPUT] category).
Memory handling code was updated several times for this version, also in latest update
i fixed game bug which happen when incorrect modded textures used, but at cost of
lags when cells is loading and longer loading of saved games, may be later i'll reduce
it, but without such fix game crashing. Added outlines fix for Real Clouds mod.

Version 0.200: Made first version of memory reducing code for 64-bit systems which
allow to use more than 4 Gb memory via enbhost.exe helper process. Recommended for users
with 8 Gb or greater amount of RAM. Feature active when ReduceSystemMemoryUsage=true
and EnableUnsafeMemoryHacks=false. Restored EnableUnsafeMemoryHacks parameter, when
it's enabled alt+tab not work for fullscreen mode, but it's best solution for users
with RAM amount 4 Gb or less and 2 Gb or greater VRAM at same time. Fixed internal
screenshot capturing for supersampling mode and increased it's performance. Fixed
fps limiter which not worked properly for some users. Added FixPhysics parameter,
which actually fps limiter for very short frames, highly recommended to use it,
because game physics start to work strange when frame rate is very high. Also
applied fast compression to memory blocks in this version to make more stable
even when enbhost.exe not running or with 32-bit systems.

Version 0.199: Disabled memory reducing feature for Creation Kit to fix crash.
Changed number to key names for [INPUT] category of editor. Removed key for
recompilation of shaders as editor have "apply button for that". Added
AddDisplaySuperSamplingResolutions parameter which at this moment add one
fullscreen resolution x2 times bigger than desktop resolution and if it's
selected, game will run in borderless window mode with downsampling (feature
is not recommended for non experienced users).

Version 0.198: Improved memory reducing feature, now it should work better for
AMD users and probably less stuttering. New variable ReservedMemorySizeMb added
to enblocal.ini file and EnableUnsafeMemoryHacks removed.

Version 0.197: Improved declaration of shaders variables for editing them in the
game. Added color, quality and vector types of hlsl annotations. Modified shaders
and textures loading code to prefer loading them from "enbseries" folder and if
not found, then from main folder. Fixed non working palette texture bug of previous
version. Added new variable EAdaptiveQualityFactor for shaders, may be their
authors will do changes.

Version 0.196: Added declaration of shaders variables for editing them in the
game. Default shaders don't have HLSL standart annotations, so they will not
show parameters in GUI, i'll update them later. Shaders now can be loaded
from "enbseries" folder.

Version 0.193: Added EnableUnsafeMemoryHacks parameter to enblocal.ini config
which activate officially unsupported by drivers memory reducing feature, it's
invalid, but working as temporary solution. Added adaptive quality parameters
which modify some effects if frame rate lower than desired.

Version 0.193: Added memory reducing feature to partially fix crashes when many
mods installed or moving fast in environment, parameter ReduceSystemMemoryUsage=true
enabling such a fix. If this will not be enough, i'll do different changes.
Added UsePatchSpeedhackWithoutGraphics variable to enbseries.ini which allow
to disable all graphic changes in the mod and free it's resources. The goal of
this is to use patch features of the mod (memory fix, speed hack, frame limiter,
etc). Mod is faster than vanilla game when UsePatchSpeedhackWithoutGraphics=true
or when it's disabled via UseEffect=false. Improved frame limiter to make it
more stable, which is important when vsync disabled. Increased performance of
reflections, did cpu optimizations. Removed SkipShaderOptimization parameter.
Replaced all quality parameters in GUI by their text named drop down boxes.
Added new GUI window and moved in to there buttons "save configuration",
"load configuration". Also added button "apply changes" which reloading and
recompiling all data (same as Backspace key usage).

Version 0.192: Added memory reducing feature to partially fix crashes when many mods installed
or moving fast in environment, parameter ReduceSystemMemoryUsage=true enabling
such a fix. If this will not be enough, i'll do different changes.
Added UsePatchSpeedhackWithoutGraphics variable to enbseries.ini which allow to
disable all graphic changes in the mod and free it's resources. The goal of this
is to use patch features of the mod (memory fix, speed hack, frame limiter, etc).
Mod is faster than vanilla game when UsePatchSpeedhackWithoutGraphics=true or when
it's disabled via UseEffect=false.
Improved frame limiter to make it more stable, which is important when vsync disabled.
Increased performance of reflections, did cpu optimizations.
Removed SkipShaderOptimization parameter. Replaced all quality parameters in GUI
by their text named drop down boxes. Added new GUI window and moved in to there
buttons "save configuration", "load configuration". Also added button "apply changes"
which reloading and recompiling all data (same as Backspace key usage).

Version 13.7.13: Small performance improvement of ssao effect for videocard with low
memory bandwidth. Did workaround for NVidia 320.xx drivers to fix sun visibility and
some other issues, now it work on Win7. Replaced ldr mask texture by hdr texture for
enbsunsprite.fx shader, also it's now use color of sun (masked by clouds).

Version 0.188: Did workaround for NVidia 320.xx drivers to fix sun visibility
and some other issues. Unfortunately it work only with WinXP drivers.

Version 0.187: Added ssao/ssil code from version 0.119 and it controlled by new
parameter UseOldType, it's a bit faster than latest version and probably better
for characters, but not support complex ambient occlusion mode. Fixed bug with
not updated parameters via backspace key, now they work at cost of huge delay
while pressing reload button.

Version 0.186: Improved quality of reflections effect and it's performance.

Version 0.185: Fixed various bugs. Added EnableVSync parameter (turned on by default),
added parameter UseDefferedRendering which turned off disable several effects, but
performance impact is minimal to allow users with low end videocards to run the
mod. Added denoiser 4 for reflections. Optimized performance of various effects,
still in progress doing this.

Version 0.183: Improved performance of grass and trees rendering.

Version 0.182: Fixed glowing edges artifact when detailed shadows enabled, added new
ssao mixing types and parameter to enable indirect lighting for ambient color.

Version 0.178: Fixed bug of non additive fire blending mode for distant windows,
minor improvements of soft particles effect. Added lights from particles effect
with it's parameters, at this moment candles and some fire types emit lights only.

Version 0.177: Fixed bugs of new ambient color filter, fixed ColorPow bug. Added soft
particles computation to some types of them.

Version 0.175: Fixed vanilla bug of subsurface scattering (glowing edge on characters),
added ambient top and bottom colors. Replaced sun color filter variables by single rgb,
so old variables are obsolette.

Version 0.172: Improved temporal antialiasing, added new parameters for weather and
time of the day separation.

Version 0.171: Added weather system which allow to edit parameters per game weather. All weather
configurations placed in folder "enbseries". Check it out to see how to make own
presets. Weather system can be toggled on/off in main configuration file in the
new category [WEATHER].

Version 0.170: Added weather system which allow to edit parameters per game weather. All weather
configurations placed in folder "enbseries". Check it out to see how to make own
presets. Weather system can be toggled on/off in main configuration file in the
new category [WEATHER].
To use weather system, download helper mod http://skyrim.nexusmods.com/mods/36318/
and place it to "Data" folder of the game (native Skyrim mod).

Version 0.169: Added [TIMEOFDAY] category (disabled by default) to control parameters much more
precisely from game time data. Old [DAYNIGHT] is used for sky or background color
capturing as day/night factor, it's still active for shaders variable and used
when time of day not enabled or time of day failed to read game time. Also old
method ignore all new variables and only xxxDay/xxxNight/xxxInteriorDay/xxxInteriorNight
active for it. Per weather interpolator and weather configs not active in this
version, because not sure yet that new parameters are important to users or may
be not enough.

Version 0.168: Fix for sun sprite (visible on screen always).

Version 0.166: Minor changes to fix strange performance issues for some users, at least trying as
i can't test myself. Temporal antialiasing removed, because helper mod do not work
properly at all conditions.

Version 0.159: Beta for testing of low quality temporal antialiasing and require
additional mod to work properly, download it from http://skyrim.nexusmods.com/mods/34485

Version 0.157: Fixed minor bugs, enbsunsprite shader rendering moved after
enbeffectprepass, optimized shaders for grass and trees in viewport and for
shadows rendering, added performance profiler for most effects to GUI.

Version 0.155:
Fixed ssao interior bug.

Version 0.154 beta:
Did optimization, fixed minor bugs. Not sure if this version work correctly like
previous, so it's beta.

Version 0.153:
Implemented complex ambient occlusion mode. Added controls for rain drops and their
refraction (example textures enbraindrops). Added fix to remove game blur for foggy
weather and for background in menu. Minor fixes of potential bugs with shadows.

Version 0.152:
Added IBL effect. Increased quality of sky lighting effect. Fixed bug of indirect
lighting which appear in previous version.


Version 0.151:
Exterior detailed shadows tweaked to be independent from shadow drawing distance
from skyrimprefs.ini file. Changed ssao code, optimized it a little, added new
parameters for ssao/ssil, new AOType added, UseComplexIndirectLighting is now
working (disable it to increase performance).

Version 0.149:
Changed ssil math, it's ignore ambient lighting now.
Mostly cosmetic changes. Added specific parameters under [FIX] category of enbseries.ini
to toggle new fixes. Obsolete parameters removed. Also added reflection selector
for interior and exterior scenes as some users don't want them in exteriors.

Version 0.148:
Mostly cosmetic changes. Added specific parameters under [FIX] category of enbseries.ini
to toggle new fixes. Obsolete parameters removed. Also added reflection selector
for interior and exterior scenes as some users don't want them in exteriors.

Version 0.146:
Optimized ssao/ssil new filters and fixed water transparensity with these effects enabled.

Version 0.145:
Effect ssao/ssil changed and new filter types of it added.

Version 0.144:
Improved quality and changed effect ssao/ssil and reflection. Added new parameters
for reflection.

Version 0.143:
Fixed some bugs, added subsurface scattering controls for vegetation. To simplify
compability with old presets (because of latest changes in night/day detector)
added new parameter DetectorOldVersion.

Version 0.141:
Beta is for comparing modified ssao/ssil effect (wip).

Version 0.139:
Fixed bug with inverted EInteriorFactor variable in shaders, modified day/night
interpolator to make smoother transitions, added statistics for day/night in GUI,
fixed secondary user config reading (it was corrupted after GUI was done), some
other minor fixes reported by users.

Version 0.138:
Added separated day and night parameters for interior in enbseries.ini, old are removed.

Version 0.136:
Improved ssao performance and quality, added video memory statistics, bugfixes

Version 0.131:
Fixed fog for water, added new category [PARTICLE] to control many transparent
objects (including waterfall particles).

Version 0.130:
Added Edge AA instead of hardware antialiasing (MSAA), which not supported in
all versions after 0.119. Unfortunately changes made in 0.129 beta produce
artifacts for some users, this is not fixed yet, because of no testers.

Version 0.126:
This version differ from 12.12.12 by GUI implemented. To activate it press together
SHIFT and ENTER keys. Some variables can't be changed in GUI, better not to touch
quality parameters at this moment, they are not dynamic.
In version 0.126 vs 0.125 added some interior variables for ambient occlusion
properties; different frame limiter code (it worked wrong for some users); GUI
editing now allow keyboard input for changing values.

Version 0.125:
Internal GUI implemented to simplify editing presets.

Version 12.12.12:
Optimized reflections. Fixed some minor bugs

Version 0.123:
Reflections implemented, they aren't good quality and very slow now and only for testing
purposes if they fit TES Skyrim or not. Also fixed bug when AOMixingType set 2.

Version 0.122:
Parallax fix changed to different and now don't have specular artifacts (see parallax.txt).
Ssao and ssil quality increased and changed their mixing to scene methods (added new variables).
There are many other changes, which i don't remember and never do logs, sorry. Reflections
are not yet finished. Bug with bright silhouettes around objects very annoying, but i'm still
searching better algorithm to detect edges for bilateral filter for various distances.
And finally, performance is from v0.121, except ssao.

Version 0.121:
Performance and quality optimizations, mostly.

Version 0.119:
Added parameters for tweaking interior separately. Old *Day and *Night variables are
now only for exterior scenes.
Added to shaders variable EInteriorFactor for toggling between interior and exterior
scenes.

Version 0.117:
To fix issue with bright hair added new parameter GammaCurve which is equal to parameters
ColorPowDay and ColorPowNight, but apply to entire screen and should replace those two.
But global usage of this variable may require changes in most of other parameters. Also
new global variable is Brightness.
Added fake clouds scattering on their edges, similar to Fallout New Vegas and GTA 4 versions.
Parameters for this effect are CloudsEdgeClamp and CloudsEdgeIntensity.
This version have all previous bug fixes and new feature is programmable lenz fx or any
other sprites for sun only. New external shader file named enbsunsprite.fx and it use
texture for computations named enbsunsprite.tga, enbsunsprite.png or enbsunsprite.bmp.
This effect is done for modders who know how to edit shaders, probably later i'll create
my own, but at this moment there are many other things not implemented yet (depth of
field effect is also still as example for modders and some of them did good fx).

Version 0.114:
Test of sky lighting effect (fake ambient occlusion), everything else is almost 0.113.
To work correctly, sky lighting require rendering objects to shadow, so edit manually
following lines in file SkyrimPrefs.ini:
bTreesReceiveShadows=1
bDrawLandShadows=1
bShadowsOnGrass=1
And make sure that bFloatPointRenderTarget=1 is set in same file.
New parameters:
UseOriginalObjectsProcessing turn off all per object changes of the mod for those, who
wish to use only parallax fix or some other components without radical changes to graphic.
FixGameBugs is bugfix of underwater and grass bugs of game patch 1.5.26.0 for ATI users.
FixParallaxBugs fix game bugs when parallax mod installed, temporary for NVidia only.
AntiBSOD and SpeedHack increasing performance in some locations.
UseComplexIndirectLighting affect performance of ssao if UseIndirectLighting=true, but
quality of indirect lighting is lower.
EnableDetailedShadows temporary for NVidia only, new effect which increase shadow details
(video as example http://youtu.be/9uG-s9cuPPM)
ShadowCastersFix some huge objects or mountains cast shadows more correctly.
ShadowQualityFix temporary for NVidia only, decreasing noise of game shadows by little
cost of performance.
DetailedShadowQuality temporary for NVidia only, greatly affect performance of shadows.
UseBilateralShadowFilter temporary for NVidia only, reduce blurred edges of shadows
artifact which exist in original game.

Version 0.113:
Difference between new and previous version is sun rays effect.
This version is similar to 0.103, but with new shadow effect, bugfix for parallax,
optimization. Performance in this version optimized for ATI videocards also, but
i don't have hardware for testing, so not sure how it work on practice. Do not set
ForceFakeVideocard=true in this version, it's now for bugfixing mode and will be removed
later. Parallax bugfix also should work for ATI users (mod is here http://skyrim.nexusmods.com/downloads/file.php?id=16919).
Partially changed code of SSAO and Indirect Lighting mix for better quality, modified
method of computing distance fade factors of these effects (FadeFogRangeDay, FadeFogRangeNight).
Changed detailed shadow quality presets (-1 is extreme, 0 is high, 1 is middle, 2 is low)
for better details.

Version 0.110:
Similar to 0.103, but with new shadow effect, bugfix for parallax, optimization.
Best performance with NVidia cards temporary, but ATI users also may use this version,
it have fixes for bugs of 1.5.26.0 patch (set ForceFakeVideocard=true).
For NVidia users this version do not create fake videocard "ENB", so you must redetect
graphic options by game launcher if previously used modification 0.103 or earlier version.

Version 0.109:
Test beta version for NVidia cards with huge optimization.

Version 0.108:
Simplified version with many effects removed, but performance is very high.

Version 0.105, 0.106:
Optimized code to make it less cpu dependent.

Version 0.103:
Implemented experimental code of injector instead of standart d3d9 wrapper. This
may be useful for users with Optimus laptops or for those, who using overlay tools
like EVGA, Afterburn, D3D Overrider, XFire and others. Graphic changes are only get
back to SSAO code from version 0.099 with minor update of indirect lighting intensity.

Version 0.102 Tatsudoshi:
Fixed few bugs, most work is done for increasing performance (not all yet). Many
bugs of previous version is still here, i'll fix them later.

Version 0.101:
Fixed bugs of previous version (at least what is see). Added code of programmable
external depth of field effect (only added, but "todo"). With ne enbeffectprepass.fx
shader file you can make more than just depth of field, it's executed before enbeffect.fx
and working with hdr values in multipass mode (up to 8 passes). Changed standart of
external shaders, removed ScreenScaleY and ScreenSize replaced by vector of 4 values.
Most of old effects will not work, replace in them ScreenScaleY with ScreenSize.z
and float ScreenSize; with float4 ScreenSize;. Increased quality of bloom and removed
parameters of radius 1 and 2 for it.

Version 0.100:
Removed parameter CyclicConfigReading (it read configuration file every 5 seconds),
from now this will be handled by pressing a button BACK (can be changed KeyReadConfig).
Added almost all code from my patch AntiFREEZE TES Skyrim 0.096, including most
of it parameters. FPS limiter implemented, fps counter. Screenshot capturing is back,
but different key assigned.
SSAO effect now have additional "lite" version. To switch it setup parameter
UseIndirectLighting=false in enbseries.ini file and restart the game. Added values
to control SSAO distance relative to fog distance. Night and day time are separated.
Properties for adaptation in enbseries.ini are finished, but they are partially
clamped by limits in enbeffect.fx, so if you wish to control by enbeffect.ini only,
remove limit code in shader (or wait when i'll post new shader). Added parameters
for SubSurfaceScattering to reduce lighting in shadows for characters and ugly thin
line on them (game bug). Added parameter for control of lights from windows, but
it affect some fx, for example freeze spell. Added ShadowObjectsFix to apply
shadows from mountains properly. Various bug fixes. SSAO work with antialiasing.

Version 0.099:
Fixed crash in the evening. Added palette texture support (enbpalette.bmp, tga,
png files). Removed code for screenshot capturing. SSAO disabled by default, activate
it in enbseries.ini, parameter UseAmbientOcclusion=true and make sure antialiasing
is not enabled by game or drivers. Not tested with other d3d9.dll files and they are
not supported now.

Version 0.098:
Implemented code from AntiFREEZE patch to fix some game bugs and increase
stability with this mod. Added parameters to control environmental fog.

Version 0.097:
I'm going to be crazy with fixing game bugs for make it work with ENBSeries,
official patches destroy my progress every time, so i decided to release "light"
version. Crashes of the game 1.1 happening very frequently (at least on my PC),
they are not internal modification errors. Hardware antialiasing (multisampling)
unsupported at this moment, so to make SSAO work properly, disable antialiasing (msaa).
Optimization not applied, same as in any other first versions of ENBSeries, if
you wish to get higher framerate, turn off SSAO or decrease quality of it. Game
have some strange mistakes which aren't fixed yet, for example in interior locations
direct light enabled and applied from bottom or from side (sun, uh?), so increaing
intensity of it is not good idea, better to decrease all other values together and
increase overall brightness in post processing shader enbeffect.fx. Users, who already
tweaked parameters for GTA 4 version will not have much problems with this one.
Do not change SubSurfaceScattering parameters, game have bug for characters and i'll
fix it when latest official patch will be released (bright thin line on skin).




//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//INSTALL
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Extract files from folder WrapperVersion or InjectorVersion to your game folder.
If you wish to use injector version as workaround for various third party software
and for laptops, run ENBInjector.exe before starting the game.
WARNING! Don't run manually enbhost.exe, it will be automatically started if memory
manager activated in enblocal.ini.

Extract files from archive in to the game directory or where game execution file exist (.exe).
Run game launcher to reconfigure it again.



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//PROBLEMS
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
If game crashing on startup, make sure you are not running XFire, Afterburner, EVGA and
other kind of that tools. Antiviruses and various fake boosters also affect mod wrong way.



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//HACKS
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Hacks are specific properties of objects and other tricks to let ENBSeries know that
something must be processed differently.
Warning! EmissiveMultiple=0.0010 and EmissiveColor not equal to zero are reserved
for hacks.
1) Reflection hack - disable reflection for objects, some hairs for example.
To activate it, edit model nif file and set EmissiveMultiple =0.0010, EmissiveColor
green component must be set to value above 0.5, so upper bit flag is 1 (0x80 in hex);
red component must be 1.0000 (0xff in hex), lower values also will work, but they will
be used for different hacks, so not recommended.



//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Using AntTweakBar middleware
Copyright (C) 2005-2011 Philippe Decaudin
AntTweakBar web site: http://www.antisphere.com



http://enbdev.com
Copyright (c) 2007-2015 Vorontsov Boris (ENB developer)
