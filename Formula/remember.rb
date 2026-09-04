class Remember < Formula
  desc "Local personal second brain backed by SQLite and FTS5 full-text search"
  homepage "https://github.com/itayavtalyon/remember"
  url "https://github.com/itayavtalyon/remember/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8795c8f9a1840508434c8c376a4919599ce246d24623ae8a1882f85735b4b31d"
  license "MIT"
  head "https://github.com/itayavtalyon/remember.git", branch: "main"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DCMAKE_BUILD_TYPE=Release"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "remember #{version}", shell_output("#{bin}/remember --version")

    db = testpath/"remember.db"
    system bin/"remember", "add", "hello from brew test", "--db", db
    assert_match "hello from brew test", shell_output("#{bin}/remember list --db #{db}")
  end
end
