#!/bin/bash



# codesign them with developer ID cert

POPTS="--strict  --force --options=runtime --sign C2552EB2949D5F03672EC9368E67B2BCB2A4F03F --timestamp"
AOPTS="--strict  --force --options=runtime --sign C2552EB2949D5F03672EC9368E67B2BCB2A4F03F --timestamp"

codesign ${AOPTS} --entitlements CoLabs.entitlements CoLabs/CoLabs.app
codesign ${POPTS} --entitlements CoLabs.entitlements  CoLabs/CoLabs.component
codesign ${POPTS} --entitlements CoLabs.entitlements CoLabs/CoLabs.vst3
codesign ${POPTS} --entitlements CoLabs.entitlements CoLabs/CoLabsInstrument.vst3
# codesign ${POPTS} --entitlements CoLabs.entitlements  CoLabs/CoLabs.vst

# AAX is special
if [ -n "${AAXSIGNCMD}" ]; then
 echo "Signing AAX plugin"
 ${AAXSIGNCMD}  --in CoLabs/CoLabs.aaxplugin --out CoLabs/CoLabs.aaxplugin
fi


if [ "x$1" = "xonly" ] ; then
  echo Code-signing only
  exit 0
fi

mkdir -p tmp

# notarize them in parallel
./notarize-app.sh --submit=tmp/sbapp.uuid  CoLabs/CoLabs.app
# STATUS__=$?
# if [ $STATUS__ -ne 0 ]; then
#   echo Notarize submit app failed: $STATUS__
#   exit 2
# fi

./notarize-app.sh --submit=tmp/sbau.uuid CoLabs/CoLabs.component

./notarize-app.sh --submit=tmp/sbvst3.uuid CoLabs/CoLabs.vst3

./notarize-app.sh --submit=tmp/sbinstvst3.uuid CoLabs/CoLabsInstrument.vst3

# ./notarize-app.sh --submit=tmp/sbvst2.uuid CoLabs/CoLabs.vst 

echo
echo "!!! DONE submitting !!!"
echo

sleep 5

if ! ./notarize-app.sh --resume=tmp/sbapp.uuid CoLabs/CoLabs.app ; then
  echo Notarization App failed
  exit 2
fi

if ! ./notarize-app.sh --resume=tmp/sbau.uuid CoLabs/CoLabs.component ; then
  echo Notarization AU failed
  exit 2
fi

if ! ./notarize-app.sh --resume=tmp/sbvst3.uuid CoLabs/CoLabs.vst3 ; then
  echo Notarization VST3 failed
  exit 2
fi

if ! ./notarize-app.sh --resume=tmp/sbinstvst3.uuid CoLabs/CoLabsInstrument.vst3 ; then
  echo Notarization Inst VST3 failed
  exit 2
fi
  
# if ! ./notarize-app.sh --resume=tmp/sbvst2.uuid CoLabs/CoLabs.vst ; then
#   echo Notarization VST2 failed
#   exit 2
# fi

#if ! ./notarize-app.sh CoLabs/CoLabs.aaxplugin ; then
#  echo Notarization AAX failed
#  exit 2
#fi





