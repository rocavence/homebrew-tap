cask "findly" do
  version "1.0.0"
  sha256 "615b22aed2194f5fb3f6192274246ff9563939c52d42d5a245642a740da0f4e4"

  url "https://github.com/rocavence/Findly-app/releases/download/v#{version}/Findly-#{version}.zip"
  name "Findly"
  desc "Finder-style file drawer that slides in from any screen edge"
  homepage "https://findly.rocavence.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Findly.app"

  # Not notarized by Apple: remove the quarantine flag so the first launch isn't blocked.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Findly.app"]
  end

  uninstall quit: "com.findly.app"

  zap trash: "~/Library/Preferences/com.findly.app.plist"
end
