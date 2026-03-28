cask "koe" do
  version "1.0.11"
  sha256 "7d96b831fb0b3b078c1a49ece9e4ee0a1f64c184ae5f54b1e42bf71072b25102"

  url "https://github.com/missuo/koe/releases/download/v#{version}/Koe-macOS-arm64.zip"
  name "Koe"
  desc "A zero-GUI macOS voice input tool"
  homepage "https://github.com/missuo/koe"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Koe.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/Koe.app"]
  end

  uninstall_postflight do
    puts "Note: Koe configuration files in ~/.koe have been preserved."
    puts "To remove them manually, run: rm -rf ~/.koe"
  end

  zap trash: "~/.koe"
end
