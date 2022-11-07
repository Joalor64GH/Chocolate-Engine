@echo off
title Chocolate Engine Setup - Start
echo Make sure Haxe 4.2.5 and HaxeFlixel is installed (4.2.5 is important)!
echo Press any key to install required libraries.
pause >nul
title Chocolate Engine Setup - Installing libraries
echo Installing haxelib libraries...
haxelib install lime 8.0.0
haxelib install openfl 9.2.0
haxelib --never install flixel 4.11.0
haxelib install flixel-addons
haxelib install flixel-ui
haxelib git hscript-yoshiengine https://github.com/YoshiCrafter29/hscript-improved
haxelib git hscript-ex https://github.com/ianharrigan/hscript-ex
haxelib run lime setup
haxelib install flixel-tools
title Chocolate Engine Setup - User action required
cls
haxelib run flixel-tools setup
cls
echo Make sure you have git installed. You can download it here: https://git-scm.com/downloads
echo Press any key to install polymod.
pause >nul
title Chocolate Engine Setup - Installing libraries
haxelib git polymod https://github.com/MasterEric/polymod
cls
echo Press any key to install LUA JIT.
pause >nul
title Chocolate Engine Setup - Installing libraries
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit
cls
echo Press any key to install HXVM LuaJIT.
pause >nul
title Chocolate Engine Setup - Installing libraries
haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
cls
echo Press any key to install Discord RPC.
pause >nul
title Chocolate Engine Setup - Installing libraries
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
cls
echo Press any key to install hxCodec.
pause >nul
title Chocolate Engine Setup - Installing libraries
haxelib git hxCodec https://github.com/polybiusproxy/hxcodec
cls
echo Press any key to install extension-webm and its component.
pause >nul
title Chocolate Engine Setup - Installing libraries
haxelib git extension-webm https://github.com/KadeDev/extension-webm
haxelib install actuate
cls
goto UserActions1

:UserActions1
cls
title Chocolate Engine Setup - User action required
set /p menu="Would you like to install Visual Studio Community and components? (Necessary to compile/ 5.5GB) [Y/N]"
       if %menu%==Y goto InstallVSCommunity
       if %menu%==y goto InstallVSCommunity
       if %menu%==N goto SkipVSCommunity
       if %menu%==n goto SkipVSCommunity
       cls


:SkipVSCommunity
cls
title Chocolate Engine Setup - Success
echo Setup successful. Press any key to exit.
pause >nul
exit

:InstallVSCommunity
title Chocolate Engine Setup - Installing Visual Studio Community
curl -# -O https://download.visualstudio.microsoft.com/download/pr/3105fcfe-e771-41d6-9a1c-fc971e7d03a7/8eb13958dc429a6e6f7e0d6704d43a55f18d02a253608351b6bf6723ffdaf24e/vs_Community.exe
vs_Community.exe --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK.19041 -p
del vs_Community.exe
goto SkipVSCommunity
