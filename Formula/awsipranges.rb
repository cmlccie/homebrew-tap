class Awsipranges < Formula
  desc "Quickly query the AWS IP Ranges"
  homepage "https://github.com/cmlccie/awsipranges"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.6.1/awsipranges-aarch64-apple-darwin.tar.xz"
      sha256 "df9bbb20074a348409298dc9840fb6a7febf700fa35cb358b667c91232995c87"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.6.1/awsipranges-x86_64-apple-darwin.tar.xz"
      sha256 "0b489b3f994ddbefbb58c58ea93c9217e4acfbd8cd334af23c709ce0746cd644"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.6.1/awsipranges-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4f4f7f5349fa4a6bba184be0f21afbf0b3999f9edde4bd9783c99e1825ce5e87"
    end
  end
  license "BSD-2-Clause-Patent"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "awsipranges"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "awsipranges"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "awsipranges"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
