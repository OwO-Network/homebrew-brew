cask "motrix" do
  arch arm: "arm64", intel: "x64"

  version "0.0.3"
  sha256 arm:   "850c588a47e1c3190af5ec9af33678caad75ce8c3621b7ac2213f2fda77924b5",
         intel: "561d31e93771cdd3964c2b755ee0d0c8f0b73e0dfc7bc4f07a595b11604217e4"

  url "https://github.com/missuo/motrix-mygo/releases/download/v#{version}/Motrix-#{version}-macos-#{arch}.dmg"
  name "Motrix"
  desc "Download manager with a native Go interface over aria2"
  homepage "https://github.com/missuo/motrix-mygo"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Homebrew's own motrix casks install a Motrix.app too.
  conflicts_with cask: [
    "homebrew/cask/motrix",
    "homebrew/cask/motrix@beta",
  ]
  depends_on macos: :monterey

  app "Motrix.app"

  uninstall quit: "app.motrix.mygo"

  zap trash: [
    "~/Library/Application Support/Motrix MyGo",
    "~/Library/Preferences/app.motrix.mygo.plist",
    "~/Library/Saved Application State/app.motrix.mygo.savedState",
  ]
end
