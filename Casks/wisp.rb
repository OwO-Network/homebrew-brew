cask "wisp" do
  version "0.1.3"
  sha256 "d3ef5294f7e79900ac3974092575c3cff8c36e343dce6dadf3c20e1095d9aa5c"

  url "https://github.com/missuo/wisp/releases/download/v#{version}/Wisp-#{version}.zip"
  name "Wisp"
  desc "Computer-use toolkit that drives native apps and Chrome for AI agents"
  homepage "https://github.com/missuo/wisp"

  livecheck do
    url "https://github.com/missuo/wisp/releases/latest/download/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # Sparkle updates the app in place, so brew should not treat a newer bundle
  # version as drift.
  auto_updates true
  depends_on macos: :sonoma

  app "Wisp.app"
  # The CLI ships inside the bundle next to its daemon, so it finds wispd automatically.
  binary "#{appdir}/Wisp.app/Contents/MacOS/wisp", target: "wisp"

  zap trash: [
    "~/.config/wisp",
    "~/Library/Application Support/Wisp",
    "~/Library/Caches/sb.moe.wisp",
    "~/Library/HTTPStorages/sb.moe.wisp",
    "~/Library/Preferences/sb.moe.wisp.plist",
    "~/Library/Saved Application State/sb.moe.wisp.savedState",
  ]
end
