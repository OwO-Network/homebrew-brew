cask "ipatool" do
  if Hardware::CPU.arm?
    sha256 "8b1406a255083408232546292a4838134137f52e0c6234da5bf84338b8a391c6"
    url "https://github.com/missuo/ipatool/releases/download/v2.1.5/ipatool-darwin-aarch64"
    binary "ipatool-darwin-aarch64", target: "ipatool"

  version "2.1.5"
  name "IPATool"
  desc "CLI tool for searching and downloading iOS app packages from the App Store"
  homepage "https://github.com/missuo/ipatool"

  depends_on macos: ">= :catalina"

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/ipatool"
  end
end
