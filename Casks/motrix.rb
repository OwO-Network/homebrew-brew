cask "motrix" do
  arch arm: "arm64", intel: "x64"

  version "0.0.4"
  sha256 arm:   "87cf0b6512cbc685fc700f159bd01ae8d2b2928fdc203b85c9a2754f39e2dea0",
         intel: "aef119372e9c07afac1b2f8ef15c611f066f1051326bc2fb5450c0eb4b14636f"

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
