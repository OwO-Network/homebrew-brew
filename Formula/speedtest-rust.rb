class SpeedtestRust < Formula
  desc "Speedtest CLI powered by Apple CDN, written in Rust"
  homepage "https://github.com/missuo/speedtest-rust"
  version "1.0.3"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/speedtest-rust/releases/download/v#{version}/speedtest-darwin-arm64"
    sha256 "4c0a7d7f8d416447f0054bc786175e8f82573c1d2b00da48d2a1c491db3ef7ff"
  else
    url "https://github.com/missuo/speedtest-rust/releases/download/v#{version}/speedtest-darwin-amd64"
    sha256 "1fc40cea364523ad4e434405982ffc07a659e1fdd6459d515339e44bca66bae5"
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
