#!/usr/bin/env bash
set -e

root_path=$(dirname $(readlink -f "$0"))
cd ${root_path}

# 1. 根据 INSTALL.md 查看 Skia 发布的依赖库
# https://github.com/aseprite/skia/releases

# 2. 更新 main 分支和子模块
git submodule update --init --recursive

# 3. 编译
rm -rf build
cmake -B build -S . \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_ARCHITECTURES=arm64 \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=12.3 \
  -DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk \
  -DLAF_BACKEND=skia \
  -DSKIA_DIR=Skia-macOS-Release-arm64 \
  -DSKIA_LIBRARY_DIR=Skia-macOS-Release-arm64/out/Release-arm64 \
  -DSKIA_LIBRARY=Skia-macOS-Release-arm64/out/Release-arm64/libskia.a \
  -DPNG_ARM_NEON:STRING=on \
  -G Ninja

cd ${root_path}/build
ninja aseprite

# 4. 制作 .app
cd ${root_path}/build/bin
mkdir -p aseprite.app/Contents/MacOS
mkdir -p aseprite.app/Contents/Resources
cp -f aseprite aseprite.app/Contents/MacOS/aseprite
cp -rf data aseprite.app/Contents/Resources/data
chmod +x aseprite.app/Contents/MacOS/aseprite

echo 编译完成：${root_path}/build/bin/aseprite.app
open ${root_path}/build/bin/
