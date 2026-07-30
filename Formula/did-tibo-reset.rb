# typed: strict
# frozen_string_literal: true

# Builds and runs the Did Tibo Reset menu-bar monitor.
class DidTiboReset < Formula
  desc "Menu bar watcher for Tibo's Codex reset signals"
  homepage "https://github.com/Cirsever/DidTiboReset"
  url "https://github.com/Cirsever/DidTiboReset/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "76d291e991ecb57ad6bb00c9ad5bd60908d97aba9d54cbc953cf6f4c4c09ae33"

  depends_on macos: :ventura
  depends_on "python@3.13"

  def install
    system "./scripts/package_app.sh", buildpath/"Codex Reset Monitor.app"
    prefix.install buildpath/"Codex Reset Monitor.app"
  end

  service do
    run [
      "/usr/bin/open",
      "-W",
      "-n",
      opt_prefix/"Codex Reset Monitor.app",
    ]
    environment_variables({
      CODEX_RESET_MONITOR_PYTHON: formula_opt_bin("python@3.13")/"python3.13",
      PYTHONDONTWRITEBYTECODE:    "1",
    })
    keep_alive true
    process_type :interactive
    log_path var/"log/did-tibo-reset/monitor.log"
    error_log_path var/"log/did-tibo-reset/error.log"
  end

  test do
    assert_path_exists prefix/"Codex Reset Monitor.app/Contents/Info.plist"
    assert_path_exists prefix/"Codex Reset Monitor.app/Contents/Resources/python/codex_reset_monitor/__main__.py"
  end
end
