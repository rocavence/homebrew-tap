cask "gamely" do
  version "0.5.1"
  sha256 "b39d0b91a7314a23ddbdce4de74f84ee723e49737ab09886d5e0255d48a27e13"

  url "https://github.com/rocavence/Gamely-app/releases/download/v#{version}/Gamely-#{version}.zip"
  name "Gamely"
  desc "Pauses Hot Corners while Game Mode is on"
  homepage "https://gamely.rocavence.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Gamely.app"

  # Not notarized by Apple: remove the quarantine flag so the first launch isn't blocked.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Gamely.app"]
  end

  # Quitting Gamely puts the user's Hot Corners back if they're paused.
  uninstall quit: "com.gamely.app"

  zap trash: "~/Library/Preferences/com.gamely.app.plist"
end
