# ![icon](https://github.com/shemeshg/CakebrewJs2-ds/assets/8200598/67e2b01a-3e36-49d3-98c9-238e0c5f3e74) &nbsp;  Cakebrewjs

<a href="https://sourceforge.net/projects/cakebrewjs/"><img alt="Cakebrewjs Reviews" src="https://sourceforge.net/cdn/syndication/badge_img/3303903/oss-users-love-us-white?&r=https://sourceforge.net/p/cakebrewjs/admin/files/badges"  style="width: 200px;"></a>

Homebrew GUI App written in Qt6+Qml+Js

<https://github.com/shemeshg/CakebrewJs2-ds>

<https://sourceforge.net/p/cakebrewjs>

## Install

```bash
brew install --cask cakebrewjs
```

* install using:
```bash
brew install --cask cakebrewjs
```

* *Must* fix signature:
```bash
codesign --force --deep --sign - /Applications/cakebrewjs.app/
```

* *Must* fix authorizations:
`xattr -c /Applications/cakebrewjs.app/`

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
