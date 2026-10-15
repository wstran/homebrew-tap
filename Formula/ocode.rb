class Ocode < Formula
  desc "Fast, no-frills terminal code reader and editor"
  homepage "https://github.com/wstran/ocode"
  url "https://github.com/wstran/ocode/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "3d7efda67056419d094d79cb47f923faf4a26c3d264351a27a02cb2eda78f071"
  license "MIT"
  head "https://github.com/wstran/ocode.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      Lean 4 files get errors, goals, completion and suggestions from Lean
      itself, which is installed on its own:
        brew install elan-init && elan default stable
      For mathematics with Mathlib, see:
        https://github.com/wstran/ocode#getting-lean-and-mathlib
    EOS
  end

  test do
    assert_match "ocode #{version}", shell_output("#{bin}/ocode --version")

    # Opening a missing path must fail loudly rather than start the UI.
    (testpath/"hello.rs").write("fn main() {}\n")
    assert_match "does not exist", shell_output("#{bin}/ocode /nonexistent 2>&1", 1)
  end
end
