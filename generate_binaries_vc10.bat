mkdir buildx64
cd buildx64
cmake -G "Visual Studio 10 Win64" ..
cmake --build . --config Release --target install
cmake --build . --config Debug --target install
cd ..

mkdir buildx86
cd buildx86
cmake -G "Visual Studio 10" .
cmake --build . --config Release --target install
cmake --build . --config Debug --target install
cd ..

REM rd /s /q buildx64
REM rd /s /q buildx86

PAUSE