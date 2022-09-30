![](https://github.com/Joalor64GH/Chocolate-Engine/blob/master/art/Chocolate-Engine-Logo.png?raw=true)

# FNF - Chocolate Engine

This is the repository for Chocolate Engine, which is basically a fork of the original FNF.

Also, the readme is currently in a WIP.

## Things to get done
* [ ] Fix the Main Menu and Credits Menu
* [ ] Options

## Credits

* [Joalor64 YT](https://github.com/Joalor64GH) - Main Programmer
* [MemeHoovy](https://github.com/MemeHoovy) - Assistant Coder
* [RozeBud](https://github.com/ThatRozebudDude) - FPS Plus Input
* [PolybiusProxy](https://github.com/polybiusproxy) - MP4 Video Support
* [Ninjamuffin99](https://github.com/ninjamuffin99) - The Base Game (WOULD NOT BE POSSIBLE WITHOUT HIM)
* [Lars Doucet](https://github.com/larsiusprime) - Polymod

## Building

How to build the funny game or something

### Installing Stuff

First, install Haxe (USE 4.1.5 BRUH) and HaxeFlixel.
* [Haxe](https://haxe.org/download/version/4.1.5/)
* [HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/)

Then, install these or something:
```
flixel
flixel-addons
flixel-ui
hscript
```
Then, these I think:
1. Download [git-scm](https://git-scm.com/downloads). Works for Windows, Mac, and Linux, just select your build.
2. Follow instructions to install the application properly.
3. Run `haxelib git polymod https://github.com/larsiusprime/polymod.git` to install Polymod.
4. Run `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc` to install Discord RPC.
5. Run `haxelib git hxCodec https://github.com/polybiusproxy/hxCodec` to install hxCodec.

Everything should be ready. You can continue from here.

### More Things

At the moment, you can optionally fix the transition bug in songs with zoomed-out cameras.
- Run `haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons` in the terminal/command-prompt.

And you should be good to go.

### Compilation

Once you have all those installed, it's pretty easy to compile the game. You just need to run `lime test html5 -debug` in the root of the project to build and run the HTML5 version. (command prompt navigation guide can be found here: [https://ninjamuffin99.newgrounds.com/news/post/1090480](https://ninjamuffin99.newgrounds.com/news/post/1090480))
To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run `lime test linux -debug` and then run the executable file in export/release/linux/bin. For Windows, you need to install Visual Studio Community 2019. While installing VSC, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)

Once that is done you can open up a command line in the project's directory and run `lime test windows -debug`. Once that command finishes (it takes forever even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin
As for Mac, 'lime test mac -debug' should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.

### Additional guides

- [Command line basics](https://ninjamuffin99.newgrounds.com/news/post/1090480)
