cask "flione" do
  arch arm: "AppleSilicon", intel: "Intel"

  version "0.9.84"
  sha256 arm:   "34e09ff152b8928fa089b5e91d03a390a1f4d04b6b7a99470078dff8e45c58f6",
         intel: "a236eef07c3260f246a5130d1bfff8e435757a855ff6d29f9581f9928f04b252"

  url "https://github.com/rocavence/Flione-app/releases/download/v#{version}/Flione-#{version}-#{arch}.dmg",
      verified: "github.com/rocavence/Flione-app/"
  name "Flione"
  desc "Music player for Jellyfin and YouTube Music"
  homepage "https://flione.rocavence.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Flione.app"

  # Not notarized by Apple: remove the quarantine flag so the first launch isn't blocked.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Flione.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.rocavence.Flione",
    "~/Library/Caches/com.rocavence.Flione",
    "~/Library/HTTPStorages/com.rocavence.Flione",
    "~/Library/HTTPStorages/com.rocavence.Flione.binarycookies",
    "~/Library/Preferences/com.rocavence.Flione.plist",
    "~/Library/Saved Application State/com.rocavence.Flione.savedState",
    "~/Library/WebKit/com.rocavence.Flione",
  ]
end
