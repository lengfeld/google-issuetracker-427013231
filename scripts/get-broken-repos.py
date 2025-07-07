#!/usr/bin/env python3
# SPDX-License-Identifier: MIT

import sys

VALID_TAG_MESSAGES = [
    "Android 16 release 0.2",
    "Android 15.0.0 release 0.1",
    "Android 15.0.0 release 0.2",
    "Android 15.0.0 release 0.3",
]

with open(sys.argv[1]) as f:
    repo_name = None
    for line in f:
        line = line.rstrip("\n")
        if line.startswith("REPO: "):
            repo_name = line[6:]
        elif line.startswith("Android "):
            if line not in VALID_TAG_MESSAGES:
                raise Exception("Unknown tag message:", line)
            if line == "Android 16 release 0.2":
                print(repo_name)
        else:
            pass
