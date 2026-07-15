class Ai < Formula
  desc "Launch Claude Code, Codex, or Grok in YOLO mode from one command"
  homepage "https://github.com/missuo/ai-cli"
  version "1.0.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-darwin-arm64"
      sha256 "7f8aa5d3f8bd84801138e4b6173bcdc1d901699e7d26b851a7574ba165e86206"
    else
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-darwin-amd64"
      sha256 "60e82149e366e9d460112f6bdff143b0c1253205970b9d163430083a8fa95a7a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-linux-arm64"
      sha256 "bd182a4d13c81f3e5b6aeae0829405c4f2b998ef83d1e7226857df3748d3b2f5"
    else
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-linux-amd64"
      sha256 "87f41015673f9e0f14b0f3bd7d74fc47f1a30da11b7517a2a55191a62eb92202"
    end
  end

  def install
    binary = if OS.mac?
      Hardware::CPU.arm? ? "ai-darwin-arm64" : "ai-darwin-amd64"
    elsif OS.linux?
      Hardware::CPU.arm? ? "ai-linux-arm64" : "ai-linux-amd64"
    end

    bin.install binary => "ai"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ai --version")
  end
end
