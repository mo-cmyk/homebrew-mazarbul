class Maz < Formula
  desc "Local-first system of records for the era of agents"
  homepage "https://github.com/mo-cmyk/mazarbul"
  version "0.2.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.3/mazarbul_v0.2.3_darwin_arm64.tar.gz"
      sha256 "a326ecef4f5ea38465a2bdf8cbd045039d5ad0f60a3b1865ee087cb444825ba2"
    end
    on_intel do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.3/mazarbul_v0.2.3_darwin_amd64.tar.gz"
      sha256 "7ed78f2035eb70dfa177f85b7b04d5ff32ae14f5cdb8bdb842d61ce2035a9150"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.3/mazarbul_v0.2.3_linux_arm64.tar.gz"
      sha256 "05329aeb3e4cc4318487a95e81303efc98e855a590e19dc46c67aa11a0d1c5d7"
    end
    on_intel do
      url "https://github.com/mo-cmyk/mazarbul/releases/download/v0.2.3/mazarbul_v0.2.3_linux_amd64.tar.gz"
      sha256 "1656059ed09c165edfddebf4a3a231af5fd5b055a77ee34a497e262f8f70c665"
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
