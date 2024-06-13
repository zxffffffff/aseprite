rm -rf build
mkdir build
cd build

cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_ARCHITECTURES=arm64 \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=12.3 \
  -DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk \
  -DLAF_BACKEND=skia \
  -DSKIA_DIR=../Skia-macOS-Release-arm64 \
  -DSKIA_LIBRARY_DIR=../Skia-macOS-Release-arm64/out/Release-arm64 \
  -DSKIA_LIBRARY=../Skia-macOS-Release-arm64/out/Release-arm64/libskia.a \
  -DPNG_ARM_NEON:STRING=on \
  -G Ninja \
  ..
ninja aseprite