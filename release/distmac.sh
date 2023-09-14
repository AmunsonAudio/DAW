#!/bin/bash

if [ -z "$1" ] ; then
   echo "Usage: $0 <version>"
   exit 1
fi

VERSION=$1

APPNAME=CoLabs


#BUILDDIR=../Builds/MacOSX/build/Release
BUILDDIR=../build/CoLabs_artefacts/Release
INSTBUILDDIR=../build/CoLabsInst_artefacts/Release


# COMMENT FROM HERE

rm -rf CoLabs

mkdir -p CoLabs


cp ../doc/README_MAC.txt CoLabs/

cp -pLRv ${BUILDDIR}/Standalone/CoLabs.app  CoLabs/
cp -pLRv ${BUILDDIR}/AU/CoLabs.component  CoLabs/
cp -pLRv ${BUILDDIR}/VST3/CoLabs.vst3 CoLabs/
cp -pLRv ${INSTBUILDDIR}/VST3/CoLabsInstrument.vst3 CoLabs/
# cp -pLRv ${BUILDDIR}/VST/CoLabs.vst  CoLabs/
# cp -pRHv ${BUILDDIR}/AAX/CoLabs.aaxplugin  CoLabs/

echo
echo "!!! ALL FILES COPIED !!!"
echo

#cp -pLRv ${BUILDDIR}/CoLabs.app  CoLabs/
#cp -pLRv ${BUILDDIR}/CoLabs.component  CoLabs/
#cp -pLRv ${BUILDDIR}/CoLabs.vst3 CoLabs/
#cp -pLRv ${BUILDDIR}/CoLabs.vst  CoLabs/
#cp -pRHv ${BUILDDIR}/CoLabs.aaxplugin  CoLabs/

#ln -sf /Library/Audio/Plug-Ins/Components CoLabs/
#ln -sf /Library/Audio/Plug-Ins/VST3 CoLabs/
#ln -sf /Library/Audio/Plug-Ins/VST CoLabs/
#ln -sf /Library/Application\ Support/Avid/Audio/Plug-Ins CoLabs/

echo
echo "!!! BEGIN: CODESIGN !!!"

# this codesigns and notarizes everything
if ! ./codesign.sh ; then
  echo
  echo Error codesign/notarizing, stopping
  echo
  exit 1
fi

echo "!!! END: CODESIGN !!!"
echo

# make installer package (and sign it)

rm -f macpkg/CoLabsTemp.pkgproj

if ! ./update_package_version.py ${VERSION} macpkg/CoLabs.pkgproj macpkg/CoLabsTemp.pkgproj ; then
  echo
  echo Error updating package project versions
  echo
  exit 1
fi

if ! packagesbuild  macpkg/CoLabsTemp.pkgproj ; then
  echo 
  echo Error building package
  echo
  exit 1
fi

mkdir -p CoLabsPkg
rm -f CoLabsPkg/*

if ! productsign --sign ${INSTSIGNID} --timestamp  macpkg/build/CoLabs\ Installer.pkg CoLabsPkg/CoLabs\ Installer.pkg ; then
  echo 
  echo Error signing package
  echo
  exit 1
fi

# echo "DONE SIGNING!!"

# make dmg with package inside it

echo making dmg...
if ./makepkgdmg.sh $VERSION ; then

    echo goodie
   ./notarizedmg.sh ${VERSION}/colabs-${VERSION}-mac.dmg

   echo
   echo COMPLETED DMG READY === ${VERSION}/colabs-${VERSION}-mac.dmg
   echo
   
fi
