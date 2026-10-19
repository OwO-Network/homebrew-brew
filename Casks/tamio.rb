cask "tamio" do
  version "0.2.5"
  sha256 "4623c38a380f3bb894e3265d767c196e6e11a6d24dfc3f7b287d834c86926c86"

  url "https://github.com/missuo/tamio/releases/download/v#{version}/Tamio-#{version}.dmg"
  name "Tamio"
  desc "SSH client with live server status, SFTP and an MCP server for AI agents"
  homepage "https://tamio.sh/"

  livecheck do
    url "https://github.com/missuo/tamio/releases/latest/download/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # Sparkle updates the app in place, so brew should not treat a newer bundle
  # version as drift.
  auto_updates true
  depends_on macos: :sonoma

  app "Tamio.app"

  uninstall quit: "sb.moe.tamio"

  # The MCP server's socket and the agents' activity log live in Application
  # Support; servers and keys are in the app's preferences, encrypted under a
  # key in the login keychain, which zap leaves alone.
  zap trash: [
    "~/Library/Application Support/sb.moe.tamio",
    "~/Library/Caches/sb.moe.tamio",
    "~/Library/HTTPStorages/sb.moe.tamio",
    "~/Library/Preferences/sb.moe.tamio.plist",
    "~/Library/Saved Application State/sb.moe.tamio.savedState",
  ]
end
