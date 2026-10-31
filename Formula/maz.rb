class Maz < Formula
  desc "Local-first system of records for the era of agents"
  homepage "https://github.com/mo-cmyk/mazarbul"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.0/mazarbul_v0.2.0_darwin_arm64.tar.gz"
      sha256 "a5e26dc7ab01c887a036a37f1cafa87f6ab37532668bdb57fa136e58b1dfcb1b"
    end
    on_intel do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.0/mazarbul_v0.2.0_darwin_amd64.tar.gz"
      sha256 "9c1c82376a7cd1316378f3d79244d3e74bef36ef2ad08e00353c2eb4483a80cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.0/mazarbul_v0.2.0_linux_arm64.tar.gz"
      sha256 "14b94543c9890a5bcd0b7fa15efb941bde8e81e394a0851979504e37984675eb"
    end
    on_intel do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.0/mazarbul_v0.2.0_linux_amd64.tar.gz"
      sha256 "799e7939e04ddcffcf676c12bd96e667d6541d3d0887b3c5f50524da999d7279"
    end
  end

  def install
    # maz resolves its bundled LadybugDB engine via @loader_path/../lib
    # ($ORIGIN/../lib on Linux), so the lib must sit beside bin/.
    bin.install "maz"
    lib.install Dir["lib/*"]
    man1.install Dir["man/man1/*.1"]
    bash_completion.install "completions/maz.bash" => "maz"
    zsh_completion.install "completions/maz.zsh" => "_maz"
    fish_completion.install "completions/maz.fish"
  end

  def caveats
    <<~EOS
      maz needs a model provider. For local models:
        brew install ollama && ollama serve
        maz init
      Or use a hosted provider:
        maz init --provider anthropic --api-key ...
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/maz --version")
  end
end
