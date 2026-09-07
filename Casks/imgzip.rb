cask "imgzip" do
  arch arm: "arm64", intel: "amd64"

  version "0.0.2"
  sha256 arm:   "28e9e4a09f7d85fdf2a0abfadc7198b4c3bb5dafadefd35b1ffa7a5692b3de8d",
         intel: "b4e9c793eafb089cd8afe1af87e0d16c3820a795af7af436e17e6c3c26385d4f"

  url "https://github.com/missuo/imgzip/releases/download/v#{version}/imgzip-darwin-#{arch}"
  name "ImgZip"
  desc "Simple and efficient image compression tool"
  homepage "https://github.com/missuo/imgzip"

  depends_on macos: :big_sur

  binary "imgzip-darwin-#{arch}", target: "imgzip"

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/imgzip"],
        must_succeed: false
  end
end
