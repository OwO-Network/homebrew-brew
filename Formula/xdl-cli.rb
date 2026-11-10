class XdlCli < Formula
  desc "Batch downloader for X/Twitter media: CLI, headless server and MCP"
  homepage "https://github.com/missuo/xdl"
  version "2.3.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-darwin-arm64.tar.gz"
      sha256 "e59eb5df28259c20f98dcf933ca06d3a8d380b9d46455de7ed0714360854623a"
    end
    on_intel do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-darwin-amd64.tar.gz"
      sha256 "66150c00eddc478dd07b7beed8cd31cc1297d24382c219d3ad77b2467ded4092"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-linux-arm64.tar.gz"
      sha256 "91f385ccd3fbdc3a9b5e02e60a5463264e06d7109021a032a314c8c56577a6d0"
    end
    on_intel do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-linux-amd64.tar.gz"
      sha256 "a30fb35cc07152e185e31b59ad262a3ada567d750c9bf61546f838a21211fe92"
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
