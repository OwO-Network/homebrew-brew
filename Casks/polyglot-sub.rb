cask "polyglot-sub" do
  version "1.0"
  sha256 ""

  url "https://github.com/missuo/PolyglotSub/releases/download/v#{version}/Polyglot.dmg"
  name "PolyglotSub"
  desc "Subtitle translator based on DeepLX"
  homepage "https://github.com/missuo/PolyglotSub"

  auto_updates true
  depends_on macos: ">= :monterey"

  app "Polyglot Sub.app"
end
