class Remember < Formula
  desc "Local personal second brain backed by SQLite and FTS5 full-text search"
  homepage "https://github.com/itayavtalyon/remember"
  url "https://github.com/itayavtalyon/remember/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "3a72bc46b2915c93feda211c582f15655e0ca8e62f4e2c42311f6b42d4f777ac"
  license "MIT"
  head "https://github.com/itayavtalyon/remember.git", branch: "main"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      Homebrew cannot write into ~/.claude, ~/.grok, or ~/.cursor.

      After install (and after adding a new agent product), symlink the skill:
        remember-install-skill
    EOS
  end

  test do
    assert_match "remember #{version}", shell_output("#{bin}/remember --version")

    db = testpath/"remember.db"
    system bin/"remember", "add", "hello from brew test", "--db", db
    assert_match "hello from brew test", shell_output("#{bin}/remember list --db #{db}")

    (testpath/".claude").mkpath
    with_env(HOME: testpath) do
      system bin/"remember-install-skill"
    end
    skill = testpath/".claude/skills/remember/SKILL.md"
    assert_predicate skill, :symlink?
    assert_path_exists skill
  end
end
