class SpeedtestRust < Formula
  desc "Speedtest CLI powered by Apple CDN, written in Rust"
  homepage "https://github.com/missuo/speedtest-rust"
  version "1.0.5"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/speedtest-rust/releases/download/v#{version}/speedtest-darwin-arm64"
    sha256 "ac526f62615941920f73ff6db5b1507c18dbc278bd05aeb7891647bff136adae"
  else
    url "https://github.com/missuo/speedtest-rust/releases/download/v#{version}/speedtest-darwin-amd64"
    sha256 "7ec10a748ee80030daad77ad83f0a7752f20d0c0c25c4da210083a270bf1145d"
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
