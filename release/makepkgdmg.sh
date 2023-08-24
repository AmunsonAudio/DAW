#!/bin/bash

if [ -z "$1" ] ; then
  echo "Usage: $0 <version>"
  exit 1
fi

VERSION=$1

rm -f SonoBusPkg.dmg

cp SonoBus/README_MAC.txt SonoBusPkg/

if dropdmg --config-name=SonoBusPkg --layout-folder SonoBusPkgLayout --volume-name="SonoBus v${VERSION}"  --APP_VERSION=v${VERSION}  --signing-identity=D0D435D1F55B3EC083FE6C6C55813B5426AD6707 SonoBusPkg
then
  mkdir -p ${VERSION}
  mv -v SonoBusPkg.dmg ${VERSION}/sonobus-${VERSION}-mac.dmg  	
else
  echo "Error making package DMG"
  exit 2
fi

