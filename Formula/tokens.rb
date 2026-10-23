class Tokens < Formula
  desc "Track and compete on AI coding-assistant token usage"
  homepage "https://tokens.ci"
  version "27.1.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "7edf89d9f4970fa791ad7142c315f27c705fd124cab7ab45ce4dc92585263a51"
    end
    on_intel do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "eee46901a6c3893df23fec516737c2579366cb33022586f74fc752af3429d835"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c0607eecb70d10283f5c05be7f3c3be1a4e6e60e33a02364055eb78a1e99a3ca"
    end
    on_intel do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6f6220ebbae0f6c55e80cd00283c3357767a3b5a13ee8ebee5f7a07282b4fb74"
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
