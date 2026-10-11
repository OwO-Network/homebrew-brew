cask "motrix" do
  arch arm: "arm64", intel: "x64"

  version "0.0.9"
  sha256 arm:   "ee43d84429420c00808a2fa6574bc58220d81ecdc762cd6a63b696b405d8aa47",
         intel: "d7967876427b0fcfeb53d04e5c54848655f0b6e37e8dba380aaecc70349355ce"

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
