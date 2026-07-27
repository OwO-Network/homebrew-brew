cask "sameru" do
  version "1.0.1"
  sha256 "d685bc76d4952d07c8bec3486790f25cdc6414e8d88d88c310cb5290eab37787"

  url "https://github.com/missuo/Sameru/releases/download/v#{version}/Sameru-#{version}.dmg"
  name "Sameru"
  desc "Menu bar app for keep awake, clean mode, and fan control"
  homepage "https://github.com/missuo/Sameru"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Sameru.app"

  # Fan control installs a setuid root helper on first use, which lives outside
  # the app bundle and has to be removed explicitly.
  uninstall quit:   "nz.owo.Sameru",
            delete: "/Library/PrivilegedHelperTools/nz.owo.Sameru.fan-helper"

  zap trash: [
    "~/Library/Caches/nz.owo.Sameru",
    "~/Library/HTTPStorages/nz.owo.Sameru",
    "~/Library/Preferences/nz.owo.Sameru.plist",
    "~/Library/Saved Application State/nz.owo.Sameru.savedState",
  ]
end
