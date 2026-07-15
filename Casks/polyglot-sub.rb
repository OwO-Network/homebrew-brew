cask "polyglot-sub" do
  version ""
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  url "https://github.com/missuo/PolyglotSub/releases/download/v#{version}/Polyglot.dmg"
  name "Polyglot Sub"
  desc "Subtitle translator based on DeepLX"
  homepage "https://github.com/missuo/PolyglotSub"

  auto_updates true
  depends_on macos: :monterey

  app "Polyglot Sub.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{staged_path}/Polyglot Sub.app"],
                   sudo: true

    system_command "/usr/bin/find",
                   args: ["#{staged_path}/Polyglot Sub.app", "-name", ".DS_Store", "-delete"],
                   sudo: true
    
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{staged_path}/Polyglot Sub.app"],
                   sudo: true
  end
end
