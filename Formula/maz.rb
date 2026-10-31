class Maz < Formula
  desc "Local-first system of records for the era of agents"
  homepage "https://github.com/mo-cmyk/mazarbul"
  version "0.2.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.2/mazarbul_v0.2.2_darwin_arm64.tar.gz"
      sha256 "46313ca9be3d5122a7749fcfdc9f3d144057d5563f7e25b1799f9d09324bbc82"
    end
    on_intel do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.2/mazarbul_v0.2.2_darwin_amd64.tar.gz"
      sha256 "a4f8987d1865b3670234fa6a87ab803c630fb2c4ca7c12494a2448c7a3593d4b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.2/mazarbul_v0.2.2_linux_arm64.tar.gz"
      sha256 "e320041176f19c5c23456bcf811a396645fd960d10ae9e54642e79be00e8d4ea"
    end
    on_intel do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.2/mazarbul_v0.2.2_linux_amd64.tar.gz"
      sha256 "e8351a89adac114baab24919ff1edaf738d54c87e0b421dbf8eb734619a2d1db"
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

      If the daemon runs under launchd (maz daemon install), re-run
        maz daemon install
      after every brew upgrade: macOS will not start a replaced binary
      under the old registration (maz doctor flags this as daemon.launchd).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/maz --version")
  end
end
