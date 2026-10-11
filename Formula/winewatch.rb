class Winewatch < Formula
  desc "Menu bar indicator for lingering Wine/CrossOver processes"
  homepage "https://github.com/natbro/wine-watch"
  url "https://github.com/natbro/wine-watch/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0581e64b407e448400898de582ca4dc46cd336413ab1c7757f98299ac522877f"
  # MIT throughout, except Sources/WineWatch/WineGlassPath.swift, whose Bezier
  # control points are traced from the LGPL Wine logo.
  license all_of: ["MIT", "LGPL-2.1-or-later"]
  head "https://github.com/natbro/wine-watch.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on macos: :sonoma

  def install
    # SwiftPM's own sandbox fights Homebrew's, hence SWIFT_FLAGS; the Makefile
    # builds, stamps the version into Info.plist and ad-hoc signs the bundle.
    system "make", "app", "SWIFT_FLAGS=--disable-sandbox"
    prefix.install ".dist/WineWatch.app"
    bin.install_symlink prefix/"WineWatch.app/Contents/MacOS/WineWatch" => "winewatch"
  end

  def caveats
    <<~EOS
      WineWatch is a menu bar app: no Dock icon, no window. Launch it with

        open #{opt_prefix}/WineWatch.app

      and to have it show up in Launchpad and Spotlight

        ln -sfn #{opt_prefix}/WineWatch.app /Applications/WineWatch.app

      Turn on "Launch Automatically at Startup" from WineWatch's own menu
      rather than running it under `brew services`. Both register a login
      item, and WineWatch does not guard against running twice, so you would
      end up with two icons in the menu bar.

      The same binary also works headlessly:

        winewatch --list
        winewatch --kill
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/winewatch --version")

    # Enumerating the process table has to work even where there is no wine:
    # the count line is printed either way.
    assert_match "wine process", shell_output("#{bin}/winewatch --list")
  end
end
