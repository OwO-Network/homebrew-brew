cask "herdrm" do
  version "0.4.3"
  sha256 "7cf25b576d9858d1438e0a34030832d54f86b59ff4d62108f9bc60c18c881940"

  url "https://github.com/missuo/herdrm/releases/download/v#{version}/herdrm-#{version}.zip"
  name "herdrm"
  desc "Native macOS console for herdr"
  homepage "https://github.com/missuo/herdrm"

  livecheck do
    url "https://github.com/missuo/herdrm/releases/latest/download/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # Sparkle updates the app in place, so brew should not treat a newer bundle
  # version as drift.
  auto_updates true
  depends_on macos: :sonoma

  app "herdrm.app"

  zap trash: [
    "~/Library/Application Support/HerdrM",
    "~/Library/Caches/dev.bybee.herdrm",
    "~/Library/HTTPStorages/dev.bybee.herdrm",
    "~/Library/Preferences/dev.bybee.herdrm.plist",
    "~/Library/Saved Application State/dev.bybee.herdrm.savedState",
  ]
end
