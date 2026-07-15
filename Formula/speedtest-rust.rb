class SpeedtestRust < Formula
  desc "Speedtest CLI powered by Apple CDN, written in Rust"
  homepage "https://github.com/missuo/speedtest-rust"
  version ""
  if Hardware::CPU.arm?
    url "https://github.com/missuo/speedtest-rust/releases/download/v#{version}/speedtest-darwin-arm64"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  else
    url "https://github.com/missuo/speedtest-rust/releases/download/v#{version}/speedtest-darwin-amd64"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
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
