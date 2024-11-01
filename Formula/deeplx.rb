class Deeplx < Formula
  desc "DeepLX is a permanently free DeepL API client written in Golang."
  homepage "https://github.com/OwO-Network/DeepLX"
  version "0.9.8.2"

  if Hardware::CPU.arm?
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_arm64"
    sha256 "5ff55a39b0a373bf2089f6f9daf62491c0468e5719f92c6a934881e611478dec"
  else
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_amd64"
    sha256 "4285a0689997993fb1045b0535374968030f6c6b0a41a546242330dbd7fe6512"
  end

  def install
    bin.install Dir["deeplx_*"].first => "deeplx"
    (var/"deeplx").mkpath
    (var/"log").mkpath
  end

  def uninstall
    system "brew", "services", "stop", "#{name}" if (var/"log/deeplx.log").exist?
    (var/"log/deeplx.log").unlink if (var/"log/deeplx.log").exist?
    (var/"deeplx").rmtree if (var/"deeplx").exist?
    super
  end

  def post_uninstall
    system "rm", "-rf", "/opt/homebrew/etc/deeplx"
  end

  service do
    run [opt_bin/"deeplx"]
    working_dir var/"deeplx"
    keep_alive true
    log_path var/"log/deeplx.log"
    error_log_path var/"log/deeplx.log"
  end
  
  test do
    system "#{bin}/deeplx", "--version"
  end
end
