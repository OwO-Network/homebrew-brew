class XdlCli < Formula
  desc "Batch downloader for X/Twitter media: CLI, headless server and MCP"
  homepage "https://github.com/missuo/xdl"
  version "2.3.1"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-darwin-arm64.tar.gz"
      sha256 "093dfb2dded92143bbf49844a3dbba0d11ca1bb651b5476d1ee5f5db0666a072"
    end
    on_intel do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-darwin-amd64.tar.gz"
      sha256 "7ba6dc1c958d3824b5494305fa8ac23fa4114e78b7b4033d10920e0e65ff01cf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-linux-arm64.tar.gz"
      sha256 "a285d93b158ca573926350f67e5010e1862bc18449b3780497ed92223d7e6c5d"
    end
    on_intel do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-linux-amd64.tar.gz"
      sha256 "10960d7fc1f238e27abaddbb5ddc4137739252f17f222b298e8779ce097e7f78"
    end
  end

  def install
    bin.install "xdl"
    (var/"log").mkpath
  end

  # `xdl serve`: the job queue, subscriptions, the API on 127.0.0.1:47333
  # (for the browser extension and the CLI) and MCP, without the app.
  # Homebrew renders it to a launchd plist (macOS) or a systemd unit (Linux).
  service do
    run [opt_bin/"xdl", "serve"]
    keep_alive true
    log_path var/"log/xdl.log"
    error_log_path var/"log/xdl.log"
  end

  def caveats
    <<~EOS
      Set up once:
        xdl token set               # the auth_token cookie of x.com
        xdl deps install xtractor   # the timeline extractor

      Then download:
        xdl download <user>
        xdl sub add <user> 1d       # check it every day

      Run the queue and subscriptions in the background (the extension and
      AI agents reach it on 127.0.0.1:47333):
        brew services start xdl-cli

      The XDL app (brew install --cask owo-network/brew/xdl) includes this
      command: install one or the other.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xdl version")
  end
end
