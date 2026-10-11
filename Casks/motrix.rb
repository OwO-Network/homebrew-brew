cask "motrix" do
  arch arm: "arm64", intel: "x64"

  version "0.0.8"
  sha256 arm:   "0f306e2640b76408c2b3c66bda27fbebac74156ca904e3c63cddfa70148bec50",
         intel: "32e91c9c284256a2bb6b2347ea04a51860f78c69a1612834a804f0d7c6e8a11d"

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
