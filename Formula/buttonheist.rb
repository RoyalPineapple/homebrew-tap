class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.2"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.2/buttonheist-0.2.2-macos.tar.gz"
  sha256 "eed8a169f6e100e4fa99b71e2a39877e9bd3f0fdd41dd4bca495e2ea2c5366c0"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.2/buttonheist-mcp-0.2.2-macos.tar.gz"
    sha256 "c251a0ab1e8e06b97d973c81a8fb9873b67915cd09dbbc6d418e9a25d045dcb3"
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
