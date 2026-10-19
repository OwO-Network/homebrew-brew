cask "motrix" do
  arch arm: "arm64", intel: "x64"

  version "0.0.10"
  sha256 arm:   "fdc88c66c90d7650fdfabe9ed4c9814ee75412b2939f9e96488965ded1d11aae",
         intel: "abf3821ad7f90018860d6b45103bb00aa2a73c48d609b7a875a6fc677ca43874"

  url "https://github.com/missuo/motrix-mygo/releases/download/v#{version}/Motrix-#{version}-macos-#{arch}.dmg"
  name "Motrix"
  desc "Download manager with a native Go interface over aria2"
  homepage "https://github.com/missuo/motrix-mygo"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself from the releases.
  auto_updates true
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
