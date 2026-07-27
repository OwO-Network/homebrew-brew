cask "sameru" do
  version "1.0.1"
  sha256 "d685bc76d4952d07c8bec3486790f25cdc6414e8d88d88c310cb5290eab37787"

  url "https://github.com/missuo/Sameru/releases/download/v#{version}/Sameru-#{version}.dmg"
  name "Sameru"
  desc "Menu bar app for keep awake, clean mode, and fan control"
  homepage "https://github.com/missuo/Sameru"

  # Sparkle updates the app in place, so brew should not treat a newer bundle
  # version as drift.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Sameru.app"

  uninstall quit: "nz.owo.Sameru"

  # Fan control installs a setuid root helper outside the app bundle. Removing it
  # needs sudo, so it belongs in zap rather than uninstall: `brew upgrade` runs the
  # uninstall stanza first, and a delete: here would demand a password on every
  # single upgrade. The app reinstalls the helper by itself when it is missing.
  zap trash: [
    "/Library/PrivilegedHelperTools/nz.owo.Sameru.fan-helper",
    "~/Library/Caches/nz.owo.Sameru",
    "~/Library/HTTPStorages/nz.owo.Sameru",
    "~/Library/Preferences/nz.owo.Sameru.plist",
    "~/Library/Saved Application State/nz.owo.Sameru.savedState",
  ]
end
