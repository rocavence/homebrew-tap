cask "gamely" do
  version "0.9.0"
  sha256 "2659506d340eec7d345797ee672a25d954e125251f07a37f02fec0f51d52cc52"

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
