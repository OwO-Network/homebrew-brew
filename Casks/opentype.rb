cask "opentype" do
  version "0.2.1,3"
  sha256 "9077cfbf285f42412d7da8d70bf889a7f19d524333fabd706211f6973e616589"

  url "https://opentype.owo.nz/mac/OpenType-#{version.csv.first}.dmg"
  name "OpenType"
  desc "Native client for Typeless dictation"
  homepage "https://opentype.owo.nz/"

  livecheck do
    url "https://opentype.owo.nz/mac/appcast.xml"
    strategy :sparkle
  end

  # Sparkle updates the app in place, so brew should not treat a newer bundle
  # version as drift.
  auto_updates true
  # Statically linked against Homebrew's arm64-only libopus/libogg.
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "OpenType.app"

  uninstall quit: "sb.moe.opentype"

  # Account credentials (AES-encrypted, keyed from the Keychain) live under
  # Application Support; the master key stays in the Keychain, which brew
  # does not touch.
  zap trash: [
    "~/Library/Application Support/OpenType",
    "~/Library/Caches/sb.moe.opentype",
    "~/Library/HTTPStorages/sb.moe.opentype",
    "~/Library/Preferences/sb.moe.opentype.plist",
    "~/Library/Saved Application State/sb.moe.opentype.savedState",
  ]
end
