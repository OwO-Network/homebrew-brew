class Tokens < Formula
  desc "Track and compete on AI coding-assistant token usage"
  homepage "https://tokens.ci"
  version "27.4.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "3d3ea48d5d924c21ad194bab8f8b5b4976d2c2db19d3e8bf1036a5c8258f6bde"
    end
    on_intel do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "8deaacc1c72cf47f9b28adb53d324c14faba4a72c5b9bfa31beb6be4cd6ff82a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "72063056dd94b532b831485753caeb3340b8c45bbbd6d06f7766925ae0007c68"
    end
    on_intel do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9bf7ab248553bafa2909e403215e2ccef60cd5be4702f67d98c598cc703b19f4"
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
