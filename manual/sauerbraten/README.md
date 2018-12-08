# <img src="https://cdn.jsdelivr.net/gh/chocolatey/chocolatey-coreteampackages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/sauerbraten.png" width="48" height="48"/> [sauerbraten](https://chocolatey.org/packages/sauerbraten)


Cube 2: Sauerbraten is a free multiplayer & singleplayer first person shooter, the successor of the Cube FPS.

Much like the original Cube, the aim of this game is fun,
old school deathmatch gameplay and also to allow map/geometry editing to be done cooperatively in-game.

The engine supporting the game is entirely original in code & design, and its code is Open Source.

## Game Features
* Oldskool fast & intense gameplay (read: similar to Doom 2 / Quake 1).
* Many multiplayer gameplay modes, most in teamplay variants as well: deathmatch, instagib, efficiency, tactics,
capture (domination/battlefield style), CTF (capture the flag), coop edit (!).
* Masterserver & ingame server browser.
* Lag-free gameplay experience.
* Two singleplayer modes: DMSP (fight a monster invasion on any DM map), classic SP (progression driven SP like other games)
* 7 weapons tuned for maximum satisfaction: double barrelled shogun, rocket launcher, machine gun, rifle, grenade launcher, pistol, fist.

## Engine Features
* 6 directional heightfield in octree world structure allowing for instant easy in-game geometry editing (even in multiplayer, coop edit).
* Rendering engine optimized for high geometry throughput,
supporting hardware occlusion culling and software precomputed conservative PVS with occluder fusion.
* Lightmap based lighting with accurate shadows from everything including mapmodels, smooth lighting for faceted geometry, and fast compiles.
Soft shadowmap based shadows for dynamic entities.
* Pixel and vertex shader support, each model and world texture can have its own shader assigned.
Supports normal and parallax mapping, specular and dynamic lighting with bloom and glow,
environment-mapped and planar reflections/refractions, and post-process effects.
* Robust physics written specifically for this world structure.
* Loading of md2/md3/md5/obj/smd/iqm models for skeletal and vertex animated characters, weapons, items, and world objects.
Supports animation blending, procedural pitch animation, and ragdoll physics for skeletally-animated characters.
* Network library designed for high speed games, client/server network system.
* Small but complete configuration/scripting language.
* Simple stereo positional sound system.
* Particle engine, supporting text particles, volumetric explosions, soft particles, and decals.
* 3d menu/gui system, for in-world representation of choices.

