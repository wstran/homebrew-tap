class Ocode < Formula
  desc "Fast, no-frills terminal code reader and editor"
  homepage "https://github.com/wstran/ocode"
  url "https://github.com/wstran/ocode/archive/refs/tags/v1.0.8.tar.gz"
  sha256 "6f3b2b20682576e49333cf4457d4ba8f441f74e2d2d5fed787da1d50109c076d"
  license "MIT"
  head "https://github.com/wstran/ocode.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "ocode #{version}", shell_output("#{bin}/ocode --version")

    # Opening a missing path must fail loudly rather than start the UI.
    (testpath/"hello.rs").write("fn main() {}\n")
    assert_match "does not exist", shell_output("#{bin}/ocode /nonexistent 2>&1", 1)
  end
end
