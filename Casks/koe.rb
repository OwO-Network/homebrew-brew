cask "koe" do
  version "1.0.12"
  sha256 "1ee46ada2987cbbbe3e8f5058fc8723fef99f90017ecb94e2864c9cfaf0aa85f"

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
