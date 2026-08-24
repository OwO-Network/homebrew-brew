cask "kumone" do
  version "0.2.4"
  sha256 "388f6174bb4c55ee9aa6c049aaf7b0a6e5311ad26d60bfaafc1358da16692f33"

  url "https://github.com/missuo/kumone/releases/download/v#{version}/Kumone-#{version}.zip"
  name "Kumone"
  desc "Native client for NetEase Cloud Music"
  homepage "https://github.com/missuo/kumone"

  livecheck do
    url "https://github.com/missuo/kumone/releases/latest/download/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # Sparkle updates the app in place, so brew should not treat a newer bundle
  # version as drift.
  auto_updates true
  depends_on macos: :sequoia

  app "Kumone.app"

  zap trash: [
    "~/Library/Application Support/Kumone",
    "~/Library/Caches/im.missuo.Kumone",
    "~/Library/HTTPStorages/im.missuo.Kumone",
    "~/Library/Preferences/im.missuo.Kumone.plist",
    "~/Library/Saved Application State/im.missuo.Kumone.savedState",
  ]
end
