# ![icon](https://github.com/shemeshg/CakebrewJs2-ds/assets/8200598/67e2b01a-3e36-49d3-98c9-238e0c5f3e74)  Cakebrewjs


Homebrew GUI App written in Qt6+Qml+Js

<https://github.com/shemeshg/CakebrewJs2-ds>

<https://sourceforge.net/p/cakebrewjs>

## Install

```bash
brew install --cask cakebrewjs
```

## Uninstall

```bash
brew cask uninstall cakebrewjs
```

## Project setup

Use `Qt creator` and `Qt Designer`


### Compiles for production

```bash
/Volumes/FAST/Qt/6.6.2/macos/bin/qt-cmake  -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=.  ${sourceFolder}
ninja
ninja install
```

## Built With

<https://github.com/shemeshg/CakebrewJs2-ds/blob/main/SBOM.md>

## Authors

* **shemeshg**

## License

<https://github.com/shemeshg/CakebrewJs2-ds/blob/main/LICENSE>
