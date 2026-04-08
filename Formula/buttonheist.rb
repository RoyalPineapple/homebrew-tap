class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.6"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.6/buttonheist-0.2.6-macos.tar.gz"
  sha256 "092c3dba9f6956317151833f4b98cb27636670b7d4fb7a1e2eb2cd2453bf1388"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.6/buttonheist-mcp-0.2.6-macos.tar.gz"
    sha256 "d63c74a71db801b741f8ef2d49368b734d8c5f8697af6a6a3a3cde2849404cbc"
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
