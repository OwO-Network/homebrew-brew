class Coffer < Formula
  desc "A simple, fast, and secure key-value store"
  homepage "https://github.com/missuo/coffer"
  version "0.0.1"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/coffer/releases/download/v#{version}/coffer-aarch64-apple-darwin"
    sha256 "2a7e4ab6fb6b5de468efda0a59e4020e1c9d388d4b2c0a235a1f7285b0376473"
  else
    url "https://github.com/missuo/coffer/releases/download/v#{version}/coffer-x86_64-apple-darwin"
    sha256 "efa267c126812b1c4039acd06c35efa850909ac39af901aee78d17fa8e39227f"
  end
  license "MIT"

  def install
    if Hardware::CPU.arm?
      bin.install "coffer-aarch64-apple-darwin" => "coffer"
    else
      bin.install "coffer-x86_64-apple-darwin" => "coffer"
    end
  end

  test do
    system "#{bin}/coffer", "--help"
  end
end
