class Ai < Formula
  desc "Tiny command-line launcher for local AI coding agents"
  homepage "https://github.com/missuo/ai-cli"
  version "1.0.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-darwin-arm64"
      sha256 "29725e2cfe52f98c673b6a623b474d3fb32f1635a6d016c690f49246c9190e59"
    else
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-darwin-amd64"
      sha256 "822e3a2ba2a48f0777dbadf7a41b93aff3cbb1c2969ed806c38b058ca835b66a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-linux-arm64"
      sha256 "f9db77fe2b596df4f770077b2b8c3e4f41cc075178824784a80f834dd243c928"
    else
      url "https://github.com/missuo/ai-cli/releases/download/v#{version}/ai-linux-amd64"
      sha256 "98646f475558e84489e9c13536f0168d3c573d1582ad417191c84d442ed5e39c"
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
