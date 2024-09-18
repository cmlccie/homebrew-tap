class Awsipranges < Formula
  desc "Quickly query the AWS IP Ranges"
  homepage "https://github.com/cmlccie/awsipranges"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.8.0/awsipranges-aarch64-apple-darwin.tar.xz"
      sha256 "7ddbf65147ccd2a999337230903fe5c4247aaebc8d76e3449a0380ad416dbee2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.8.0/awsipranges-x86_64-apple-darwin.tar.xz"
      sha256 "078c1f84e009d40114d664b88b8e0bd839a6103fa219e5f90b23447b318d1a5e"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/cmlccie/awsipranges/releases/download/v0.8.0/awsipranges-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d6a957d4488521d80fa5dce6547ca0792924e9f2f3c63b5e4b15ea391446d8c4"
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
