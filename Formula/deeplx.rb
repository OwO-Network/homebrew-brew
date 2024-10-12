class Deeplx < Formula
  desc "DeepLX is a permanently free DeepL API client written in Golang."
  homepage "https://github.com/OwO-Network/DeepLX"
  version "0.9.8"

  if Hardware::CPU.arm?
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_arm64"
    sha256 "dced44659fe9d6ca470c4783b4bf5fdf487d17de4bd4deb764427d3bdb30f530"
  else
    url "https://github.com/OwO-Network/DeepLX/releases/download/v#{version}/deeplx_darwin_amd64"
    sha256 "e04d7dab3e68a09f8ab596491cfa27031377a2ad410d4edba8dd806d546baaa8"
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
