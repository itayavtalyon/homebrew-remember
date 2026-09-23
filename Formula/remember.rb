class Remember < Formula
  desc "Local personal second brain backed by SQLite and FTS5 full-text search"
  homepage "https://github.com/itayavtalyon/remember"
  url "https://github.com/itayavtalyon/remember/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "15cd287a2fe4e0ca9da44332e7eab2aeb37f0485e946bf7e2f5c6d6bc652e0b5"
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
