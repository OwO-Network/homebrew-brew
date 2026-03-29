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

  uninstall_preflight do
    koe_dir = File.expand_path("~/.koe")
    koe_backup = File.expand_path("~/.koe.upgrade_backup")
    next unless File.directory?(koe_dir)

    system_command "/bin/cp",
                   args: ["-r", koe_dir, koe_backup]
  end

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/Koe.app"]

    koe_dir = File.expand_path("~/.koe")
    koe_backup = File.expand_path("~/.koe.upgrade_backup")
    next unless File.directory?(koe_backup)

    unless File.directory?(koe_dir)
      system_command "/bin/mv",
                     args: [koe_backup, koe_dir]
    else
      system_command "/bin/rm",
                     args: ["-rf", koe_backup]
    end
  end

  zap trash: "~/.koe"
end
