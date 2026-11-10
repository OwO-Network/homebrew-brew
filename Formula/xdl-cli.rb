class XdlCli < Formula
  desc "Batch downloader for X/Twitter media: CLI, headless server and MCP"
  homepage "https://github.com/missuo/xdl"
  version "2.0.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-darwin-arm64.tar.gz"
      sha256 "9ffd1a2990830bf853c55f65af8a92fc49dabd04d9a4ddfef4dfa4431ab026b1"
    end
    on_intel do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-darwin-amd64.tar.gz"
      sha256 "5b013a868e684f25e4b312b1b5ca506b01970633d2b142a97ae90c7af4a4cd1a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-linux-arm64.tar.gz"
      sha256 "47a557031ae9fc85f61d32aa4804a1590dafd9e3813b7e775c309059500a0795"
    end
    on_intel do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-linux-amd64.tar.gz"
      sha256 "14c12954c512d7f53462699b121fe13c87bd4be72d962ee0fc3b8fefbdd24aa1"
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
