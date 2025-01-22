cask "imgzip" do
  version "0.0.1"
  
  if Hardware::CPU.arm?
    sha256 "7059aa27ba0b55afe8642df47ef00511dc57077dfc9f33095aadd2ca7b78abf9"
    url "https://github.com/missuo/imgzip/releases/download/v#{version}/imgzip-darwin-arm64"
    binary "imgzip-darwin-arm64", target: "imgzip"
  else
    sha256 "4075e5888153039c15db0132ab0b99d8e28078b6411f73cdf4aa7d08b0ce2d09"
    url "https://github.com/missuo/imgzip/releases/download/v#{version}/imgzip-darwin-amd64"
    binary "imgzip-darwin-amd64", target: "imgzip"
  end

  name "ImgZip"
  desc "A simple and efficient image compression tool"
  homepage "https://github.com/missuo/imgzip"
  
  depends_on macos: ">= :catalina"
  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/imgzip"
  end
end
