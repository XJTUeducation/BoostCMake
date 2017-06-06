cd ..
mkdir buildx64
cd buildx64
mkdir vc10
cd vc10
cmake -G "Visual Studio 10 Win64" ../..

cd ../..

mkdir buildx86
cd buildx86
mkdir vc10
cd vc10
cmake -G "Visual Studio 10" ../..

cd ../..

cd scripts_vc
start cmd /k call buildRelease.bat buildx64/vc10
start cmd /k call buildDebug.bat buildx64/vc10
start cmd /k call buildRelease.bat buildx86/vc10
start cmd /k call buildDebug.bat buildx86/vc10

PAUSE