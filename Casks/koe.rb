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

  postflight_steps do
    if_path_exists "~/.koe.upgrade_backup" do
      if_path_exists "~/.koe" do
        remove "~/.koe.upgrade_backup", recursive: true
      end
      unless_path_exists "~/.koe" do
        move "~/.koe.upgrade_backup", "~/.koe"
      end
    end
  end

  uninstall_preflight_steps do
    if_path_exists "~/.koe" do
      copy "~/.koe", "~/.koe.upgrade_backup", recursive: true
    end
  end

  zap trash: "~/.koe"
end
