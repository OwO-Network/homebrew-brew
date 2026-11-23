class Ai < Formula
  desc "Launch Claude Code, Codex, Grok, or Antigravity in YOLO mode from one command"
  homepage "https://github.com/missuo/ai-cli"
  version "1.1.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-darwin-arm64"
      sha256 "89f0f6b2c11270644bf199c467535bf92223f03d042b1dd5da091bb36046b392"
    else
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-darwin-amd64"
      sha256 "600c1057750dfb2bbe3d5890ca53ac2379a6df467abd83474b8ef4174e9bee5e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-linux-arm64"
      sha256 "55d803df82892969f39e42f1569d0eda706df477bb2f1a0c18ee74bf806c545c"
    else
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-linux-amd64"
      sha256 "23290eb26accf41a9ce0418f1cb69782febee63c1f9688b6254bf911536db942"
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
