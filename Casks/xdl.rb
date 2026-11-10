cask "xdl" do
  version "2.2.0"
  sha256 "74d1c8b90b56b414e9d8a8838314a57b4003d899ce823c810ee12cdb17356d2c"

  url "https://github.com/missuo/xdl/releases/download/v#{version}/XDL-#{version}-macos-universal.dmg"
  name "XDL"
  desc "Batch downloader for X/Twitter media with a menu bar app, CLI and MCP server"
  homepage "https://github.com/missuo/xdl"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "XDL.app"
  # The app's executable is the `xdl` CLI too. The xdl-cli formula installs
  # the same command on its own: install one or the other.
  binary "#{appdir}/XDL.app/Contents/MacOS/XDL", target: "xdl"

  uninstall quit: "me.missuo.XDL"

  # The library, download history, subscriptions and xtractor live in
  # ~/.twitterxmediabatchdownloader, shared with the app XDL derives from,
  # and the X auth token in the login keychain: zap leaves both alone.
  zap trash: [
    "~/Library/Application Support/XDL",
    "~/Library/Preferences/me.missuo.XDL.plist",
    "~/Library/Saved Application State/me.missuo.XDL.savedState",
  ]
end
