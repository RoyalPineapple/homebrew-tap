class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.17"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.17/buttonheist-0.2.17-macos.tar.gz"
  sha256 "ff889d1ab9dc4723d16c44f6dbc0f366e9a4e8aadbe8c17ff27bb66b78f4273a"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.17/buttonheist-mcp-0.2.17-macos.tar.gz"
    sha256 "f2e4ab8961d2bbcc867d62cf6a6e5c499280084ec2592e17ecde9825a3f805ea"
  end

  depends_on :macos
  depends_on macos: :sonoma

  def install
    bin.install "buttonheist"
    bin.install "ButtonHeistFrameworks" if (buildpath/"ButtonHeistFrameworks").exist?
    resource("mcp").stage { bin.install "buttonheist-mcp" }
  end

  def caveats
    <<~EOS
      To integrate Button Heist into your iOS app:

        cd /path/to/your-ios-project
        buttonheist integrate

      MCP server is installed at:
        #{opt_bin}/buttonheist-mcp

      Add to your project's .mcp.json:
        {
"mcpServers": {
  "buttonheist": {
    "command": "#{opt_bin}/buttonheist-mcp",
    "args": []
  }
}
        }
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/buttonheist --version")
  end
end
