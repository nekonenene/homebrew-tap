# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class GitBranchDeleteMerged < Formula
  desc "Delete local branches that have been merged (includes \"Squash and merge\")"
  homepage "https://github.com/nekonenene/git-branch-delete-merged-rs"
  version "v1.0.1"
  url "https://github.com/nekonenene/git-branch-delete-merged-rs/archive/refs/tags/#{version}.tar.gz"
  sha256 "40a47b31753f6c30795facb53800e90cc9e3cecc35476630fb7560d33270ac7f"
  license "MIT"

  depends_on "rust" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cargo", "install", *std_cargo_args
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test git-branch-delete-merged`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/git-branch-delete-merged --version"
  end
end
