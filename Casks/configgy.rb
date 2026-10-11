cask "configgy" do
  version "1.0.0"
  sha256 "5143974f63c058f33f975d14103f6cff9ba4880eafad62ec518fc98afe0b2308"

  url "https://github.com/rocavence/Configgy-app/releases/download/v#{version}/Configgy-#{version}.zip"
  name "Configgy"
  desc "Backs up and restores app settings to your cloud folder"
  homepage "https://configgy.rocavence.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Configgy.app"

  # Not notarized by Apple: remove the quarantine flag so the first launch isn't blocked.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Configgy.app"]
  end

  uninstall quit: "com.rocavence.configgy"

  # Backups in your cloud folder are yours and stay put.
  zap trash: [
    "~/Library/Application Support/Configgy",
    "~/Library/Logs/Configgy",
  ]
end
