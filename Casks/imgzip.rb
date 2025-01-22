cask "imgzip" do
  version "0.0.1"
  
  if Hardware::CPU.arm?
    sha256 "15561405b1303e070c53d784bce1d210494e5e78ad281d496561e0be73ae8f21"
    url "https://github.com/missuo/imgzip/releases/download/v#{version}/imgzip-darwin-arm64"
    binary "imgzip-darwin-arm64", target: "imgzip"
  else
    sha256 "a498e68d923aa5679ae4ede6bd43d75c51845efbcd93867f51f0760a442d884b"
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
