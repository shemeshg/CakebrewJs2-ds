# how to deploy

cmake --install .
cd /tmp
mkdir out
cp -R "Cakebrewjs.app" out;
ln -s /Applications out;
hdiutil create -volname "Cakebrewjs" -srcfolder out -ov -format UDZO Cakebrewjs-2.82-Darwin.dmg
