#!/usr/bin/env python3
import json
import unittest
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

class TestVSCodeChatExtension(unittest.TestCase):
    def test_package_json_and_icons(self) -> None:
        pkg = json.loads((ROOT / "package.json").read_text(encoding="utf-8"))
        self.assertTrue(pkg.get("version") is not None and len(pkg["version"]) > 0)
        self.assertEqual(pkg["icon"], "media/synax-logo.png")
        self.assertTrue((ROOT / "media" / "synax-logo.png").exists())
        self.assertTrue((ROOT / "media" / "synax-logo-color.svg").exists())
        self.assertTrue((ROOT / "media" / "synax-icon.svg").exists())
        cmds = {c["command"] for c in pkg["contributes"]["commands"]}
        self.assertIn("synax.openChatEditor", cmds)
        self.assertIn("synax.runBiomedAutocal", cmds)
        self.assertIn("synax.runTokenShield", cmds)
        self.assertIn("synax.runContextVault", cmds)

    def test_vsix_package_integrity(self) -> None:
        vsix = ROOT / "synax-vscode-chat-2.0.0.vsix"
        self.assertTrue(vsix.exists())
        with zipfile.ZipFile(vsix, "r") as zf:
            names = set(zf.namelist())
            self.assertIn("extension.vsixmanifest", names)
            self.assertIn("extension/package.json", names)
            self.assertIn("extension/media/synax-logo.png", names)

if __name__ == "__main__":
    unittest.main()
