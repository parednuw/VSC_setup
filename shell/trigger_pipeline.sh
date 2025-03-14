#!/bin/zsh
CONFIG='Debug'
PLUGIN_NAME='Reverb'
USER_PLUGIN_DIR="$HOME/Library/Audio/Plug-Ins"

if [ -d ../build ]; then
	echo "build folder found and deleted."
	rm -rf ../build
fi
if [ -d $USER_PLUGIN_DIR/VST3/$PLUGIN_NAME.vst3 ]; then
        echo "plugin vst3 found in user VST3 and deleted."
        rm -rf $USER_PLUGIN_DIR/VST3/${PLUGIN_NAME}.vst3
fi
if [ -d $USER_PLUGIN_DIR/Components/$PLUGIN_NAME.component ]; then
        echo "plugin component found in user Components and deleted."
        rm -rf $USER_PLUGIN_DIR/Components/$PLUGIN_NAME.component
fi
cmake -DCMAKE_BUILD_TYPE:STRING=$CONFIG -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE -S .. -B ../build -G "Unix Makefiles"
cmake --build ../build --config $CONFIG --target all -j 12

cp -R ../build/${PLUGIN_NAME}_artefacts/$CONFIG/AU/$PLUGIN_NAME.component $USER_PLUGIN_DIR/Components
cp -R ../build/${PLUGIN_NAME}_artefacts/$CONFIG/VST3/$PLUGIN_NAME.vst3 $USER_PLUGIN_DIR/VST3
echo "Copied plugin files to $USER_PLUGIN_DIR."
