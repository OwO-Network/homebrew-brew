cask "xdl" do
  version "2.3.0"
  sha256 "5879ef95808e5d920e4a9930fc912d1b5073c77ecd10c82d38a24510a0d552eb"

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

  # The library, the settings and the download history live in
  # ~/Library/Application Support/XDL, the X auth token in the login
  # keychain (entry "XDL"): zap removes the folder, not the token.
  zap trash: [
    "~/Library/Application Support/XDL",
    "~/Library/Preferences/me.missuo.XDL.plist",
    "~/Library/Saved Application State/me.missuo.XDL.savedState",
  ]
end
