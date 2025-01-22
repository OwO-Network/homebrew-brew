class Claude2openai < Formula
  desc "A proxy to convert Claude API into OpenAI API format"
  homepage "https://github.com/missuo/claude2openai"
  version "1.0.4"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/claude2openai/releases/download/v#{version}/claude2openai-darwin-arm64"
    sha256 "8059aa27ba0b55afe8642df47ef00511dc57077dfc9f33095aadd2ca7b78abf9"
  else
    url "https://github.com/missuo/claude2openai/releases/download/v#{version}/claude2openai-darwin-amd64"
    sha256 "5075e5888153039c15db0132ab0b99d8e28078b6411f73cdf4aa7d08b0ce2d09"
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