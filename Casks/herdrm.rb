cask "herdrm" do
  version "0.6.1"
  sha256 "2e4833427ecd4f63cf2711f813f9ffd0a6523a22022624c27eac3696eb7051da"

  url "https://github.com/missuo/herdrm/releases/download/v#{version}/herdrm-#{version}.zip"
  name "herdrm"
  desc "Native console for herdr"
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
