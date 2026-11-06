#!/bin/sh

set -e
set -x

if [ ! -f ./bin/chatterino ] || [ ! -x ./bin/chatterino ]; then
    echo "ERROR: No chatterino binary file found. This script must be run in the build folder, and chatterino must be built first."
    exit 1
fi

if [ -n "$Qt6_DIR" ]; then
    echo "Using Qt DIR from Qt6_DIR: $Qt6_DIR"
    _QT_DIR="$Qt6_DIR"
elif [ -n "$Qt5_DIR" ]; then
    echo "Using Qt DIR from Qt5_DIR: $Qt5_DIR"
    _QT_DIR="$Qt5_DIR"
fi

if [ -n "$_QT_DIR" ]; then
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${_QT_DIR}/lib"
    export PATH="${_QT_DIR}/bin:$PATH"
else
    echo "No Qt environment variable set, assuming system-installed Qt"
fi

script_path=$(readlink -f "$0")
script_dir=$(dirname "$script_path")
chatterino_dir=$(dirname "$script_dir")

echo "Running LDD on chatterino binary:"
ldd ./bin/chatterino || true
echo ""

echo "Running make install in the appdir"
make install
echo ""

# Copy icons & desktop files
cp "$chatterino_dir"/resources/icon.png ./appdir/chatterino.png
cp "$chatterino_dir"/resources/icon.png ./appdir/com.chatterino.chatterino.png
ln -sf com.chatterino.chatterino.png ./appdir/.DirIcon
cp ./appdir/usr/share/applications/com.chatterino.chatterino.desktop ./appdir/com.chatterino.chatterino.desktop
cp ./appdir/usr/share/applications/com.chatterino.chatterino.desktop ./appdir/chatterino.desktop || true

# Copy libc copyright file
mkdir -p appdir/usr/share/doc/libc6/
cp /usr/share/doc/libc6/copyright appdir/usr/share/doc/libc6/ 2>/dev/null || true

export APPIMAGE_EXTRACT_AND_RUN=1

linuxdeployqt_path="./linuxdeployqt-x86_64.AppImage"
linuxdeployqt_url="https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"

if [ ! -f "$linuxdeployqt_path" ]; then
    echo "Downloading LinuxDeployQT from $linuxdeployqt_url to $linuxdeployqt_path"
    curl --location --fail --retry 3 "$linuxdeployqt_url" -o "$linuxdeployqt_path"
    chmod a+x "$linuxdeployqt_path"
fi

appimagetool_path="./appimagetool-x86_64.AppImage"
appimagetool_url="https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"

if [ ! -f "$appimagetool_path" ]; then
    echo "Downloading AppImageTool from $appimagetool_url to $appimagetool_path"
    curl --location --fail --retry 3 "$appimagetool_url" -o "$appimagetool_path"
    chmod a+x "$appimagetool_path"
fi

echo "Run LinuxDeployQT"
"$linuxdeployqt_path" \
    --appimage-extract-and-run \
    appdir/usr/share/applications/com.chatterino.chatterino.desktop \
    -no-translations \
    -bundle-non-qt-libs \
    -unsupported-allow-new-glibc \
    -verbose=1 || true

rm -rf appdir/home
rm -f appdir/AppRun

echo "Writing portable AppRun launcher script"
cat << 'EOF' > appdir/AppRun
#!/bin/sh
set -e
HERE="$(dirname "$(readlink -f "${0}")")"
export PATH="${HERE}/usr/bin:${PATH}"
export LD_LIBRARY_PATH="${HERE}/usr/lib:${HERE}/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export QT_PLUGIN_PATH="${HERE}/usr/plugins"
export QT_QPA_PLATFORM_PLUGIN_PATH="${HERE}/usr/plugins/platforms"
export XDG_DATA_DIRS="${HERE}/usr/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
cd "${HERE}/usr"
exec "${HERE}/usr/bin/chatterino" "$@"
EOF
chmod a+x appdir/AppRun

echo "Run AppImageTool"
ARCH=x86_64 "$appimagetool_path" \
    --appimage-extract-and-run \
    appdir \
    NekoChatterino-x86_64.AppImage

chmod +x NekoChatterino-x86_64.AppImage

echo "Create portable tarball"
mkdir -p NekoChatterino
cp -r appdir/* NekoChatterino/
tar -czf NekoChatterino-linux-x86_64.tar.gz NekoChatterino
rm -rf NekoChatterino

echo "Checking created artifacts:"
ls -lh NekoChatterino-x86_64.AppImage NekoChatterino-linux-x86_64.tar.gz

if [ ! -f NekoChatterino-x86_64.AppImage ]; then
    echo "ERROR: NekoChatterino-x86_64.AppImage was not created!"
    exit 1
fi

if [ ! -f NekoChatterino-linux-x86_64.tar.gz ]; then
    echo "ERROR: NekoChatterino-linux-x86_64.tar.gz was not created!"
    exit 1
fi

echo "Linux packaging completed successfully!"
