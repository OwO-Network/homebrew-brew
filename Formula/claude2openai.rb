class Claude2openai < Formula
  desc "A proxy to convert Claude API into OpenAI API format"
  homepage "https://github.com/missuo/claude2openai"
  version "1.0.5"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/claude2openai/releases/download/v#{version}/claude2openai-darwin-arm64"
    sha256 "4d531876585d71026b39e38c51ef063ff9db75249fbad371035d5eca478c9b73"
  else
    url "https://github.com/missuo/claude2openai/releases/download/v#{version}/claude2openai-darwin-amd64"
    sha256 "4e00486756816d9283725ba80769d369ee7ed3a223ecbc796e964dfeba8e3842"
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