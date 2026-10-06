cask "wunder" do
  version "0.5.5"
  sha256 "f9f40765cebe702a7e3002e36939a3481436a30867567cebc57a5cdc0c40c515"

  url "https://github.com/rocavence/Wunderkammer/releases/download/v#{version}/Wunder.zip"
  name "Wunder"
  desc "Cabinet of curiosities: collect anything, organize nothing"
  homepage "https://wunder.rocavence.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Wunder.app"

  # Signed ad hoc, not notarized: let it open without the "unidentified developer" stop.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Wunder.app"]
  end

  zap trash: [
    "~/Library/Application Support/Wunderkammer",
    "~/Library/Caches/com.rocavence.wunderkammer",
    "~/Library/Preferences/com.rocavence.wunderkammer.plist",
  ]
end
