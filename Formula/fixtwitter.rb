class Fixtwitter < Formula
  desc "Background service that automatically replaces X.com links with fxtwitter.com in clipboard"
  homepage "https://github.com/missuo/fixtwitter"
  version ""

  on_macos do
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
      url "https://github.com/missuo/fixtwitter/releases/download/v1.0.0/fixtwitter-darwin-arm64"
      sha256 "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
      url "https://github.com/missuo/fixtwitter/releases/download/v1.0.0/fixtwitter-darwin-amd64"
      sha256 "b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2g3"
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
