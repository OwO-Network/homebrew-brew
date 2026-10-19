class Deeplx < Formula
  desc "DeepLX is a permanently free DeepL API client written in Golang."
  homepage "https://github.com/OwO-Network/DLX"
  version "1.3.1"

  if Hardware::CPU.arm?
    url "https://github.com/OwO-Network/DLX/releases/download/v#{version}/deeplx_darwin_arm64"
    sha256 "e57b4398ecf3c54df55aca0cbe559e561b07ecbd106850ec98b977f0ef9f0a14"
  else
    url "https://github.com/OwO-Network/DLX/releases/download/v#{version}/deeplx_darwin_amd64"
    sha256 "7d815976de19a49d307ba6b304f872586acd2d4de663d58f61eb3dd56a88cfaf"
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
