# typed: strict
# frozen_string_literal: true

# Builds and runs the Did Tibo Reset menu-bar monitor.
class DidTiboReset < Formula
  desc "Menu bar watcher for Tibo's Codex reset signals"
  homepage "https://github.com/Cirsever/DidTiboReset"
  url "https://github.com/Cirsever/DidTiboReset/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "c520b8aa2573df09dd4a96d0a4f73223ec862f094e15808770eb806e341a4bd2"

  depends_on macos: :ventura
  depends_on "python@3.13"

  def install
    system "./scripts/package_app.sh", buildpath/"Codex Reset Monitor.app"
    prefix.install buildpath/"Codex Reset Monitor.app"
    libexec.install "scripts/homebrew_service.sh"
  end

  service do
    run [
      opt_libexec/"homebrew_service.sh",
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
    assert_predicate libexec/"homebrew_service.sh", :executable?
  end
end
