class Tokens < Formula
  desc "Track and compete on AI coding-assistant token usage"
  homepage "https://tokens.ci"
  version "27.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "2a5b04c9a4f3467f12a169285d1772fdc14cf6df75036e1ad861295d19c54cab"
    end
    on_intel do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "d603cea74385c890d5b6afd814f32f3df3e55e267055574be0f7c9b3d20e59ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "df5ce7a2309eb9e051069760515ae0646984b83d6b87fb346cc3cd803f7c7da3"
    end
    on_intel do
      url "https://github.com/missuo/tokens/releases/download/v#{version}/tokens-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "010f6fde52ed3f4b3dfba2a32adcfca6e730af2c29c67cc3c5b0156e231bd0b7"
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
