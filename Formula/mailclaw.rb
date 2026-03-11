class Mailclaw < Formula
  desc "CLI for interacting with a MailClaw inbox API"
  homepage "https://github.com/missuo/mailclaw"
  version "1.0.0"
  if Hardware::CPU.arm?
    url "https://github.com/missuo/mailclaw/releases/download/v#{version}/mailclaw-v#{version}-aarch64-apple-darwin"
    sha256 "a380f0dd6860181df82730b0ffb40e915dfdb1debc7a8cc21eb0f2b9300704a5"
  else
    url "https://github.com/missuo/mailclaw/releases/download/v#{version}/mailclaw-v#{version}-x86_64-apple-darwin"
    sha256 "631d7b6ee77e200087b89afaba8307f48824f33bcc179c7aaf86f9ff8e041fd0"
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
