#!/usr/bin/env python

import os

import requests

WORKDIR = os.getenv("GITHUB_WORKSPACE")
PAPER_VERSIONS = "https://api.papermc.io/v2/projects/paper/"
PAPER_BUILDS_BASE = "https://api.papermc.io/v2/projects/paper/versions/"
PAPER_OUTFILE = f"{WORKDIR}/paper.jar"

TIMEOUT = 60

resp = requests.get(PAPER_VERSIONS, timeout=TIMEOUT)
resp.raise_for_status()
version_data = resp.json()

ver_tuples = []
longest = 1
for ver_str in version_data["versions"]:
    # print(ver_str)
    try:
        tup = [int(part) for part in ver_str.split(".")]
        # print(tup)
        ver_tuples.append(tup)
        longest = max(longest, len(tup))
    except ValueError as e:
        print(f"Skipping version: {ver_str}")


selected = []
for idx in range(longest):
    highest = 0
    for tup in ver_tuples:
        matches = True
        for i in range(idx):
            if tup[i] != selected[i]:
                matches = False

        if matches:
            val = tup[idx] if len(tup) > idx else 0
            highest = max(highest, val)

    selected.append(highest)
    highest = 0

selected_version = ".".join([str(v) for v in selected])
print(f"Version: {selected_version}")

resp = requests.get(PAPER_BUILDS_BASE + selected_version)
resp.raise_for_status()
version_data = resp.json()

build = str(sorted(version_data["builds"])[-1])

url = f"https://api.papermc.io/v2/projects/paper/versions/{selected_version}/builds/{build}/downloads/paper-{selected_version}-{build}.jar"
resp = requests.get(url, timeout=5 * TIMEOUT)
resp.raise_for_status()
with open(PAPER_OUTFILE, "wb") as fhandle:
    fhandle.write(resp.content)

print(f"Downloaded Paper: {url}")
