class Deeplx < Formula
  desc "DeepLX is a permanently free DeepL API client written in Golang."
  homepage "https://github.com/OwO-Network/DLX"
  version "1.2.4"

  if Hardware::CPU.arm?
    url "https://github.com/OwO-Network/DLX/releases/download/v#{version}/deeplx_darwin_arm64"
    sha256 "577187f28886a4c15d214cc8af6f5f4e4d96755054029d297a0e0ab49ae510d1"
  else
    url "https://github.com/OwO-Network/DLX/releases/download/v#{version}/deeplx_darwin_amd64"
    sha256 "7c1192581055bf1a353734714ac43fa84e38e025c7a61501ff24c947672a13c2"
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
