cask "koe" do
  version "1.0.11"
  sha256 "6735e9b00751099bb156df2ac57d5a3622484e370425f4e2aa1ae955450ec077"

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
