@echo off
title Chocolate Engine Setup - Start
echo Make sure Haxe 4.1.5 and HaxeFlixel is installed (4.1.5 is important)!
echo Press any key to install required libraries.
pause >nul
title Chocolate Engine Setup - Installing libraries
echo Installing haxelib libraries...
haxelib install lime 7.8.0
haxelib install openfl 9.0.2
haxelib --never install flixel 4.8.1
haxelib install flixel-addons
haxelib install flixel-ui
haxelib install hscript
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
haxelib git polymod https://github.com/larsiusprime/polymod.git
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
set /p menu2="Would you like to automatically make the APIStuff file? [Y/N]"
       if %menu2%==Y goto APIStuffYes
       if %menu2%==y goto APIStuffYes
       if %menu2%==N goto APIStuffNo
       if %menu2%==n goto APIStuffNo
       cls

:APIStuffYes
rem Stores the APIStuff.hx contents automatically
cd source
(
echo package;
echo class APIStuff
echo {
echo         public static var API:String = "";
echo         public static var EncKey:String = "";
echo }
)>APIStuff.hx
cd ..
goto APIStuffNo


:APIStuffNo
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