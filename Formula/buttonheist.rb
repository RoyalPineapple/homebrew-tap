class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.31"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.31/buttonheist-0.2.31-macos.tar.gz"
  sha256 "53bd9606cd1a0c2a7310f833f52c996b2bf14d522f16a2f369851cf4adb1ad93"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.31/buttonheist-mcp-0.2.31-macos.tar.gz"
    sha256 "ead6cb1ed8a2b8cf1c7a20448318254b413cc65c5b443a649f63972b2036f538"
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
