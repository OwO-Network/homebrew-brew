cask "koe" do
  version "1.0.17"
  sha256 "63c3a2e9deb68e12bb958c55c582d9e4578ba674507f3654cb83a981e2a02eba"

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
    # Restore user data backup created during upgrade uninstallation.
    run "/bin/mv",
        args:         ["-n", "{{home}}/.koe.upgrade_backup", "{{home}}/.koe"],
        must_succeed: false

    run "/bin/rm",
        args:         ["-rf", "{{home}}/.koe.upgrade_backup"],
        must_succeed: false
  end

  uninstall_preflight_steps do
    run "/bin/cp",
        args:         ["-r", "{{home}}/.koe", "{{home}}/.koe.upgrade_backup"],
        must_succeed: false
  end

  zap trash: "~/.koe"
end
