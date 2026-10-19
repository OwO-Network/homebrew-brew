cask "koe" do
  version "1.0.33"
  sha256 "0118f6d96b6e8df496fb157220ebea606e8c2c68b230b8326b78a7a8d8591fd0"

  url "https://github.com/missuo/koe/releases/download/v#{version}/Koe-macOS-arm64.zip"
  name "Koe"
  desc "Zero-GUI voice input tool"
  homepage "https://github.com/missuo/koe"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Koe.app"
  binary "#{appdir}/Koe.app/Contents/MacOS/koe-cli", target: "koe"

  postflight do
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

  uninstall_preflight do
    koe_dir = File.expand_path("~/.koe")
    koe_backup = File.expand_path("~/.koe.upgrade_backup")
    next unless File.directory?(koe_dir)

    system_command "/bin/cp",
                   args: ["-r", koe_dir, koe_backup]
  end

  zap trash: "~/.koe"
end
