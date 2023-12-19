#!/usr/bin/env python

import os
from typing import Any, Optional

import requests

OUTDIR = "plugins"

DIRECT_DOWNLOAD = {
    "Geyser-Spigot.jar": "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"
}

PLUGINS = {
    "Multiverse-Core": "Multiverse/Multiverse-Core",
    "Multiverse-Portals": "Multiverse/Multiverse-Portals",
    "Multiverse-SignPortals": "Multiverse/Multiverse-SignPortals"
}

HEADERS = {
    "Accept": "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28"
}

TIMEOUT = 60


def get_release(repo_key: str) -> dict[str, Any]:
    """ Find the latest release for a given repo and return its id and name"""

    resp = requests.get(f"https://api.github.com/repos/{repo_key}/releases/latest", headers=HEADERS, timeout=TIMEOUT)
    resp.raise_for_status()
    data = resp.json()

    return {"id": data["id"], "name": data["name"]}


def get_jar_url(repo_key: str, release_id: int) -> Optional[dict[str, str]]:
    """ Find a JAR asset for the given repo and release ID, and return its URL"""

    resp = requests.get(f"https://api.github.com/repos/{repo_key}/releases/{release_id}/assets", headers=HEADERS, timeout=TIMEOUT)
    resp.raise_for_status()
    data = resp.json()

    for asset in data:
        name = asset["name"]
        if name.endswith(".jar"):
            # print(f"{asset['name']} with type: {asset['content_type']}")
            return {"name": name, "url": asset["browser_download_url"]}

    return None


def download(name: str, url: str) -> None:
    plugin_file = os.path.join(OUTDIR, name)

    resp = requests.get(url, timeout=5 * TIMEOUT)
    resp.raise_for_status()
    with open(plugin_file, 'wb') as fhandle:
        fhandle.write(resp.content)

    print(f"Downloaded {name}: {url}")


for k, v in PLUGINS.items():
    rel_data = get_release(v)
    plugin_download = get_jar_url(v, rel_data["id"])
    download(plugin_download["name"], plugin_download["url"])

for pname, purl in DIRECT_DOWNLOAD.items():
    download(pname, purl)

