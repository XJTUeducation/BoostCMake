mkdir buildx64
cd buildx64
cmake -G "Visual Studio 10 Win64" ..
cmake --build . --config Release --target ALL_BUILD
REM cmake --build . --config Release --target RUN_TESTS
REM cmake --build . --config Debug --target install
cd ..

REM mkdir buildx86
REM cd buildx86
REM cmake -G "Visual Studio 10" .
REM cmake --build . --config Release --target install
REM cmake --build . --config Debug --target install
REM cd ..

REM rd /s /q buildx64
REM rd /s /q buildx86

PAUSE