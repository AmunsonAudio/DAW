#!/bin/bash

if [ -z "$1" ] ; then
  echo "Usage: $0 <version>"
  exit 1
fi

VERSION=$1

rm -f CoLabsPkg.dmg

cp CoLabs/README_MAC.txt CoLabsPkg/

if dropdmg --config-name=CoLabsPkg --layout-folder CoLabsPkgLayout --volume-name="CoLabs v${VERSION}"  --APP_VERSION=v${VERSION}  --signing-identity=C2552EB2949D5F03672EC9368E67B2BCB2A4F03F CoLabsPkg
then
  mkdir -p ${VERSION}
  mv -v CoLabsPkg.dmg ${VERSION}/colabs-${VERSION}-mac.dmg  	
else
  echo "Error making package DMG"
  exit 2
fi

