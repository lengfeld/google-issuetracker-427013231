# Google Issuetracker 427013231

This repository is an addition to the Google issue
[Git tag `android-15.0.0_r0.2` was overwritten wrongly with a Android 16 release on some/a lot of repos on https://android.googlesource.com/](https://issuetracker.google.com/issues/427013231)

## How to use

To download all tag objects with tag message, use the makefile target
`tag-message`. Example

    $ make clean
    $ make tag-message

The output is in the files

    data/refs/tags/android-15.0.0_r0.1/tag-message
    data/refs/tags/android-15.0.0_r0.2/tag-message
    data/refs/tags/android-15.0.0_r0.3/tag-message

To get an overview

    > make summary
    FILE data/refs/tags/android-15.0.0_r0.1
         57 Android 15.0.0 release 0.1
    FILE data/refs/tags/android-15.0.0_r0.2
         56 Android 15.0.0 release 0.2
         34 Android 16 release 0.2
    FILE data/refs/tags/android-15.0.0_r0.3
         57 Android 15.0.0 release 0.3

This shows that for the Android tag `android-15.0.0_r0.2` there are two
different tag messages and a lot more repositories than for `r0.1` and `r0.3`.
The root cause is mostly a wrong push. See the issue for details.

To get some more infos, you can do

    $ make repos-with-tag-message

E.g. the following diff shows that there are the same repos for `r0.1` and
`r0.3`, but with different tag messages:

    $ vimdiff data/refs/tags/android-15.0.0_r0.1/repos-with-tag-message data/refs/tags/android-15.0.0_r0.3/repos-with-tag-message

To see the wrong tags in `r0.2`, you can do

    $ vimdiff data/refs/tags/android-15.0.0_r0.1/repos-with-tag-message data/refs/tags/android-15.0.0_r0.2/repos-with-tag-message

To get a list of all repos that contains the wrong tag, you can do

    $ make repos-with-wrong-tag
    $ cat data/refs/tags/android-15.0.0_r0.2/repos-with-wrong-tag
