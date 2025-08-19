class FixtwitterNosb < Formula
  desc "Background service that automatically replaces X.com links with no.sb in clipboard"
  homepage "https://github.com/missuo/fixtwitter"
  version ""

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/missuo/fixtwitter/releases/download/v1.0.0/fixtwitter-darwin-arm64"
      sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
    else
      url "https://github.com/missuo/fixtwitter/releases/download/v1.0.0/fixtwitter-darwin-amd64"
      sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
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
