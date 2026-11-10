class XdlCli < Formula
  desc "Batch downloader for X/Twitter media: CLI, headless server and MCP"
  homepage "https://github.com/missuo/xdl"
  version "2.2.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-darwin-arm64.tar.gz"
      sha256 "764de5c6ab4f5b11ac8caf12957b2aca0278c1d681442ef911af1593849993a4"
    end
    on_intel do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-darwin-amd64.tar.gz"
      sha256 "255d78949d28388b07349df4da99705c6ba7621bf620d4e473111ee7cc76a9db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-linux-arm64.tar.gz"
      sha256 "c2f544e2d92fd99f19abb1ab333f81f1ac0f32c5afdb605e72d414a548a969d0"
    end
    on_intel do
      url "https://github.com/missuo/xdl/releases/download/v#{version}/xdl-cli-#{version}-linux-amd64.tar.gz"
      sha256 "21bee9fb372b83f4cf1ebf4241415e1eba0a8d2e0b60f4a0a299ca7136e0cca4"
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
