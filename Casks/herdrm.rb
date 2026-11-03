cask "herdrm" do
  version "0.7.0"
  sha256 "b7a8480529ad967962aae44940770c2cdcb5498d9875516e94c5b992d2785f90"

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

  # sb.moe.herdrm since 0.7.0; dev.bybee.herdrm before.
  zap trash: [
    "~/Library/Application Support/HerdrM",
    "~/Library/Caches/dev.bybee.herdrm",
    "~/Library/Caches/sb.moe.herdrm",
    "~/Library/HTTPStorages/dev.bybee.herdrm",
    "~/Library/HTTPStorages/sb.moe.herdrm",
    "~/Library/Preferences/dev.bybee.herdrm.plist",
    "~/Library/Preferences/sb.moe.herdrm.plist",
    "~/Library/Saved Application State/dev.bybee.herdrm.savedState",
    "~/Library/Saved Application State/sb.moe.herdrm.savedState",
  ]
end
