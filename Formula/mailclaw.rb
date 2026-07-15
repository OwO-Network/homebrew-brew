class Mailclaw < Formula
  desc "CLI for interacting with a MailClaw inbox API"
  homepage "https://github.com/missuo/mailclaw"
  version ""
  if Hardware::CPU.arm?
    url "https://github.com/missuo/mailclaw/releases/download/v#{version}/mailclaw-v#{version}-aarch64-apple-darwin"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  else
    url "https://github.com/missuo/mailclaw/releases/download/v#{version}/mailclaw-v#{version}-x86_64-apple-darwin"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
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
