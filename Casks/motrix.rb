cask "motrix" do
  arch arm: "arm64", intel: "x64"

  version "0.0.6"
  sha256 arm:   "2fc2ab5a94a08e45833257d99b04303ee25f007c16b426639c6735f251aa279c",
         intel: "5de37341555468c627fc942257c092b160d485bcc687c6fe1b0f1a10f7aa980a"

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
