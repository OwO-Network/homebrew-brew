class Mailclaw < Formula
  desc "CLI for interacting with a MailClaw inbox API"
  homepage "https://github.com/missuo/mailclaw"
  version "1.0.2"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/mailclaw/releases/download/v#{version}/mailclaw-v#{version}-aarch64-apple-darwin"
    sha256 "90e04d0e0e84e5c749dd6f5deb95331a8b532bb2ec4afbfb48c7ac59f3ccec32"
  else
    url "https://github.com/missuo/mailclaw/releases/download/v#{version}/mailclaw-v#{version}-x86_64-apple-darwin"
    sha256 "86394765330bdca15f0e62584d01f591641150875a902f9ec569f65b002954dc"
  end
  license "MIT"

  def install
    if Hardware::CPU.arm?
      bin.install "mailclaw-v#{version}-aarch64-apple-darwin" => "mailclaw"
    else
      bin.install "mailclaw-v#{version}-x86_64-apple-darwin" => "mailclaw"
    end
  end

  test do
    system "#{bin}/mailclaw", "--help"
  end
end
