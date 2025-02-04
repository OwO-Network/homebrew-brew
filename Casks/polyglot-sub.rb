cask "polyglot-sub" do
  version "1.0"
  sha256 "d2be328a89db813bd1609237062d0a4b69462c9173417f51260f12f2753662be"

  url "https://github.com/missuo/PolyglotSub/releases/download/v#{version}/Polyglot.dmg"
  name "Polyglot Sub"
  desc "Subtitle translator based on DeepLX"
  homepage "https://github.com/missuo/PolyglotSub"

  auto_updates true
  depends_on macos: ">= :monterey"

  app "Polyglot Sub.app"
end
