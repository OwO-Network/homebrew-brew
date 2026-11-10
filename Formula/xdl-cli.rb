class XdlCli < Formula
  desc "Batch downloader for X/Twitter media: CLI, headless server and MCP"
  homepage "https://github.com/missuo/xdl"
  version "2.1.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-darwin-arm64.tar.gz"
      sha256 "10b4e9f99a58631df5e42bc4c5d3f61ced8a9da739db1d2604ff1909e34410f6"
    end
    on_intel do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-darwin-amd64.tar.gz"
      sha256 "e4df9225fe37794e5ccd0249f432c7bb8ef1013c1e7687f92a7dc6d85b97d8a9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-linux-arm64.tar.gz"
      sha256 "40798edc2fcfef24d77cd13ec88c4dbb87dfa82f1ea33a622735f0b5d56addae"
    end
    on_intel do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-linux-amd64.tar.gz"
      sha256 "09221923e7fb68b70d0b80d37a03ccfa1f5c0f01b652ec1dcfddb51f3fe77230"
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
