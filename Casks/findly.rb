cask "findly" do
  version "1.0.0"
  sha256 "d04bcceea78d7ed9b1aac9bf262c200f736503c26d14497911931e04adbb2630"

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
