class FixtwitterNosb < Formula
  desc "Background service that automatically replaces X.com links with no.sb in clipboard"
  homepage "https://github.com/missuo/fixtwitter"
  version "1.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/missuo/fixtwitter/releases/download/v#{version}/fixtwitter-darwin-arm64"
      sha256 "39286f9bcafa0b5fc495ac48f473dac91481d4ce5fdad287b80d43820b4717ae"
    else
      url "https://github.com/missuo/fixtwitter/releases/download/v#{version}/fixtwitter-darwin-amd64"
      sha256 "e2bc0c601a496d482956df39fcc43068e07e5c57443dbd6ac0f099750ed8af6d"
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
