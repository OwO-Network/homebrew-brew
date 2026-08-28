cask "herdrm" do
  version "0.5.2"
  sha256 "df4f87cf6f9a2d7ced9b6cde198fbecd80d30043ff657447d0385566abbc298e"

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
