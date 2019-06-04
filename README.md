# Smoke testing scripts

This repository contains Measurement Kit (mobile) smoke testing scripts.

## macOS instructions

### Install Android binaries

```bash
brew tap measurement-kit/measurement-kit
brew install generic-assets android-measurement-kit
```

### Smoke testing

Start a simulator from Android studio. It must be using an Android
image not containing Google Play services because, apparently, in
such images we cannot become root. Note the architecture used in the
running simulator. Possibly use an old version of Android to have
more confidence that there will be no undefined symbols etc.

Then run

```sh
./android.sh $arch
```

The objective of this step is to make sure that the newly compiled
code is not going to cause issues on old Android and possibly on
a variety of architectures.

Hence we can spot problems or be more confident _earlier_.
