pushd %~dp0
powershell -executionpolicy remotesigned -file %~dp0\build-grammars.ps1 -Platform x86 -VisualStudioVersion 15.0 -XP
powershell -executionpolicy remotesigned -file %~dp0\build-grammars.ps1 -Platform x64 -VisualStudioVersion 17.0
powershell -executionpolicy remotesigned -file %~dp0\build-grammars.ps1 -Platform ARM -VisualStudioVersion 17.0 -WindowsSDKVersion 10.0.22621.0
powershell -executionpolicy remotesigned -file %~dp0\build-grammars.ps1 -Platform ARM64 -VisualStudioVersion 17.0

if exist "%SIGNBAT_PATH%" (
  call "%SIGNBAT_PATH%" Build\x86\Release\TreeSitterGrammars\*.dll
  call "%SIGNBAT_PATH%" Build\x64\Release\TreeSitterGrammars\*.dll
  call "%SIGNBAT_PATH%" Build\ARM\Release\TreeSitterGrammars\*.dll
  call "%SIGNBAT_PATH%" Build\ARM64\Release\TreeSitterGrammars\*.dll
)

popd
