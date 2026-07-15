class Claude2openai < Formula
  desc "A proxy to convert Claude API into OpenAI API format"
  homepage "https://github.com/missuo/claude2openai"
  version ""
  if Hardware::CPU.arm?
    url "https://github.com/missuo/claude2openai/releases/download/v#{version}/claude2openai-darwin-arm64"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  else
    url "https://github.com/missuo/claude2openai/releases/download/v#{version}/claude2openai-darwin-amd64"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  end
  license "MIT"

  def install
    if Hardware::CPU.arm?
      bin.install "claude2openai-darwin-arm64" => "claude2openai"
    else
      bin.install "claude2openai-darwin-amd64" => "claude2openai"
    end
  end

  service do
    run [opt_bin/"claude2openai"]
    keep_alive true
    error_log_path var/"log/claude2openai.log"
    log_path var/"log/claude2openai.log"
  end

  test do
    assert_match "Welcome to Claude2OpenAI",
      shell_output("#{bin}/claude2openai --version 2>&1", 1)
  end
end