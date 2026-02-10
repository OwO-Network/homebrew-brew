class Xpost < Formula
  desc "A command-line tool and HTTP API for posting to X (Twitter)"
  homepage "https://github.com/missuo/xpost"
  version "0.0.5"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/xpost/releases/download/v#{version}/xpost-darwin-arm64"
    sha256 "567c7180ce7d1002024ed7f4aa1c4aa8075c8e3101f115d61e0c6f754e64fe3a"
  else
    url "https://github.com/missuo/xpost/releases/download/v#{version}/xpost-darwin-amd64"
    sha256 "b68b253e345edaf530e80130b5c9f09fcdd77eede8fc17ea922180adaa6a2cf6"
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
