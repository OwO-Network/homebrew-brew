class Xpost < Formula
  desc "A command-line tool and HTTP API for posting to X (Twitter)"
  homepage "https://github.com/missuo/xpost"
  version "0.0.6"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/xpost/releases/download/v#{version}/xpost-darwin-arm64"
    sha256 "d9f2fa0b1a0948cfe0a9cb25389c7a86465b6dadb53075ffdefaba5b5cda92c4"
  else
    url "https://github.com/missuo/xpost/releases/download/v#{version}/xpost-darwin-amd64"
    sha256 "6798abc263a2d6191b691ec982bd7cc4cb4b23f664429236b37d58ea3ea8ddcf"
  end
  license "Apache-2.0"

  def install
    if Hardware::CPU.arm?
      bin.install "xpost-darwin-arm64" => "xpost"
    else
      bin.install "xpost-darwin-amd64" => "xpost"
    end
  end

  test do
    system "#{bin}/xpost", "help"
  end
end
