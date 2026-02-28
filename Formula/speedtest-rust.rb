class SpeedtestRust < Formula
  desc "Speedtest CLI powered by Apple CDN, written in Rust"
  homepage "https://github.com/missuo/speedtest-rust"
  version "1.0.4"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/speedtest-rust/releases/download/v#{version}/speedtest-darwin-arm64"
    sha256 "480641b0cb8d5b9a9439372e8bc339882cc29de5b82fd8f29c26b548021c44da"
  else
    url "https://github.com/missuo/speedtest-rust/releases/download/v#{version}/speedtest-darwin-amd64"
    sha256 "f670a16f3de2535627b5e9a39c55a318488a2d1028a43e584950004af9823bfe"
  end
  license "MIT"

  def install
    if Hardware::CPU.arm?
      bin.install "speedtest-darwin-arm64" => "speedtest-rust"
    else
      bin.install "speedtest-darwin-amd64" => "speedtest-rust"
    end
  end

  test do
    system "#{bin}/speedtest-rust", "--help"
  end
end
