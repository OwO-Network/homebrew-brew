cask "imgzip" do
  version ""
  
  if Hardware::CPU.arm?
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    url "https://github.com/missuo/imgzip/releases/download/v#{version}/imgzip-darwin-arm64"
    binary "imgzip-darwin-arm64", target: "imgzip"
  else
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    url "https://github.com/missuo/imgzip/releases/download/v#{version}/imgzip-darwin-amd64"
    binary "imgzip-darwin-amd64", target: "imgzip"
  end

  name "ImgZip"
  desc "A simple and efficient image compression tool"
  homepage "https://github.com/missuo/imgzip"
  
  depends_on macos: :catalina
  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/imgzip"
  end
end
