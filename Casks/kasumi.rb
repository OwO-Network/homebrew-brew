cask "kasumi" do
  version "0.2.8,40"
  sha256 "09fa3cf0ad2ad107b39251baed6894c71d869902b4180e43acb001ea8156541b"

  url "https://kasumi.owo.nz/mac/Kasumi-#{version.csv.first}.dmg"
  name "Kasumi"
  desc "Rule-based proxy client for the Kasumi protocol"
  homepage "https://kasumi.owo.nz/"

  livecheck do
    url "https://kasumi.owo.nz/mac/appcast-mac.xml"
    strategy :sparkle
  end

  # Sparkle updates the app in place, so brew should not treat a newer bundle
  # version as drift.
  auto_updates true
  depends_on macos: :ventura

  app "Kasumi.app"

  uninstall launchctl: "sb.moe.kasumi-mac.helper",
            quit:      "sb.moe.kasumi-mac",
            delete:    "/Library/LaunchDaemons/sb.moe.kasumi-mac.helper.plist"

  # Enhanced Mode installs a root helper, which stages the proxy core beside
  # itself and writes the running core's control-API details where the app can
  # read them. All three live outside the bundle and need sudo to remove, so
  # they belong in zap rather than uninstall: `brew upgrade` runs the uninstall
  # stanza first, and a delete: here would ask for a password on every upgrade.
  # The app reinstalls the helper by itself when it is missing.
  zap trash: [
    "/Library/Application Support/Kasumi",
    "/Library/PrivilegedHelperTools/sb.moe.kasumi-mac.core",
    "/Library/PrivilegedHelperTools/sb.moe.kasumi-mac.helper",
    "~/Library/Application Support/Kasumi",
    "~/Library/Caches/sb.moe.kasumi-mac",
    "~/Library/HTTPStorages/sb.moe.kasumi-mac",
    "~/Library/Preferences/sb.moe.kasumi-mac.plist",
    "~/Library/Saved Application State/sb.moe.kasumi-mac.savedState",
  ]
end
