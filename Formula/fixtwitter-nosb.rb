class FixtwitterNosb < Formula
  desc "Background service that automatically replaces X.com links with no.sb in clipboard"
  homepage "https://github.com/missuo/fixtwitter"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/missuo/fixtwitter/releases/download/v1.0.0/fixtwitter-darwin-arm64"
      sha256 "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2"
    else
      url "https://github.com/missuo/fixtwitter/releases/download/v1.0.0/fixtwitter-darwin-amd64"
      sha256 "b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2g3"
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "fixtwitter-darwin-arm64" => "fixtwitter-nosb"
    else
      bin.install "fixtwitter-darwin-amd64" => "fixtwitter-nosb"
    end
  end

  service do
    run [opt_bin/"fixtwitter-nosb", "-service", "no.sb"]
    keep_alive true
    log_path var/"log/fixtwitter-nosb.log"
    error_log_path var/"log/fixtwitter-nosb.log"
    process_type :background
  end

  test do
    system "#{bin}/fixtwitter-nosb", "-h"
  end
end
