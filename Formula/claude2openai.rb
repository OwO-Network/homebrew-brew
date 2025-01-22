class Claude2openai < Formula
  desc "A proxy to convert Claude API into OpenAI API format"
  homepage "https://github.com/missuo/claude2openai"
  version "1.0.1"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/claude2openai/releases/download/v#{version}/claude2openai-darwin-arm64"
    sha256 "1"
  else
    url "https://github.com/missuo/claude2openai/releases/download/v#{version}/claude2openai-darwin-amd64"
    sha256 "1"
  end
  license "MIT"

  def install
    bin.install "claude2openai"
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