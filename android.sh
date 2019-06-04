#!/bin/sh

[ "$ANDROID_HOME" ] || { echo "FATAL: ANDROID_HOME not set"; exit 1; }
[ $# -eq 1 -o $# -eq 2 ] || { echo "Usage: $0 <arch> [prefix]"; exit 1; }

set -ex

arch=$1
shift
prefix=/usr/local/opt
[ $# -eq 2 ] && prefix=$2

$ANDROID_HOME/platform-tools/adb root

$ANDROID_HOME/platform-tools/adb push $prefix/android-measurement-kit/$arch/bin/measurement_kit /data
$ANDROID_HOME/platform-tools/adb push $prefix/generic-assets/ca-bundle.pem /data
$ANDROID_HOME/platform-tools/adb push $prefix/generic-assets/asn.mmdb /data
$ANDROID_HOME/platform-tools/adb push $prefix/generic-assets/country.mmdb /data

$ANDROID_HOME/platform-tools/adb shell "cd /data && ./measurement_kit --version"
for cmd in ndt 'web_connectivity -u http://www.google.com'; do
  $ANDROID_HOME/platform-tools/adb shell                                       \
    "cd /data && ./measurement_kit --ca-bundle-path=ca-bundle.pem $cmd"
done

$ANDROID_HOME/platform-tools/adb shell rm /data/measurement_kit
$ANDROID_HOME/platform-tools/adb shell rm /data/ca-bundle.pem
$ANDROID_HOME/platform-tools/adb shell rm /data/asn.mmdb
$ANDROID_HOME/platform-tools/adb shell rm /data/country.mmdb
