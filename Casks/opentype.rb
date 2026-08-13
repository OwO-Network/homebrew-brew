cask "opentype" do
  version "0.2.0,2"
  sha256 "285b5a6154ad443548d82f9131772afb922a69a4a1617558184bf863214b8c16"

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
