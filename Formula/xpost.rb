class Xpost < Formula
  desc "A command-line tool and HTTP API for posting to X (Twitter)"
  homepage "https://github.com/missuo/xpost"
  version ""
  if Hardware::CPU.arm?
    url "https://github.com/missuo/xpost/releases/download/v#{version}/xpost-darwin-arm64"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  else
    url "https://github.com/missuo/xpost/releases/download/v#{version}/xpost-darwin-amd64"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
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
