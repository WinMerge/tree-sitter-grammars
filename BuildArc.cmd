cd /d "%~dp0"

set VERSION=0.1.4
set DISTDIR=.\Dist
set path="%ProgramFiles%\7-zip";"%ProgramFiles(x86)%\7-zip";%path%

if "%1" == "" (
  call :BuildArc x86 || goto :eof
  call :BuildArc x64 || goto :eof
  call :BuildArc ARM || goto :eof
  call :BuildArc ARM64 || goto :eof
) else (
  call :BuildArc %1 || goto :eof
)

goto :eof

:BuildArc

mkdir "%DISTDIR%\%1\TreeSitterGrammars\" 2> NUL

copy Build\%1\Release\TreeSitterGrammars\*.dll "%DISTDIR%\%1\TreeSitterGrammars\"
copy Build\%1\Release\TreeSitterGrammars\*.scm "%DISTDIR%\%1\TreeSitterGrammars\"
for /d %%i in (tree-sitter-*) do (
  mkdir "%DISTDIR%\%1\TreeSitterGrammars\%%i"
  copy %%i\LICENSE "%DISTDIR%\%1\TreeSitterGrammars\%%i"
)

7z.exe a -tzip "%DISTDIR%\tree-sitter-grammars-%VERSION%-%1.zip" "%DISTDIR%\%1\TreeSitterGrammars"

goto :eof
