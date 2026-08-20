cask "herdrm" do
  version "0.3.7"
  sha256 "daac41d1a7d1fb484c9b2395996b9a6e9731852b98a7bfc5db857a8d299b5718"

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
  depends_on arch: :arm64

  app "herdrm.app"

  zap trash: [
    "~/Library/Application Support/HerdrM",
    "~/Library/Caches/dev.bybee.herdrm",
    "~/Library/HTTPStorages/dev.bybee.herdrm",
    "~/Library/Preferences/dev.bybee.herdrm.plist",
    "~/Library/Saved Application State/dev.bybee.herdrm.savedState",
  ]
end
