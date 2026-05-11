class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.25"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.25/buttonheist-0.2.25-macos.tar.gz"
  sha256 "4bc33c8aaa20b29116ab12a22df07414aa13dc711957c05e35700760644127a6"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.25/buttonheist-mcp-0.2.25-macos.tar.gz"
    sha256 "e84a754226c6d81f99933714166e0fb2dead8135fd5701adf6e2169ee8a622a1"
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
