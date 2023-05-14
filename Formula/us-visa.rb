class UsVisa < Formula
    desc "A tool for checking US visa wait times"
    homepage "https://github.com/missuo/USVisaWaitTimes"
    version "0.0.2"
    if Hardware::CPU.arm?
        url "https://github.com/missuo/USVisaWaitTimes/releases/download/v#{version}/us-visa_darwin_arm64"
        sha256 "d60a4197860ff70d8a43853e1ab52d5d6ddb7be77212a4b3046db52e07b20c0b"
      else
        url "https://github.com/missuo/USVisaWaitTimes/releases/download/v#{version}/us-visa_darwin_amd64"
        sha256 "9334980b0584d77fdd5b6a3969be666b98bc7a4c9307739eb3688650edb249cb"
      end
    
      def install
        binary_name = if Hardware::CPU.arm?
          "us-visa_darwin_arm64"
        else
          "us-visa_darwin_amd64"
        end
    
        bin.install binary_name => "us-visa"
      end
  end
  
