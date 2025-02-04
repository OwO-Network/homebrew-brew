cask "polyglot-sub" do
  version "1.0"
    sha256 "28e9e4a09f7d85fdf2a0abfadc7198b4c3bb5dafadefd35b1ffa7a5692b3de8d"

  url "https://github.com/missuo/PolyglotSub/releases/download/v#{version}/Polyglot.dmg"
  name "Polyglot Sub"
  desc "Subtitle translator based on DeepLX"
  homepage "https://github.com/missuo/PolyglotSub"

  auto_updates true
  depends_on macos: ">= :monterey"

  app "Polyglot Sub.app"
end
