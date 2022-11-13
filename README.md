# This engine is in a major WIP state, report bugs in issues.

![](https://github.com/Joalor64GH/Chocolate-Engine/blob/master/art/Chocolate-Engine-Logo.png?raw=true)

# FNF - Chocolate Engine

This is the repository for Chocolate Engine, which is basically a fork of the [original FNF](https://github.com/ninjamuffin99/Funkin).
Not everything is perfect, so contributions and/or [pull requests](https://github.com/Joalor64GH/Chocolate-Engine/pulls) would be nice!

If you need a tutorial on modding, go check out [the wiki](https://github.com/Joalor64GH/Chocolate-Engine/wiki)!

## Downloads
* [itch.io](https://joalor64.itch.io/chocolate-engine)
* [GitHub](https://github.com/Joalor64GH/Chocolate-Engine/releases/latest)
* [Gamebanana](https://gamebanana.com/tools/10774)

## Features
* Polymod Support
* A LOT of Customizables
* Easy to Use Credits System (From Mag Engine)
* MP4 and WebM Video Support

## Things to get done
* [ ] Week 7 **[Is working but Stress is broken lmao]**
* [X] Reorganize all of the assets **[Completed]**
* [ ] Support for Lua Scripts
* [ ] Attempt to softcode characters
* [ ] Freeplay Colors

## Credits

* [Joalor64 YT](https://www.youtube.com/channel/UC4tRMRL_iAHX5n1qQpHibfg) - Main Programmer and Director
* [MemeHoovy](https://linktr.ee/memehoovy) - Assistant Coder and MemeHoovy Engine Code
* [Wither362](https://github.com/Wither362) - Assistant Coder and Fixer
* [LeviXDD](https://github.com/LEVIXDDLMAO) - HTML5 Handler 
* [ShadowMario](https://github.com/ShadowMario) - Psych Input
* [PolybiusProxy](https://github.com/polybiusproxy) - MP4 Video Support
* [Smokey](https://twitter.com/Smokey_5_) - Adobe Animate Texture Atlas Support
* [Sqirra-RNG](https://gedehari.github.io/) - Window Focus and Unfocus Code and Crash Handler
* [Leather128](https://github.com/Leather128) - Some Polymod Code
* [stephensrt](https://github.com/stephensrt) - Lots of Polymod Code and Mag Engine Code
* [KadeDev](https://twitter.com/kade0921) - Extension WebM and Kade Engine Code
* [Manux123](https://github.com/Manux123) - Cool Engine Code
* [MissingTextureMan101](https://twitter.com/OfficialMTM101) - Funkin Strawberry Code
* [Lars Doucet](https://github.com/larsiusprime) - Polymod
* [Ninjamuffin99](https://github.com/ninjamuffin99) - The Base Game (WOULD NOT BE POSSIBLE WITHOUT HIM)

## Building

How to build the funny game or something

### Installing Stuff

First, install Haxe (USE 4.2.5 BRUH) and HaxeFlixel:
* [Haxe](https://haxe.org/download/version/4.2.5/)
* [HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/)

Then, install these or something:
```
flixel
flixel-addons
flixel-ui
hscript
```
Then, these I think:
1. Download [git-scm](https://git-scm.com/downloads). Works for [Windows](https://git-scm.com/download/win), [Mac](https://git-scm.com/download/mac), and [Linux](https://git-scm.com/download/linux), just select your build.
2. Follow instructions to install the application properly.
3. Run `haxelib git polymod https://github.com/MasterEric/polymod` to install Polymod.
4. Run `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc` to install Discord RPC.
5. Run `haxelib git hxCodec https://github.com/polybiusproxy/hxCodec` to install hxCodec.

Everything should be ready. You can continue from here.

### More Things

At the moment, you can optionally fix the transition bug in songs with zoomed-out cameras.
- Run `haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons` in the terminal/command-prompt.

And you should be good to go.

### Compilation

Once you have all those installed, it's pretty easy to compile the game. You just need to run `lime test html5 -debug` in the root of the project to build and run the HTML5 version. (command prompt navigation guide can be found here: [https://ninjamuffin99.newgrounds.com/news/post/1090480](https://ninjamuffin99.newgrounds.com/news/post/1090480))
To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run `lime test linux -debug` and then run the executable file in export/release/linux/bin. For Windows, you need to install [Visual Studio Community 2019](https://visualstudio.microsoft.com/vs/older-downloads/). While installing VSC, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)

Once that is done you can open up a command line in the project's directory and run `lime test windows -debug`. Once that command finishes (it takes forever even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin
As for Mac, `lime test mac -debug` should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.

### Additional guides

- [Command line basics (newgrounds)](https://ninjamuffin99.newgrounds.com/news/post/1090480)
