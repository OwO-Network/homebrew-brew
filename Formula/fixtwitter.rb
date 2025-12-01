class Fixtwitter < Formula
  desc "Background service that automatically replaces X.com links with fxtwitter.com in clipboard"
  homepage "https://github.com/missuo/fixtwitter"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/missuo/fixtwitter/releases/download/v#{version}/fixtwitter-darwin-arm64"
      sha256 "28f9ca7d83028334c9ea6e70e76c379c4ad61a8fe4ce75145cd385c68ec56b6e"
    else
      url "https://github.com/missuo/fixtwitter/releases/download/v#{version}/fixtwitter-darwin-amd64"
      sha256 "ae73606df76b98d617f5da8ceba4db76d86242fe42c85cb8e798fa2bb99f80fe"
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "fixtwitter-darwin-arm64" => "fixtwitter"
    else
      bin.install "fixtwitter-darwin-amd64" => "fixtwitter"
    end
  end

  service do
    run [opt_bin/"fixtwitter"]
    keep_alive true
    log_path var/"log/fixtwitter.log"
    error_log_path var/"log/fixtwitter.log"
    process_type :background
  end

  test do
    system "#{bin}/fixtwitter", "-h"
  end
end
