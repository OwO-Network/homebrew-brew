class FixtwitterNosb < Formula
  desc "Background service that automatically replaces X.com links with no.sb in clipboard"
  homepage "https://github.com/missuo/fixtwitter"
  version "1.0.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/missuo/fixtwitter/releases/download/v#{version}/fixtwitter-darwin-arm64"
      sha256 "f76110049c15ddfb9533e7632818691169649f7230d9b657a7ca2e87acf50991"
    else
      url "https://github.com/missuo/fixtwitter/releases/download/v#{version}/fixtwitter-darwin-amd64"
      sha256 "96afbd65d09c59315eab9a701b5432b26b941ec1aba68fd84d1565cc6cd4cd1c"
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
