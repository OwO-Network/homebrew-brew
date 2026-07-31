class KasumiClient < Formula
  desc "Local SOCKS5 + HTTP proxy for the Kasumi anti-censorship protocol"
  homepage "https://github.com/missuo/kasumi-releases"
  version "0.0.2"

  on_macos do
    on_arm do
      url "https://github.com/missuo/kasumi-releases/releases/download/v#{version}/kasumi-v#{version}-darwin-arm64.tar.gz"
      sha256 "15f102828936fbac195a785c592d77063dd441266b1f0f78138478f851631eff"
    end
    on_intel do
      url "https://github.com/missuo/kasumi-releases/releases/download/v#{version}/kasumi-v#{version}-darwin-amd64.tar.gz"
      sha256 "383a10e9f2b34c3dc36b30621628c55bf5b286b8cfa591d98ff82e6016c95d85"
    end
  end

  def install
    bin.install "kasumi-client"
    (etc/"kasumi").mkpath
    # Write a default config only if the user has none, so upgrades never clobber it.
    unless (etc/"kasumi/client.yaml").exist?
      (etc/"kasumi/client.yaml").write <<~YAML
        server: "YOUR_SERVER_IP:80"   # your Kasumi server host:port
        psk: "YOUR_PSK"               # the shared secret, same as the server
        listen: "127.0.0.1:2333"      # SOCKS5 + HTTP on one port (use 0.0.0.0 to share on the LAN)
        tfo: off                      # off | auto | on
      YAML
    end
    (var/"log").mkpath
  end

  service do
    run [opt_bin/"kasumi-client", "-c", etc/"kasumi/client.yaml"]
    keep_alive true
    log_path var/"log/kasumi-client.log"
    error_log_path var/"log/kasumi-client.log"
  end

  def caveats
    <<~EOS
      kasumi-client runs a local SOCKS5 + HTTP proxy (default 127.0.0.1:2333).
      Tools that don't speak the Kasumi protocol (Surge, etc.) point at that
      local SOCKS5 port.

      1. Edit your config (set server + psk):
           #{etc}/kasumi/client.yaml
      2. Start it and keep it running in the background:
           brew services start kasumi-client
      3. Point your tool at the local SOCKS5. In Surge, for example:
           Kasumi = socks5, 127.0.0.1, 2333

      Logs: #{var}/log/kasumi-client.log
    EOS
  end

  test do
    assert_match "kasumi-client", shell_output("#{bin}/kasumi-client -version")
  end
end
