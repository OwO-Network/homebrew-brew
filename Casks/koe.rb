cask "koe" do
  version "1.0.3"
  sha256 "5451a64d4759d01fa9aaa4e992a9b51caa7315d6e236b8e105cc46045b8d9f6e"

  url "https://github.com/missuo/koe/releases/download/v#{version}/Koe-macOS-arm64.zip"
  name "Koe"
  desc "A zero-GUI macOS voice input tool"
  homepage "https://github.com/missuo/koe"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Koe.app"
end
