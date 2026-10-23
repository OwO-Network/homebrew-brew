class Tokens < Formula
  desc "Track and compete on AI coding-assistant token usage"
  homepage "https://tokens.ci"
  version "27.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "b098d236d6d4c25ff3671dfc18ccd1d4dab45f0ed11a8473cec6d2ff60b1c56c"
    end
    on_intel do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "704644fa9416ee8b9ee46329ecef430098d5ab1b365dc1e4ae4c8065adf8f5ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "99e168f783eca29e7d239e33edd7237c11560ee7ea17175e4cd98b3e645631f7"
    end
    on_intel do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "486c1ccb85b408cd290b8449483491e1d2d22083e25af09cff44db3b7611ae35"
    end
  end

  def install
    bin.install "tokens"
    (var/"log").mkpath
  end

  # `tokens serve` runs in the background and auto-submits usage on an interval
  # (default 30 min, override with TOKENS_SUBMIT_INTERVAL). Homebrew renders this
  # to a launchd plist (macOS) or systemd unit (Linuxbrew) and keeps it alive.
  service do
    run [opt_bin/"tokens", "serve"]
    keep_alive true
    run_at_load true
    log_path var/"log/tokens.log"
    error_log_path var/"log/tokens.log"
  end

  def caveats
    <<~EOS
      Authenticate once, then start the background submit service:
        tokens login
        brew services start tokens

      The service runs `tokens serve`, submitting your usage on an interval
      (default 30 min; override with TOKENS_SUBMIT_INTERVAL). Logs:
        #{var}/log/tokens.log
    EOS
  end

  test do
    system "#{bin}/tokens", "--version"
  end
end
