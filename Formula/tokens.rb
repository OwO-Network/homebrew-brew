class Tokens < Formula
  desc "Track and compete on AI coding-assistant token usage"
  homepage "https://tokens.ci"
  version "27.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "1a0ace8a110606739e916f9a0913bec4f2642337d80ed1f2a796bd9b4686025b"
    end
    on_intel do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "66400321f3c2e40bf520ea925ab8c32803da8f658cad25af8f4e6e4d387e44b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "47fe14da670099f96f35fe298c8b4f2feb29e9ecc540fc5e39c30a8dafde9ce6"
    end
    on_intel do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "731f2c964cd0d422c47462dc6fd92213ae8b376aa810bbef79caede3f298135f"
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
