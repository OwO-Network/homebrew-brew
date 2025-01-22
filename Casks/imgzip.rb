cask "imgzip" do
  version "0.0.2"
  
  if Hardware::CPU.arm?
    sha256 "28e9e4a09f7d85fdf2a0abfadc7198b4c3bb5dafadefd35b1ffa7a5692b3de8d"
    url "https://github.com/missuo/imgzip/releases/download/v#{version}/imgzip-darwin-arm64"
    binary "imgzip-darwin-arm64", target: "imgzip"
  else
    sha256 "b4e9c793eafb089cd8afe1af87e0d16c3820a795af7af436e17e6c3c26385d4f"
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
